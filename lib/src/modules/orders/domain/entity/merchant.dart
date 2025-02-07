import 'package:meta/meta.dart';

@immutable
class Merchant {
  const Merchant({
    required this.id,
    required this.name,
    required this.logo,
  });

  final String id;
  final String name;
  final String logo;

  @override
  String toString() => 'Merchant(id: $id, name: $name, logo: $logo)';

  @override
  bool operator ==(covariant Merchant other) {
    if (identical(this, other)) return true;

    return other.id == id && other.name == name && other.logo == logo;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ logo.hashCode;
}
