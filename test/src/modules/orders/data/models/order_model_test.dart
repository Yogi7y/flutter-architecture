import 'package:flutter_test/flutter_test.dart';
import 'package:orders/src/core/exceptions/serialization_exception.dart';
import 'package:orders/src/modules/orders/data/models/order_model.dart';
import 'package:orders/src/modules/orders/domain/entity/order_status.dart';

void main() {
  group('OrderModel.fromMap', () {
    test('should create OrderModel from valid JSON', () {
      final json = createMockOrderJson();

      final result = OrderModel.fromMap(json);

      expect(result.id, equals('test-order-id'));
      expect(result.merchant.id, equals('merchant-id'));
      expect(result.merchant.name, equals('Test Merchant'));
      expect(result.merchant.logo, equals(mockMerchantLogo));
      expect(result.amount.value, equals(10000));
      expect(result.amount.currency, equals('SAR'));
      expect(result.status, equals(OrderStatus.unpaid));
      expect(result.createdAt, equals(DateTime.parse('2024-03-15T10:00:00Z')));
      expect(result.updatedAt, equals(DateTime.parse('2024-03-15T10:30:00Z')));
    });

    test('should throw InvalidTypeException when order_id is missing', () {
      final json = createMockOrderJson()..remove('order_id');

      expect(
        () => OrderModel.fromMap(json),
        throwsA(
          isA<InvalidTypeException>()
              .having(
                (e) => e.exception,
                'exception',
                'order_id must be of type String, but got Null',
              )
              .having(
                (e) => e.payload,
                'payload',
                equals(json),
              ),
        ),
      );
    });

    test('should throw InvalidTypeException when total_amount is missing', () {
      final json = createMockOrderJson()..remove('total_amount');

      expect(
        () => OrderModel.fromMap(json),
        throwsA(
          isA<InvalidTypeException>()
              .having(
                (e) => e.exception,
                'exception',
                'total_amount must be of type Map<String, Object?>, but got Null',
              )
              .having(
                (e) => e.payload,
                'payload',
                equals(json),
              ),
        ),
      );
    });

    test('should throw ArgumentError when status is invalid', () {
      final json = createMockOrderJson(status: 'invalid-status');

      expect(
        () => OrderModel.fromMap(json),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            'Invalid order status: invalid-status',
          ),
        ),
      );
    });
  });
}

const mockMerchantLogo = 'https://example.com/logo.png';

Map<String, Object?> createMockOrderJson({
  String? orderId,
  String? merchantId,
  String? merchantName,
  String? merchantLogo,
  Map<String, Object?>? totalAmount,
  String? paymentType,
  int? instalments,
  int? currentInstalment,
  String? createdAt,
  String? updatedAt,
  String? status,
}) {
  return {
    'order_id': orderId ?? 'test-order-id',
    'merchant_id': merchantId ?? 'merchant-id',
    'merchant_name': merchantName ?? 'Test Merchant',
    'merchant_logo': merchantLogo ?? mockMerchantLogo,
    'total_amount': totalAmount ??
        {
          'amount': 10000,
          'currency': 'SAR',
        },
    'payment_type': paymentType ?? 'PAY_BY_INSTALMENTS',
    'instalments': instalments ?? 3,
    'current_instalment': currentInstalment ?? 1,
    'created_at': createdAt ?? '2024-03-15T10:00:00Z',
    'updated_at': updatedAt ?? '2024-03-15T10:30:00Z',
    'status': status ?? OrderStatus.unpaid.name,
  };
}
