abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String password;

  RegisterRequested({
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.password,
  });
}

