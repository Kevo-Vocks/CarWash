import 'package:car_wash/features/services/domain/entities/service.dart';
import 'package:car_wash/features/services/domain/repositories/services_repository.dart';

class GetServices {
  final ServicesRepository repository;

  GetServices(this.repository);

  Future<List<Service>> call(String carWashId) async {
    return await repository.getServices(carWashId);
  }
}