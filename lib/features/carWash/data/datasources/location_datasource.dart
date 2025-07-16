import 'package:location/location.dart';

abstract class LocationDataSource {
  Future<LocationData> getUserLocation();
}

class LocationDataSourceImpl implements LocationDataSource {
  final Location location;

  LocationDataSourceImpl(this.location) {
    print('LocationDataSourceImpl instantiated with location: $location (${location.runtimeType})');
  }

  @override
  Future<LocationData> getUserLocation() async {
    try {
      print('LocationDataSourceImpl: Checking location services');
      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        print('LocationDataSourceImpl: Requesting location service');
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw Exception('Location services are disabled.');
        }
      }

      print('LocationDataSourceImpl: Checking location permission');
      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        print('LocationDataSourceImpl: Requesting location permission');
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw Exception('Location permission denied.');
        }
      }

      print('LocationDataSourceImpl: Fetching user location');
      final locationData = await location.getLocation();
      print('LocationDataSourceImpl: Got location: $locationData');
      return locationData;
    } catch (e) {
      print('LocationDataSourceImpl: Error fetching location: $e');
      throw Exception('Failed to get location: $e');
    }
  }
}