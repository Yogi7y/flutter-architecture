import 'package:meta/meta.dart';

import '../../../../core/validators/serialization_validator.dart';
import '../../domain/entity/order.dart';
import '../../domain/entity/order_status.dart';
import 'merchant_model.dart';
import 'payment_product_type_model.dart';

@immutable
class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.merchant,
    required super.amount,
    required super.paymentProductType,
    required super.createdAt,
    required super.updatedAt,
    required super.status,
  });

  factory OrderModel.fromMap(Map<String, Object?> json) {
    final validator = FieldTypeValidator(json, StackTrace.current);

    final orderId = validator.isOfType<String>('order_id');
    final merchant = MerchantModel.fromMap(json);
    final createdAt = DateTime.parse(validator.isOfType<String>('created_at'));
    final updatedAt = DateTime.parse(validator.isOfType<String>('updated_at'));
    final status = OrderStatus.fromString(validator.isOfType<String>('status'));
    final totalAmount = validator.isOfType<Map<String, Object?>>('total_amount');
    final amountValidator = FieldTypeValidator(totalAmount, StackTrace.current);
    final amount = (
      value: amountValidator.isOfType<int>('amount'),
      currency: amountValidator.isOfType<String>('currency'),
    );
    final paymentProductType = PaymentProductTypeModel.fromMap(json);

    return OrderModel(
      id: orderId,
      merchant: merchant,
      amount: amount,
      paymentProductType: paymentProductType,
      createdAt: createdAt,
      updatedAt: updatedAt,
      status: status,
    );
  }
}
