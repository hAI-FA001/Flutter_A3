import 'dart:convert';

import 'package:collection/collection.dart';

import 'league.dart';

class Model {
  bool? ok;
  List<League>? league;

  Model({this.ok, this.league});

  factory Model.fromMap(Map<String, dynamic> data) => Model(
        ok: data['ok'] as bool?,
        league: (data['response'] as List<dynamic>?)
            ?.map((e) => League.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'ok': ok,
        'response': league?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Model].
  factory Model.fromJson(String data) {
    return Model.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Model] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Model) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => ok.hashCode ^ league.hashCode;
}
