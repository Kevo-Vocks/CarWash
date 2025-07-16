import 'dart:math';

import 'package:car_wash/features/carWash/domain/entities/car_wash.dart';
import 'package:car_wash/features/carWash/domain/repositories/car_wash_repository.dart';
import 'package:location/location.dart';

class GetNearestCarWashes {
  final CarWashRepository repository;

  GetNearestCarWashes(this.repository);

  Future<List<CarWash>> call(LocationData userLocation) async {
    final carWashes = await repository.getCarWashes();
    return carWashes
      ..sort((a, b) {
        final distA = _calculateDistance(
          userLocation.latitude!,
          userLocation.longitude!,
          a.latitude,
          a.longitude,
        );
        final distB = _calculateDistance(
          userLocation.latitude!,
          userLocation.longitude!,
          b.latitude,
          b.longitude,
        );
        return distA.compareTo(distB);
      });
  }

  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}