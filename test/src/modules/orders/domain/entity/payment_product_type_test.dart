import 'package:flutter_test/flutter_test.dart';
import 'package:orders/src/modules/orders/domain/entity/payment_product_type.dart';

void main() {
  group('PaymentProductType', () {
    test('SplitInNType should display correct text', () {
      const systemUnderTest = SplitInNType(
        totalInstallments: 3,
        currentInstallment: 1,
      );

      expect(systemUnderTest.displayText, 'Split in 3');
    });

    test('PayNextMonthType should display correct text', () {
      const systemUnderTest = PayNextMonthType();

      expect(systemUnderTest.displayText, 'Pay Next Month');
    });

    test('PayInFullType should display correct text', () {
      const systemUnderTest = PayInFullType();

      expect(systemUnderTest.displayText, 'Pay Later in 30 days');
    });

    test('SplitInNType should have correct id', () {
      expect(SplitInNType.id, 'PAY_BY_INSTALMENTS');
    });

    test('PayNextMonthType should have correct id', () {
      expect(PayNextMonthType.id, 'PAY_NEXT_MONTH');
    });

    test('PayInFullType should have correct id', () {
      expect(PayInFullType.id, 'PAY_BY_LATER');
    });
  });
}
