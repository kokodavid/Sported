// To parse this JSON data, do
//
//     final venue = venueFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'venue_model.g.dart';

List<Venue> venueFromJson(String str) => List<Venue>.from(json.decode(str).map((x) => Venue.fromJson(x)));

String venueToJson(List<Venue> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
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

	@HiveField(0)
  final String venueName;
	@HiveField(1)
  final String timeOpen;
	@HiveField(2)
  final String timeClosed;
	@HiveField(3)
  final int totalDaysOpen;
	@HiveField(4)
  final String description;
	@HiveField(5)
  final List<String> rules;
	@HiveField(6)
  final List<String> images;
	@HiveField(7)
  final List<String> sportsOfferedList;
	@HiveField(8)
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

@HiveType(typeId: 1)
class SportsOffered {
	SportsOffered({
		@required this.sportName,
		@required this.ratesPerHr,
		@required this.memberRatesPerHr,
	});

	@HiveField(0)
  final String sportName;
	@HiveField(1)
  final int ratesPerHr;
	@HiveField(2)
  final int memberRatesPerHr;

	factory SportsOffered.fromJson(Map<String, dynamic> json) => SportsOffered(
		sportName: json["sportName"],
		ratesPerHr: json["ratesPerHr"],
		memberRatesPerHr: json["memberRatesPerHr"],
	);

	Map<String, dynamic> toJson() => {
		"sportName": sportName,
		"ratesPerHr": ratesPerHr,
		"memberRatesPerHr": memberRatesPerHr,
	};
}
