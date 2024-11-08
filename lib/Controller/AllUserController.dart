import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../Model/UserModel.dart';

class AllUserController extends GetxController {
  RxList<UserModel> users = <UserModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    users.clear();
    try {
      print("Fetching users");
      isLoading.value = true;
      final response = await http.get(
        Uri.parse('https://672a1d66976a834dd022316f.mockapi.io/api/v1/Users'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        users.value =
            data.map((userJson) => UserModel.fromJson(userJson)).toList();
        isLoading.value = false;
      } else {
        throw Exception('error load users');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateUser(
      String userId,
      String name,
    String email, String country, String gender, String occupation, String contact,

  ) async {
    try {
      print(userId);
      print(email);
      print(name);
      
      final response = await http.put(
          Uri.parse('https://672a1d66976a834dd022316f.mockapi.io/api/v1/Users/$userId'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            "email": email,
            "name": name,
            "country":country,
            "gender":gender,
            "occupation":occupation,
            "contact":contact,
          }
          )
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        Get.snackbar("Success", 'Profile updated successfully!');
      } else {
        throw Exception('error to update profile');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool> deleteUser(String userId,) async {
    try {
      final response = await http.delete(
        Uri.parse('https://672a1d66976a834dd022316f.mockapi.io/api/v1/Users/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {

        print('User deleted successfully');
        return true;
      } else {

        print('Failed to delete user. Status code: ${response.statusCode}');
        throw Exception('Failed to delete user: ${response.body}');
      }
    } catch (e) {

      print('Error deleting user: $e');
      throw Exception('Error deleting user: $e');
    }
  }

}
