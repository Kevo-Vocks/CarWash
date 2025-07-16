import 'package:car_wash/features/carWash/data/datasources/car_wash_datasource.dart';
import 'package:car_wash/features/carWash/domain/entities/car_wash.dart';
import 'package:car_wash/features/carWash/domain/repositories/car_wash_repository.dart';

class CarWashRepositoryImpl implements CarWashRepository {
  CarWashRepositoryImpl(CarWashDataSource read);

  @override
  Future<List<CarWash>> getCarWashes() async {
    // Convert models.CarWash to core.entities.CarWash
    return carWashes
        .map((wash) => CarWash(
              id: wash.id,
              name: wash.name,
              location: wash.location,
              latitude: wash.latitude,
              // services: wash.services,
              longitude: wash.longitude,
              imageUrl: wash.imageUrl,
              openHours: wash.openHours,
            ))
        .toList();
  }
}