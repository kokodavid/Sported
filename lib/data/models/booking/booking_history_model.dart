// To parse this JSON data, do
//
//     final bookingHistory = bookingHistoryFromJson(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<BookingHistory> bookingHistoryFromJson(String str) =>
    List<BookingHistory>.from(json.decode(str).map((x) => BookingHistory.fromJson(x)));

String bookingHistoryToJson(List<BookingHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingHistory {
  BookingHistory({
    @required this.venueName,
    @required this.pricePaid,
    @required this.dateBooked,
    @required this.slotBooked,
    @required this.sportName,
    @required this.uid,
  });

  final String venueName;
  final String pricePaid;
  final String dateBooked;
  final String slotBooked;
  final String sportName;
  final String uid;

  factory BookingHistory.fromJson(Map<String, dynamic> json) => BookingHistory(
        venueName: json["venueName"],
        pricePaid: json["pricePaid"],
        dateBooked: json["dateBooked"],
        slotBooked: json["slotBooked"],
        sportName: json["sportName"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "venueName": venueName,
        "pricePaid": pricePaid,
        "dateBooked": dateBooked,
        "slotBooked": slotBooked,
        "sportName": sportName,
        "uid": uid,
      };
}
