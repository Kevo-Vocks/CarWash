import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Register {
  final AuthRepository repository;

  Register(this.repository);

  Future<User> call({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
  }) {
    return repository.register(
      email: email,
      username: username,
      firstName: firstName,
      lastName: lastName,
      password: password,
    );
  }
}
