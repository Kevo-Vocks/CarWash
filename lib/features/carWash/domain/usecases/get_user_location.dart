import 'package:car_wash/features/carWash/domain/repositories/location_repository.dart';
import 'package:location/location.dart';

class GetUserLocation {
  final LocationRepository repository;

  GetUserLocation(this.repository) {
    print('GetUserLocation instantiated with repository: $repository (${repository.runtimeType})');
  }

  Future<LocationData> call() async {
    try {
      print('GetUserLocation: Calling getUserLocation');
      final locationData = await repository.getUserLocation();
      print('GetUserLocation: Got location: $locationData');
      return locationData;
    } catch (e) {
      print('GetUserLocation: Error fetching location: $e');
      throw Exception('Failed to get location: $e');
    }
  }

  Stream<LocationData> streamLocation() {
    try {
      print('GetUserLocation: Starting location stream');
      final location = Location();
      location.changeSettings(
        accuracy: LocationAccuracy.balanced,
        distanceFilter: 500, // Meters
        interval: 30000, // 30 seconds in milliseconds
      );
      return location.onLocationChanged.handleError((error, stackTrace) {
        print('GetUserLocation: Stream error: $error');
        return Stream.error(Exception('Stream error: $error'));
      }).map((locationData) {
        print('GetUserLocation: Stream update: $locationData');
        return locationData;
      });
    } catch (e) {
      print('GetUserLocation: Error initializing stream: $e');
      return Stream.error(Exception('Failed to initialize stream: $e'));
    }
  }
}