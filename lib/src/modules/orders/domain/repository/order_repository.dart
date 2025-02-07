import 'package:core_y/core_y.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/data_sources/remote_data_source.dart';
import '../../data/repository/order_repository.dart';
import '../entity/order.dart';

typedef Orders = List<Order>;
typedef AsyncOrders = Future<Result<Orders, AppException>>;

/// Contract via which we talk with the outside world.
///
/// Should be implemented by the data layer.
abstract class OrderRepository {
  /// Fetches all orders from the data source.
  ///
  /// Returns a [Result] containing either:
  /// - A [List<Order>] on success
  /// - An [AppException] on failure
  AsyncOrders getOrders();
}

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  final remoteDataSource = ref.watch(orderRemoteDataSourceProvider);
  return OrderRepositoryImpl(remoteDataSource: remoteDataSource);
});
