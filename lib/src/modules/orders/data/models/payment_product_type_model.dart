import 'package:meta/meta.dart';

import '../../../../core/exceptions/serialization_exception.dart';
import '../../../../core/validators/serialization_validator.dart';
import '../../domain/entity/payment_product_type.dart';

@immutable
class PaymentProductTypeModel {
  const PaymentProductTypeModel._();

  static PaymentProductType fromMap(Map<String, Object?> json) {
    final validator = FieldTypeValidator(json, StackTrace.current);

    final paymentProductTypeId = validator.isOfType<String>('payment_type');

    final paymentProductType = switch (paymentProductTypeId) {
      SplitInNType.id => SplitInNType(
          totalInstallments: validator.isOfType<int>('instalments'),
          currentInstallment: validator.isOfType<int>('current_instalment'),
        ),
      PayNextMonthType.id => const PayNextMonthType(),
      PayInFullType.id => const PayInFullType(),
      _ => throw PaymentProductTypeDoesNotExistException(
          stackTrace: StackTrace.current,
          payload: json,
          id: paymentProductTypeId,
        ),
    };

    return paymentProductType;
  }
}
