// To parse this JSON data, do
//
//     final venue = venueFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<Venue> venueFromJson(String str) => List<Venue>.from(json.decode(str).map((x) => Venue.fromJson(x)));

String venueToJson(List<Venue> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Venue {
  Venue({
    @required this.venueName,
    @required this.timeOpen,
    @required this.timeClosed,
    @required this.totalDaysOpen,
    @required this.description,
    @required this.rules,
    @required this.images,
    @required this.sportsOfferedList,
    @required this.sportsOffered,
  });

  final String venueName;
  final String timeOpen;
  final String timeClosed;
  final int totalDaysOpen;
  final String description;
  final List<String> rules;
  final List<String> images;
  final List<String> sportsOfferedList;
  final List<SportsOffered> sportsOffered;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
    venueName: json["venueName"],
    timeOpen: json["timeOpen"],
    timeClosed: json["timeClosed"],
    totalDaysOpen: json["totalDaysOpen"],
    description: json["description"],
    rules: List<String>.from(json["rules"].map((x) => x)),
    images: List<String>.from(json["images"].map((x) => x)),
    sportsOfferedList: List<String>.from(json["sportsOfferedList"].map((x) => x)),
    sportsOffered: List<SportsOffered>.from(json["sportsOffered"].map((x) => SportsOffered.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "venueName": venueName,
    "timeOpen": timeOpen,
    "timeClosed": timeClosed,
    "totalDaysOpen": totalDaysOpen,
    "description": description,
    "rules": List<dynamic>.from(rules.map((x) => x)),
    "images": List<dynamic>.from(images.map((x) => x)),
    "sportsOfferedList": List<dynamic>.from(sportsOfferedList.map((x) => x)),
    "sportsOffered": List<dynamic>.from(sportsOffered.map((x) => x.toJson())),
  };
}

class SportsOffered {
  SportsOffered({
    @required this.sportName,
    @required this.ratesPerHr,
  });

  final String sportName;
  final int ratesPerHr;

  factory SportsOffered.fromJson(Map<String, dynamic> json) => SportsOffered(
    sportName: json["sportName"],
    ratesPerHr: json["ratesPerHr"],
  );

  Map<String, dynamic> toJson() => {
    "sportName": sportName,
    "ratesPerHr": ratesPerHr,
  };
}
