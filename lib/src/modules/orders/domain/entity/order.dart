import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import 'merchant.dart';
import 'order_status.dart';
import 'payment_product_type.dart';

typedef OrderId = String;

/// Combination of Amount + Currency
typedef Amount = ({int? value, String? currency});

@immutable
class Order {
  const Order({
    required this.id,
    required this.merchant,
    required this.amount,
    required this.paymentProductType,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
  });

  final OrderId id;
  final Merchant merchant;
  final Amount amount;
  final PaymentProductType paymentProductType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final OrderStatus status;

  String get formattedCreatedAt => DateFormat('MMMM yyyy').format(createdAt);
  String get formattedUpdatedAt => DateFormat('MMMM yyyy').format(updatedAt);

  Order copyWith({
    OrderId? id,
    Merchant? merchant,
    Amount? amount,
    PaymentProductType? paymentProductType,
    DateTime? createdAt,
    DateTime? updatedAt,
    OrderStatus? status,
  }) =>
      Order(
        id: id ?? this.id,
        merchant: merchant ?? this.merchant,
        amount: amount ?? this.amount,
        paymentProductType: paymentProductType ?? this.paymentProductType,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        status: status ?? this.status,
      );

  @override
  String toString() =>
      'Order(id: $id, merchant: $merchant, amount: $amount, paymentProductType: $paymentProductType, createdAt: $createdAt, updatedAt: $updatedAt, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        other.id == id &&
        other.merchant == merchant &&
        other.amount == amount &&
        other.paymentProductType == paymentProductType &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.status == status;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      merchant.hashCode ^
      amount.hashCode ^
      paymentProductType.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      status.hashCode;
}
