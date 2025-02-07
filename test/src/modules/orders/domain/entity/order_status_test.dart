import 'package:flutter_test/flutter_test.dart';
import 'package:orders/src/modules/orders/domain/entity/order_status.dart';

void main() {
  group('OrderStatus', () {
    group('fromString', () {
      test('should return unpaid status for "unpaid" id', () {
        final result = OrderStatus.fromString('unpaid');
        expect(result, equals(OrderStatus.unpaid));
      });

      test('should return paid status for "paid" id', () {
        final result = OrderStatus.fromString('paid');
        expect(result, equals(OrderStatus.paid));
      });

      test('should return disputed status for "disputed" id', () {
        final result = OrderStatus.fromString('disputed');
        expect(result, equals(OrderStatus.disputed));
      });

      test('should throw ArgumentError for invalid status id', () {
        expect(
          () => OrderStatus.fromString('invalid'),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              'Invalid order status: invalid',
            ),
          ),
        );
      });
    });

    group('status properties', () {
      test('unpaid status should have correct id and displayText', () {
        expect(OrderStatus.unpaid.id, equals('unpaid'));
        expect(OrderStatus.unpaid.displayText, equals('Unpaid'));
      });

      test('paid status should have correct id and displayText', () {
        expect(OrderStatus.paid.id, equals('paid'));
        expect(OrderStatus.paid.displayText, equals('Paid'));
      });

      test('disputed status should have correct id and displayText', () {
        expect(OrderStatus.disputed.id, equals('disputed'));
        expect(OrderStatus.disputed.displayText, equals('Disputed'));
      });
    });
  });
}
