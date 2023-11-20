import 'dart:convert';

import 'package:collection/collection.dart';

class League {
  int? id;
  String? name;
  String? icon;
  String? updatedAt;
  String? createdAt;

  League({this.id, this.name, this.icon, this.updatedAt, this.createdAt});

  factory League.fromMap(Map<String, dynamic> data) => League(
        id: data['id'] as int?,
        name: data['name'] as String?,
        icon: data['icon'] as String?,
        updatedAt: data['updated_at'] as String?,
        createdAt: data['created_at'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'icon': icon,
        'updated_at': updatedAt,
        'created_at': createdAt,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [League].
  factory League.fromJson(String data) {
    return League.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [League] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! League) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      icon.hashCode ^
      updatedAt.hashCode ^
      createdAt.hashCode;
}
