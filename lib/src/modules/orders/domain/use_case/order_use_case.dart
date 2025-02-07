import 'package:core_y/core_y.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

import '../repository/order_repository.dart';

@immutable
class OrderUseCase {
  const OrderUseCase({required this.orderRepository});

  /// The repository used to interact with order data.
  final OrderRepository orderRepository;

  /// Fetches all orders from the repository.
  ///
  /// Returns a [Result] containing either:
  /// - A [List<Order>] on success
  /// - An [AppException] on failure
  ///
  /// The repository will attempt to fetch orders from the remote data source.
  /// If the request fails, it will return a [Failure] with an [AppException].
  AsyncOrders getOrders() => orderRepository.getOrders();
}

final orderUseCaseProvider = Provider<OrderUseCase>((ref) {
  final orderRepository = ref.watch(orderRepositoryProvider);

  return OrderUseCase(orderRepository: orderRepository);
});
