import 'package:meta/meta.dart';

/// Base class for different payment product types.
/// This sealed class defines the contract for all payment product types,
/// ensuring they provide formatted display text for the UI. This helps to maintain separation of concerns and
/// lets us to easily introduce new payment product types down the line.
@immutable
sealed class PaymentProductType {
  const PaymentProductType();

  /// Formatted text to display to the user.
  String get displayText;
}

/// Allows splitting payment into multiple installments.
@immutable
final class SplitInNType implements PaymentProductType {
  const SplitInNType({
    required this.totalInstallments,
    required this.currentInstallment,
  });

  /// Unique identifier for this payment type
  static const id = 'PAY_BY_INSTALMENTS';

  /// The total number of installments in the payment plan.
  final int totalInstallments;

  /// The current installment number.
  final int currentInstallment;

  @override
  String get displayText => 'Split in $totalInstallments';

  @override
  String toString() =>
      'SplitInNType(totalInstallments: $totalInstallments, currentInstallment: $currentInstallment)';

  @override
  bool operator ==(covariant SplitInNType other) {
    if (identical(this, other)) return true;

    return other.totalInstallments == totalInstallments &&
        other.currentInstallment == currentInstallment;
  }

  @override
  int get hashCode => totalInstallments.hashCode ^ currentInstallment.hashCode;
}

/// Allows payment to be made next month.
@immutable
final class PayNextMonthType implements PaymentProductType {
  const PayNextMonthType();

  /// Unique identifier for this payment type
  static const id = 'PAY_NEXT_MONTH';

  @override
  String get displayText => 'Pay Next Month';

  @override
  String toString() => 'PayNextMonthType()';

  @override
  bool operator ==(covariant PayNextMonthType other) => true;

  @override
  int get hashCode => 0;
}

/// Allows paying later in 30 days.
@immutable
final class PayInFullType implements PaymentProductType {
  const PayInFullType();

  /// Unique identifier for this payment type
  static const id = 'PAY_BY_LATER';

  @override
  String get displayText => 'Pay Later in 30 days';

  @override
  String toString() => 'PayInFullType()';

  @override
  bool operator ==(covariant PayInFullType other) => true;

  @override
  int get hashCode => 0;
}
