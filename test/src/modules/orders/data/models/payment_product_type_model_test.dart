import 'package:flutter_test/flutter_test.dart';
import 'package:orders/src/core/exceptions/serialization_exception.dart';
import 'package:orders/src/modules/orders/data/models/payment_product_type_model.dart';
import 'package:orders/src/modules/orders/domain/entity/payment_product_type.dart';

void main() {
  group('PaymentProductTypeModel', () {
    test('should parse SplitInNType correctly', () {
      final json = {
        'payment_type': SplitInNType.id,
        'instalments': 3,
        'current_instalment': 1,
      };

      final result = PaymentProductTypeModel.fromMap(json);

      expect(
        result,
        isA<SplitInNType>()
            .having((p) => p.totalInstallments, 'totalInstallments', 3)
            .having((p) => p.currentInstallment, 'currentInstallment', 1),
      );
    });

    test('should parse PayNextMonthType correctly', () {
      final json = {
        'payment_type': PayNextMonthType.id,
      };

      final result = PaymentProductTypeModel.fromMap(json);

      expect(result, isA<PayNextMonthType>());
    });

    test('should parse PayInFullType correctly', () {
      final json = {
        'payment_type': PayInFullType.id,
      };

      final result = PaymentProductTypeModel.fromMap(json);

      expect(result, isA<PayInFullType>());
    });

    test('should throw when payment_type is missing', () {
      final json = <String, Object?>{};

      expect(
        () => PaymentProductTypeModel.fromMap(json),
        throwsA(
          isA<InvalidTypeException>()
              .having(
                (e) => e.userFriendlyMessage,
                'userFriendlyMessage',
                'Something went wrong. Please try again later.',
              )
              .having(
                (e) => e.payload,
                'payload',
                equals(json),
              ),
        ),
      );
    });

    test('should throw on unknown payment type', () {
      final json = {
        'payment_type': 'UNKNOWN_TYPE',
      };

      expect(
        () => PaymentProductTypeModel.fromMap(json),
        throwsA(
          isA<PaymentProductTypeDoesNotExistException>()
              .having(
                (e) => e.userFriendlyMessage,
                'userFriendlyMessage',
                'Some issue happening with the currently selected payment type',
              )
              .having(
                (e) => e.exception,
                'exception',
                'Unknown payment type: UNKNOWN_TYPE',
              )
              .having(
                (e) => e.id,
                'id',
                'UNKNOWN_TYPE',
              )
              .having(
                (e) => e.payload,
                'payload',
                equals(json),
              ),
        ),
      );
    });
  });
}
