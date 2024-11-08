import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../AuthService/Authentication.dart';
import '../Controller/AllUserController.dart';
import 'SignUpScreen.dart';
import 'UserManagementScreen.dart';

class signInScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final AllUserController allUserController = Get.put(AllUserController());

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final AuthenticationService _authService = Get.put(AuthenticationService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Color(0xFF232F3E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          return ListView(
            children: [
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  labelStyle:
                      TextStyle(color: Color(0xFF232F3E)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFFFF9900), width: 2),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 15),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xFF232F3E)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF9900), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 25),

              if (errorMessage.isNotEmpty) ...[
                Text(
                  errorMessage.value,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
              ],

              ElevatedButton(//
                onPressed: isLoading.value ? null : _loginUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF9900), // Amazon Yellow
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isLoading.value
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
              SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: Color(0xFF232F3E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Color(0xFF232F3E)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(SignUpScreen());
                    },
                    child: Text(
                      "Create one",
                      style: TextStyle(
                        color: Color(0xFFFF9900),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }


  Future<void> _loginUser() async {
    isLoading.value = true;
    errorMessage.value = '';

    final email = _emailController.text;
    final password = _passwordController.text;

    bool success = await _authService.login(email, password);

    if (success) {
      await allUserController.fetchUsers();
      Get.to(UserManagementScreen());
      ScaffoldMessenger.of(Get.context!)
          .showSnackBar(SnackBar(content: Text('Login Successful')));
    } else {
      errorMessage.value = 'Invalid email or password';
    }

    isLoading.value = false;
  }
}
