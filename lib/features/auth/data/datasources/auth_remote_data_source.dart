import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
  });

}
