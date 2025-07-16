import 'package:car_wash/features/services/data/datasources/services_datasource.dart';
import 'package:car_wash/features/services/domain/entities/service.dart';
import 'package:car_wash/features/services/domain/repositories/services_repository.dart';

class ServicesRepositoryImpl implements ServicesRepository {
  final ServicesDataSource dataSource;

  ServicesRepositoryImpl(this.dataSource);

  @override
  Future<List<Service>> getServices(String carWashId) async {
    return await dataSource.getServices(carWashId);
  }
}