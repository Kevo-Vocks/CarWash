import 'package:car_wash/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:car_wash/features/auth/presentation/bloc/auth_event.dart';
import 'package:car_wash/features/auth/presentation/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../widgets/auth_text_field.dart';
import '../widgets/password_field.dart';
import '../widgets/auth_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
  if (_formKey.currentState!.validate()) {
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final password = passwordController.text.trim();

    context.read<AuthBloc>().add(
      RegisterRequested(
        email: email,
        username: username,
        firstName: firstName,
        lastName: lastName,
        password: password,
      ),
    );
  }
}


  @override
Widget build(BuildContext context) {
  const blue = Colors.blue;

  return Scaffold(
    body: SafeArea(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            // Optional: Show loading UI
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (state is AuthSuccess) {
            Navigator.pop(context); // close the dialog
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration successful!')),
            );
            context.go('/home');
          }

          if (state is AuthFailure) {
            Navigator.pop(context); // close the dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: _buildForm(context),
      ),
    ),
  );
}

Widget _buildForm(BuildContext context) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 4),
            const Center(
              child: Text(
                "Create a new account",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 32),
            AuthTextField(
              controller: usernameController,
              hint: "Username",
              icon: Icons.person,
              validator: (v) => v!.isEmpty ? "Enter username" : null,
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: emailController,
              hint: "Email",
              icon: Icons.email,
              inputType: TextInputType.emailAddress,
              validator: (v) => v!.isEmpty ? "Enter valid email" : null,
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: firstNameController,
              hint: "First Name",
              icon: Icons.person_outline,
              validator: (v) => v!.isEmpty ? "Enter first name" : null,
            ),
            const SizedBox(height: 16),
            AuthTextField(
              controller: lastNameController,
              hint: "Last Name",
              icon: Icons.person_outline,
              validator: (v) => v!.isEmpty ? "Enter last name" : null,
            ),
            const SizedBox(height: 16),
            PasswordField(
              controller: passwordController,
              hint: "Password",
              icon: Icons.lock,
              validator: (v) => v!.length < 6 ? "Min 6 characters" : null,
            ),
            const SizedBox(height: 16),
            PasswordField(
              controller: confirmPasswordController,
              hint: "Confirm Password",
              icon: Icons.lock_outline,
              validator: (v) =>
                  v != passwordController.text ? "Passwords do not match" : null,
            ),
            const SizedBox(height: 24),
            AuthButton(
              label: "CREATE ACCOUNT",
              onPressed: _register,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () => context.go('/login'),
                  child: const Text(
                    "Login here",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

}
