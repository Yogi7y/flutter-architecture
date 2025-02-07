import 'package:meta/meta.dart';

import '../../../../core/validators/serialization_validator.dart';
import '../../domain/entity/merchant.dart';

@immutable
class MerchantModel extends Merchant {
  const MerchantModel({required super.id, required super.name, required super.logo});

  factory MerchantModel.fromMap(Map<String, Object?> json) {
    final validator = FieldTypeValidator(json, StackTrace.current);

    return MerchantModel(
      id: validator.isOfType<String>('merchant_id'),
      name: validator.isOfType<String>('merchant_name'),
      logo: validator.isOfType<String>('merchant_logo'),
    );
  }
}
