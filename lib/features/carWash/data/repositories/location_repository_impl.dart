import 'package:car_wash/features/carWash/data/datasources/location_datasource.dart';
import 'package:car_wash/features/carWash/domain/repositories/location_repository.dart';
import 'package:location/location.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource) {
    print('LocationRepositoryImpl instantiated with dataSource: $dataSource (${dataSource.runtimeType})');
  }

  @override
  Future<LocationData> getUserLocation() async {
    try {
      print('LocationRepositoryImpl: Calling getUserLocation');
      final locationData = await dataSource.getUserLocation();
      print('LocationRepositoryImpl: Got location: $locationData');
      return locationData;
    } catch (e) {
      print('LocationRepositoryImpl: Error fetching location: $e');
      throw Exception('Failed to get location: $e');
    }
  }
}