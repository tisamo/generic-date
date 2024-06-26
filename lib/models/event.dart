// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

class Event {
  Event({
    this.id,
    required this.name,
    this.created,
    required this.place,
    required this.partyTime,
    required this.description,
    required this.organizer,
    this.thumbNail,
  });

  String? id;
  String name;
  DateTime? created;
  String place;
  DateTime partyTime;
  String description;
  String organizer;
  String? thumbNail;

  factory Event.fromRawJson(String str) => Event.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Event.fromJson(Map<String, dynamic> json) => Event(
    id: json["_id"],
    name: json["name"],
    created: json["created"],
    place: json["place"],
    partyTime: json["partyTime"],
    description: json["description"],
    organizer: json["organizer"],
    thumbNail: json["thumbNail"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "place": place,
    "partyTime": partyTime,
    "description": description,
    "organizer": organizer,
    "thumbNail": thumbNail,
  };
}
