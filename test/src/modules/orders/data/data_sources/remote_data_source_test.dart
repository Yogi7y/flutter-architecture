import 'package:core_y/core_y.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_y/network_y.dart';
import 'package:orders/src/modules/orders/data/data_sources/remote_data_source.dart';
import 'package:orders/src/modules/orders/domain/entity/merchant.dart';
import 'package:orders/src/modules/orders/domain/entity/order.dart';

import '../models/order_model_test.dart';

class MockApiClient extends Mock implements ApiClient {}

class FakeGetRequest extends Fake implements GetRequest {}

void main() {
  late MockApiClient mockApiClient;
  late OrderRemoteDataSource systemUnderTest;

  setUpAll(() {
    registerFallbackValue(FakeGetRequest());
  });

  setUp(() {
    mockApiClient = MockApiClient();
    systemUnderTest = OrderRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group('OrderRemoteDataSource', () {
    test('getOrders', () async {
      when(() => mockApiClient.call<Map<String, Object?>>(any()))
          .thenAnswer((_) async => Success(_mockResponse));

      final expectedResult = [
        Order(
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
        )
      ];

      final result = await systemUnderTest.getOrders();

      expect(result, expectedResult);
    });

    test(
      'getOrder skips over corrupt orders and return the valid ones',
      () async {
        when(() => mockApiClient.call<Map<String, Object?>>(any()))
            .thenAnswer((_) async => Success(_mockResponseWithCorruptData));

        final expectedOrderBase = Order(
          id: '',
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

        final expectedResult = [
          expectedOrderBase.copyWith(id: '1'),
          expectedOrderBase.copyWith(id: '3'),
        ];

        final result = await systemUnderTest.getOrders();

        expect(result, expectedResult);
      },
    );
  });
}

final _mockResponse = <String, Object?>{
  'orders': {
    'total_orders_count': 1,
    'items': [
      createMockOrderJson(),
    ]
  }
};

final _mockResponseWithCorruptData = <String, Object?>{
  'orders': {
    'total_orders_count': 3,
    'items': [
      createMockOrderJson(orderId: '1'),
      createMockOrderJson()['orderId'] = 2,
      createMockOrderJson(orderId: '3'),
    ]
  }
};
