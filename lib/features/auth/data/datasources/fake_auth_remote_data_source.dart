import 'package:car_wash/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:car_wash/features/auth/data/models/user_model.dart';

class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return UserModel(
      id: 'fake_login_id',
      email: email,
      username: 'fake_user',
    );
  }

  @override
  Future<UserModel> register({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return UserModel(
      id: 'fake_register_id',
      email: email,
      username: username,
    );
  }
}
