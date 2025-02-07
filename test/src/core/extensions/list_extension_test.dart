import 'package:flutter_test/flutter_test.dart';
import 'package:orders/src/core/exceptions/serialization_exception.dart';
import 'package:orders/src/core/extensions/list_extension.dart';
import 'package:orders/src/core/validators/serialization_validator.dart';

void main() {
  group('ListExtension.tryMap', () {
    test('should successfully map all valid items', () {
      final input = [
        {'id': '1', 'value': 'test1'},
        {'id': '2', 'value': 'test2'},
        {'id': '3', 'value': 'test3'},
      ];

      final result = input.tryMap<TestModel>(TestModel.fromMap);

      expect(result.length, equals(3));
      expect(result[0].id, equals('1'));
      expect(result[0].value, equals('test1'));
      expect(result[2].id, equals('3'));
      expect(result[2].value, equals('test3'));
    });

    test('should skip invalid items and continue processing', () {
      final input = [
        {'id': '1', 'value': 'test1'},
        {'invalid': 'data'}, // Invalid item
        {'id': '3', 'value': 'test3'},
      ];

      final errors = <Object>[];
      final result = input.tryMap<TestModel>(
        TestModel.fromMap,
        onCatch: (error, item) => errors.add(error),
      );

      expect(result.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[1].id, equals('3'));
      expect(errors.length, equals(1));
      expect(errors[0], isA<InvalidTypeException>());
    });

    test('should handle null items gracefully', () {
      final input = [
        {'id': '1', 'value': 'test1'},
        null,
        {'id': '3', 'value': 'test3'},
      ];

      final result = input.tryMap<TestModel>(TestModel.fromMap);

      expect(result.length, equals(2));
      expect(result[0].id, equals('1'));
      expect(result[1].id, equals('3'));
    });

    test('should handle empty list', () {
      final input = <Map<String, Object?>>[];

      final result = input.tryMap<TestModel>(TestModel.fromMap);

      expect(result, isEmpty);
    });

    test('should call onCatch for each error', () {
      final input = [
        {'id': '1', 'value': 'test1'},
        {'invalid': 'data1'},
        {'another': 'invalid2'},
        {'id': '4', 'value': 'test4'},
      ];

      final errors = <Object>[];
      final failedItems = <Object?>[];

      final result = input.tryMap<TestModel>(
        TestModel.fromMap,
        onCatch: (error, item) {
          errors.add(error);
          failedItems.add(item);
        },
      );

      expect(result.length, equals(2));
      expect(errors.length, equals(2));
      expect(failedItems.length, equals(2));
      expect(failedItems[0], equals({'invalid': 'data1'}));
      expect(failedItems[1], equals({'another': 'invalid2'}));
    });

    test('should handle mixed type errors', () {
      final input = [
        {'id': '1', 'value': 'test1'},
        {'id': 123, 'value': 'invalid'},
        {'missing': 'required fields'},
        {'id': '4', 'value': 'test4'},
      ];

      final errors = <Object>[];
      final result = input.tryMap<TestModel>(
        TestModel.fromMap,
        onCatch: (error, item) => errors.add(error),
      );

      expect(result.length, equals(2));
      expect(errors.length, equals(2));
      expect(errors.any((e) => e is InvalidTypeException), isTrue);
    });
  });
}

class TestModel {
  TestModel({required this.id, required this.value});

  factory TestModel.fromMap(Map<String, Object?> map) {
    final validator = FieldTypeValidator(map, StackTrace.current);

    final id = validator.isOfType<String>('id');
    final value = validator.isOfType<String>('value');

    return TestModel(id: id, value: value);
  }
  final String id;
  final String value;
}
