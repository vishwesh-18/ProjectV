import 'dart:convert';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1/users/';
  static const String loginUrl = 'https://api.escuelajs.co/api/v1/auth/login';

  RxString accessToken = ''.obs;
  RxString refreshToken = ''.obs;


  Future<Map<String, dynamic>> signUp(
      String name, String email, String password,) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "name": name,
          "email": email,
          "password": password,
          "avatar": "https://i.imgur.com/yhW6Yw1.jpg",
        }),
      );

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to create user: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }

//user data saving on mockapi
  Future<void> saveUser(
    String name,
    String email,
    String password,
  ) async {
    const String apiUrl =
        'https://672a1d66976a834dd022316f.mockapi.io/api/v1/Users';

    Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "password": password,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      print("Status : ${response.statusCode}");

      if (response.statusCode == 201) {
      } else {}
    } catch (error) {
      // Error handling
    } finally {}
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        if (data['access_token'] != null && data['refresh_token'] != null) {
          accessToken.value = data['access_token'];
          refreshToken.value = data['refresh_token'];
          print('Access Token: ${accessToken.value}');
          print('Refresh Token: ${refreshToken.value}');
          return true;
        } else {
          throw Exception('Tokens not found in response');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Invalid email or password');
      } else {
        throw Exception(
            'Login failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during login: $e');
      return false;
    }
  }
  Future<void> logout() async {




  }
}
