import 'package:core_y/core_y.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:orders/src/modules/orders/domain/entity/merchant.dart';
import 'package:orders/src/modules/orders/domain/entity/order.dart';
import 'package:orders/src/modules/orders/domain/entity/order_status.dart';
import 'package:orders/src/modules/orders/domain/entity/payment_product_type.dart';
import 'package:orders/src/modules/orders/domain/repository/order_repository.dart';
import 'package:orders/src/modules/orders/domain/use_case/order_use_case.dart';

import '../../data/models/order_model_test.dart';

class MockOrderRepository extends Mock implements OrderRepository {}

void main() {
  late MockOrderRepository mockRepository;
  late OrderUseCase systemUnderTest;

  setUp(() {
    mockRepository = MockOrderRepository();
    systemUnderTest = OrderUseCase(orderRepository: mockRepository);
  });

  group('OrderUseCase', () {
    test('getOrders', () async {
      final mockOrder = Order(
        id: 'test-order-id',
        merchant: const Merchant(
          id: 'merchant-id',
          name: 'Test Merchant',
          logo: mockMerchantLogo,
        ),
        amount: (currency: 'SAR', value: 10000),
        paymentProductType: const SplitInNType(
          totalInstallments: 3,
          currentInstallment: 1,
        ),
        createdAt: DateTime.parse('2024-03-15T10:00:00Z'),
        updatedAt: DateTime.parse('2024-03-15T10:30:00Z'),
        status: OrderStatus.unpaid,
      );

      when(() => mockRepository.getOrders()).thenAnswer((_) async => Success([mockOrder]));

      await systemUnderTest.getOrders();

      verify(() => mockRepository.getOrders()).called(1);
    });
  });
}
