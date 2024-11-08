import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v/Screen/signInScreen.dart';
import '../AuthService/Authentication.dart';
import '../Controller/AllUserController.dart';
import 'UserUpdateScreen.dart';
import '../Model/UserModel.dart';

class UserManagementScreen extends StatelessWidget {
  UserManagementScreen({super.key});
  final AllUserController allUserController = Get.put(AllUserController());
  final AuthenticationService authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('isLoggedIn');
              Get.offAll(signInScreen());
            },
              child: Icon(
            Icons.exit_to_app,
            color: Colors.white,
          ))
        ],
        backgroundColor: Color(0xFF232F3E),
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'V',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (allUserController.users.isEmpty) {
          return Center(
            child: Text('No users found.'),
          );
        }
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Total Users: ",
                    style: TextStyle(
                      color: Color(0xFF232F3E),
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${allUserController.users.length}",
                    style: TextStyle(
                      color: Color(0xFF232F3E),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: allUserController.users.length,
                itemBuilder: (context, index) {
                  final user = allUserController.users[index];

                  return Card(
                    color: Color(0xFFF1F1F1),
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.name,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  user.email,
                                  style: TextStyle(
                                    color: Color(0xFF333333),
                                  ),
                                ),
                                SizedBox(height: 4),

                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon:
                                    Icon(Icons.edit, color: Color(0xFF232F3E)),
                                onPressed: () async {
                                  Get.to(() => UserUpdateScreen(user: user));
                                  await allUserController.fetchUsers();
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete,
                                    color: Color(0xFFD9534F)),
                                onPressed: () {
                                  _confirmDelete(context, user);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  void _confirmDelete(BuildContext context, UserModel user) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete User'),
        content: Text('Are you sure you want to delete ${user.name}?'),
        actions: [
          TextButton(
            child: Text('Cancel', style: TextStyle(color: Color(0xFF232F3E))),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text('Delete', style: TextStyle(color: Color(0xFFD9534F))),
            onPressed: () async {
              allUserController.users.remove(user);
              allUserController.deleteUser(user.id);
              // await allUserController.fetchUsers();
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
