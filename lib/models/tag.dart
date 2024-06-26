import 'dart:convert';

class Tag {
  Tag({required this.id, required this.name});

  int id;
  String name;

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
