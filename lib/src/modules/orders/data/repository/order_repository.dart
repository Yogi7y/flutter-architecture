import 'package:core_y/core_y.dart';

import '../../domain/repository/order_repository.dart';
import '../data_sources/remote_data_source.dart';

class OrderRepositoryImpl implements OrderRepository {
  OrderRepositoryImpl({required this.remoteDataSource});

  final OrderRemoteDataSource remoteDataSource;

  @override
  AsyncOrders getOrders() async {
    try {
      final result = await remoteDataSource.getOrders();

      return Success(result);
    } catch (exception, stackTrace) {
      return Failure(AppException(stackTrace: stackTrace, exception: exception));
    }
  }
}
