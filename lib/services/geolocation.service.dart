import 'package:geolocator/geolocator.dart';
import 'dart:math';


class LocationObject {
  final double latitude;
  final double longitude;

  LocationObject(this.latitude, this.longitude);
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  }

  return await Geolocator.getCurrentPosition();
}


double haversineDistance(double lat1, double lon1, double lat2, double lon2) {
  double toRadians(double degrees) {
    return degrees * (pi / 180);
  }

  lat1 = toRadians(lat1);
  lon1 = toRadians(lon1);
  lat2 = toRadians(lat2);
  lon2 = toRadians(lon2);

  const double earthRadius = 6371;

  double dlat = lat2 - lat1;
  double dlon = lon2 - lon1;
  double a = sin(dlat / 2) * sin(dlat / 2) +
      cos(lat1) * cos(lat2) * sin(dlon / 2) * sin(dlon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  double distance = earthRadius * c;

  return distance;
}


Future<String> _getLocation() async {
  Position location = await determinePosition();
  return '${location.latitude} ${location.longitude}';
}
