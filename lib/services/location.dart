import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;
  late bool serviceEnabled;

  Future<Position> getCurrentLocation() async {
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.requestPermission();

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    print("The permission of the app is $permission");
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    latitude = position.latitude;
    longitude = position.longitude;
    print('lat and long is $latitude and $longitude');

    return position;
  }
}
