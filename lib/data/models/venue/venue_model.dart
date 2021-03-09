// To parse this JSON data, do
//
//     final venue = venueFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<Venue> venueFromJson(String str) =>
    List<Venue>.from(json.decode(str).map((x) => Venue.fromJson(x)));

String venueToJson(List<Venue> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Venue {
  Venue({
    @required this.venueName,
    @required this.timeOpen,
    @required this.timeClosed,
    @required this.totalDaysOpen,
    @required this.sportsOfferedList,
    @required this.sportsOffered,
  });

  final String venueName;
  final String timeOpen;
  final String timeClosed;
  final int totalDaysOpen;
  final List<String> sportsOfferedList;
  final List<SportsOffered> sportsOffered;

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        venueName: json["venueName"],
        timeOpen: json["timeOpen"],
        timeClosed: json["timeClosed"],
        totalDaysOpen: json["totalDaysOpen"],
        sportsOfferedList: List<String>.from(json["sportsOfferedList"].map((x) => x)),
        sportsOffered:
            List<SportsOffered>.from(json["sportsOffered"].map((x) => SportsOffered.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "venueName": venueName,
        "timeOpen": timeOpen,
        "timeClosed": timeClosed,
        "totalDaysOpen": totalDaysOpen,
        "sportsOfferedList": List<dynamic>.from(sportsOfferedList.map((x) => x)),
        "sportsOffered": List<dynamic>.from(sportsOffered.map((x) => x.toJson())),
      };
}

class SportsOffered {
  SportsOffered({
    @required this.sportName,
    @required this.ratesPerHr,
    @required this.slots,
  });

  final String sportName;
  final int ratesPerHr;
  final List<Slot> slots;

  factory SportsOffered.fromJson(Map<String, dynamic> json) => SportsOffered(
        sportName: json["sportName"],
        ratesPerHr: json["ratesPerHr"],
        slots: List<Slot>.from(json["slots"].map((x) => Slot.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sportName": sportName,
        "ratesPerHr": ratesPerHr,
        "slots": List<dynamic>.from(slots.map((x) => x.toJson())),
      };
}

class Slot {
  Slot({
    @required this.date,
    @required this.time,
    @required this.isBooked,
  });

  final String date;
  final String time;
  final bool isBooked;

  factory Slot.fromJson(Map<String, dynamic> json) => Slot(
        date: json["date"],
        time: json["time"],
        isBooked: json["isBooked"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "time": time,
        "isBooked": isBooked,
      };
}
