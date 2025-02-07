import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/order.dart';
import '../../domain/repository/order_repository.dart';
import '../../domain/use_case/order_use_case.dart';

/// A provider that fetches orders using the order use case.
final ordersProvider = FutureProvider<Orders>((ref) async {
  final useCase = ref.watch(orderUseCaseProvider);

  final orders = await useCase.getOrders();

  return orders.fold(
    onSuccess: (orders) => orders,
    onFailure: (failure) => throw failure,
  );
});

/// A provider that groups orders by their formatted creation date.
final groupedOrdersProvider = FutureProvider<Map<String, Orders>>((ref) async {
  final orders = ref.watch(ordersProvider).valueOrNull ?? [];

  return groupBy(orders, (order) => order.formattedCreatedAt);
});

/// A provider that must be overridden by the SliverList at runtime.
/// Using to optimize rebuilds.
final scopedOrderProvider = Provider<Order>((ref) => throw UnimplementedError());
