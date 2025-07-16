import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<User> register({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
  }) {
    return remoteDataSource.register(
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      password: password,
    );
  }
}
