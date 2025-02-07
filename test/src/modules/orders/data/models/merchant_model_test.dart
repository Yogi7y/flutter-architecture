import 'package:flutter_test/flutter_test.dart';
import 'package:orders/src/core/exceptions/serialization_exception.dart';
import 'package:orders/src/modules/orders/data/models/merchant_model.dart';

void main() {
  group('MerchantModel.fromMap', () {
    test('should create MerchantModel from valid JSON', () {
      final json = {
        'merchant_id': 'test-id',
        'merchant_name': 'Test Merchant',
        'merchant_logo': 'https://example.com/logo.png',
      };

      final result = MerchantModel.fromMap(json);

      expect(result.id, equals('test-id'));
      expect(result.name, equals('Test Merchant'));
      expect(result.logo, equals('https://example.com/logo.png'));
    });

    test('should throw InvalidTypeException when merchant_id is missing', () {
      final json = {
        'merchant_name': 'Test Merchant',
        'merchant_logo': 'https://example.com/logo.png',
      };

      expect(
        () => MerchantModel.fromMap(json),
        throwsA(
          isA<InvalidTypeException>()
              .having(
                (e) => e.exception,
                'exception',
                'merchant_id must be of type String, but got Null',
              )
              .having(
                (e) => e.payload,
                'payload',
                equals(json),
              ),
        ),
      );
    });

    test('should throw InvalidTypeException when merchant_name is missing', () {
      final json = {
        'merchant_id': 'test-id',
        'merchant_logo': 'https://example.com/logo.png',
      };

      expect(
        () => MerchantModel.fromMap(json),
        throwsA(isA<InvalidTypeException>()),
      );
    });

    test('should throw InvalidTypeException when merchant_logo is missing', () {
      final json = {
        'merchant_id': 'test-id',
        'merchant_name': 'Test Merchant',
      };

      expect(
        () => MerchantModel.fromMap(json),
        throwsA(
          isA<InvalidTypeException>()
              .having(
                (e) => e.exception,
                'exception',
                'merchant_logo must be of type String, but got Null',
              )
              .having(
                (e) => e.payload,
                'payload',
                equals(json),
              ),
        ),
      );
    });

    test('should throw InvalidTypeException when field types are incorrect', () {
      final json = {
        'merchant_id': 123,
        'merchant_name': 'Test Merchant',
        'merchant_logo': 'https://example.com/logo.png',
      };

      expect(
        () => MerchantModel.fromMap(json),
        throwsA(
          isA<InvalidTypeException>()
              .having(
                (e) => e.exception,
                'exception',
                'merchant_id must be of type String, but got int',
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
