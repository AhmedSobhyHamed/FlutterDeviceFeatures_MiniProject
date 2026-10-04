import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CurrentPosition {
  CurrentPosition();

  static Future<LatLng?> getCurrentLatLng() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    final locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied || locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permission denied');
    }
    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
}