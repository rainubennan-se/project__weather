import 'package:geolocator/geolocator.dart';

class LocationAccess {
  var latitude;
  var longitude;
  Future<void> locationaccess() async {
    print('Location function');
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print('Stage 1');
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('inside loation access function');
      print('Latitude ${currentPosition.latitude}');
      print(currentPosition.longitude);
      latitude = currentPosition.latitude;
      longitude = currentPosition.longitude;
    }
  }
}
