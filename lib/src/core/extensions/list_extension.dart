extension ListExtension on List<Object?> {
  /// Maps a list of objects to a list of type [T], without breaking execution on errors.
  ///
  /// Unlike regular [map] which breaks execution on the first error, this method:
  /// - Attempts to convert each non-null item using [fromMap]
  /// - Silently skips items that throw errors during conversion
  /// - Continues processing remaining items
  /// - Returns successfully converted items as a [List<T>]
  ///
  /// If [onCatch] is provided, it will be called with the error and failed item
  /// whenever an item fails conversion.
  List<T> tryMap<T>(T Function(Map<String, Object?> map) fromMap,
          {void Function(Object error, Object? item)? onCatch}) =>
      where((e) => e != null)
          .map((e) {
            try {
              return fromMap(e! as Map<String, Object?>);
            } catch (error) {
              onCatch?.call(error, e);
              return null;
            }
          })
          .whereType<T>()
          .toList();
}
