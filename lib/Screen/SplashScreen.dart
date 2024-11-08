import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/AllUserController.dart';
import 'signInScreen.dart'; // Import SignInScreen
import 'UserManagementScreen.dart'; // Import UserManagementScreen

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AllUserController allUserController = Get.put(AllUserController());
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Future.delayed(Duration(seconds: 3), () async {
      if (isLoggedIn) {
        await allUserController.fetchUsers();
        Get.offAll(UserManagementScreen());
      } else {
        Get.offAll(signInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF232F3E),
      body: Center(
        child: Text(
          'V',
          style: TextStyle(
            fontSize: 28,
            color: Color(0xFFFF9900),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
