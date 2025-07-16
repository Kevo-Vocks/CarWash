import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> register({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
  });
}
