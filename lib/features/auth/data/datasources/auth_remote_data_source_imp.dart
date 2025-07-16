import 'dart:convert';
import 'package:car_wash/features/auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final String baseUrl = 'http://192.168.137.43:8000/user'; // Replace with your real backend URL

  @override
  Future<UserModel> register({
    required String email,
    required String username,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register/');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return UserModel(
        id: data['id'].toString(),
        email: data['email'],
        username: data['username'],
      );
    } else {
      throw Exception('Failed to register: ${response.body}');
    }
  }

  // You can leave login as-is or update it later
  @override
  Future<UserModel> login(String email, String password) async {
    await Future.delayed(Duration(seconds: 1));
    return UserModel(
      id: '123',
      email: email,
      username: "test_user",
    );
  }
}
