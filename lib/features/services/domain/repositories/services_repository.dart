import 'package:car_wash/features/services/domain/entities/service.dart';

abstract class ServicesRepository {
  Future<List<Service>> getServices(String carWashId);
}