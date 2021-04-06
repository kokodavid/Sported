import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sported_app/data/models/venue/venue_model.dart';
import 'package:sported_app/presentation/screens/venue_details_screen.dart';

class GMap extends StatefulWidget {
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  //markers
  BitmapDescriptor locationIcon;
  Set<Marker> _locationMarkers = {};
  Completer<GoogleMapController> _completer = Completer();
  Set<Marker> markers;
  void setCustomMapPin() async {
    locationIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(50.h, 50.h)),
      'assets/icons/group_6655.png',
    );
  }
  //
  // //curr location
  // Future<LatLng> getUserLocation() async {
  //   LocationManager.LocationData currentLocation;
  //   final location = LocationManager.Location();
  //   try {
  //     currentLocation = await location.getLocation();
  //     final lat = currentLocation.latitude;
  //     final lng = currentLocation.longitude;
  //     final center = LatLng(lat, lng);
  //     return center;
  //   } on Exception {
  //     currentLocation = null;
  //     return null;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // getUserLocation();
    setCustomMapPin();
  }

  //on created
  void _onMapCreated(GoogleMapController _controller) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    final allVenues = await firestore.collection('venues').get().then((value) => value.docs.map((e) => Venue.fromJson(e.data())).toList());

    final jaffery = allVenues.where((element) => element.venueName == "Nairobi Jaffery Sports Club").toList()[0];
    final agaKhan = allVenues.where((element) => element.venueName == "Aga Khan Sports Club").toList()[0];

    _controller.setMapStyle('''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#212121"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#181818"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#1b1b1b"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#2c2c2c"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#8a8a8a"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#373737"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#3c3c3c"
      }
    ]
  },
  {
    "featureType": "road.highway.controlled_access",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#4e4e4e"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "transit",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#000000"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#3d3d3d"
      }
    ]
  }
]''');
    _completer.complete(_controller);
    setState(
      () {
        _locationMarkers.add(
          Marker(
            markerId: MarkerId('marker1'),
            position: LatLng(-1.2754225352272903, 36.76830631083326),
            icon: locationIcon,

            infoWindow: InfoWindow(
              title: 'Nairobi Jeffary Sports Club',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => VenueDetailsScreen(venue: jaffery),
                  ),
                );
              },
            ),
          ),
        );
        _locationMarkers.add(
          Marker(
            markerId: MarkerId('marker2'),
            position: LatLng(-1.2593830167467919, 36.82361004197738),
            icon: locationIcon,

            infoWindow: InfoWindow(
              title: 'AgaKhan Sports Club',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => VenueDetailsScreen(venue: agaKhan),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialLocation = CameraPosition(zoom: 12, target: LatLng(-1.2593830167467919, 36.82361004197738));
    return GoogleMap(
      myLocationEnabled: true,
      initialCameraPosition: initialLocation,
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      mapToolbarEnabled: false,
      markers: _locationMarkers,
      zoomControlsEnabled: false,
      compassEnabled: false,
      buildingsEnabled: true,
      myLocationButtonEnabled: false,
      onMapCreated: _onMapCreated,
    );
  }
}
