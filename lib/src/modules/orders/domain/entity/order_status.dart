import 'package:meta/meta.dart';

/// Represents the current status of an order.
@immutable
enum OrderStatus {
  unpaid(
    id: 'unpaid',
    displayText: 'Unpaid',
  ),

  paid(
    id: 'paid',
    displayText: 'Paid',
  ),

  disputed(
    id: 'disputed',
    displayText: 'Disputed',
  );

  const OrderStatus({
    required this.id,
    required this.displayText,
  });

  /// Creates an [OrderStatus] from a string value.
  ///
  /// Parameters:
  /// - [value]: The string ID of the order status
  ///
  /// Throws an [ArgumentError] if the provided value doesn't match any known status.
  factory OrderStatus.fromString(String value) {
    return switch (value) {
      'unpaid' => OrderStatus.unpaid,
      'paid' => OrderStatus.paid,
      'disputed' => OrderStatus.disputed,
      _ => throw ArgumentError('Invalid order status: $value'),
    };
  }

  /// The unique identifier for a status
  final String id;

  /// User-friendly text to display for a status
  final String displayText;
}
