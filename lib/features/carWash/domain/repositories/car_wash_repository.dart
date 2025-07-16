import 'package:car_wash/features/carWash/domain/entities/car_wash.dart';

abstract class CarWashRepository {
  Future<List<CarWash>> getCarWashes();
}