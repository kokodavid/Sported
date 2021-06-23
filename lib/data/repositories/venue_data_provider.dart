import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hive/hive.dart';
import 'package:sported_app/data/models/venue/venue_model.dart';

class VenueDataProvider {
  Future<List<Venue>> getVenues() async {
    final venueBox = Hive.box<Venue>("venues");
    var connectivityResult = await (Connectivity().checkConnectivity());

    //no internet
    if (connectivityResult == ConnectivityResult.none) {
      print("no internet ---------------------");
      // if (venueBox.isEmpty) {}
      return venueBox.values.toList();
    }

    //internet
    else {
      print("internet ---------------------");
      if (venueBox.isEmpty) {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        final firebaseVenues = await firestore.collection('venues').get().then((value) => value.docs.map((e) => Venue.fromJson(e.data())).toList());
        for (var v in firebaseVenues) {
          venueBox.add(v);
        }
        print("is box empty? --------------------- | ${venueBox.isEmpty}");
        return venueBox.values.toList();
      } else {
        print("is box empty? --------------------- | ${venueBox.isEmpty}");
        return venueBox.values.toList();
      }
    }
  }
}

//cache using hive
//get from firebase once then cache all venues if internet is available;  if internet is not available get from cache only

//   cacheVenues() async {
//     final venueBox = Hive.box<Venue>("venues");
//     final isVenuesOpen = venueBox.isOpen;
//     print("isVenuesOpen | $isVenuesOpen");
//
//     final allVenues = await getVenues();
//     await venueBox.clear();
//   }
//
//   //send cached venues to repo
//   //filter venues from locally based venues
//
