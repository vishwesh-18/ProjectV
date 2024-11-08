import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../AuthService/Authentication.dart';
import 'signInScreen.dart';

class SignUpScreen extends StatelessWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var isLoading = false.obs;


  final userService = AuthenticationService();
  final _formKey = GlobalKey<FormState>();
//

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
        backgroundColor: Color(0xFF232F3E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  labelStyle: TextStyle(color: Color(0xFF232F3E)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF9900), width: 2),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your name";
                  }
                },
              ),
              SizedBox(height: 15),

              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFF232F3E)),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFFF9900), width: 2),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                },
              ),
              SizedBox(height: 15),

              TextFormField(
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a password";
                  }
                  if (value.length < 6) {
                    return "Password must be at least 6 characters long";
                  }
                },

              ),
              SizedBox(height: 15),

              Obx(() {
                return ElevatedButton(
                  onPressed: isLoading.value
                      ? null
                      : () async {
                    if (_formKey.currentState?.validate() ?? false) {
                    userService.saveUser(  _nameController.text,_emailController.text, _passwordController.text, );
                    await userService.signUp(_nameController.text,  _emailController.text,  _passwordController.text,);
                    Get.snackbar('Registration Successful', 'Welcome ${_nameController.text}',
                        snackPosition: SnackPosition.BOTTOM);
                    Get.to(signInScreen());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF9900), // Amazon Yellow
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child:isLoading.value
                      ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : Text(
                    "Create Account",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                );
              }),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: Color(0xFF232F3E)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(signInScreen());
                      // Handle navigation to Login screen
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                        color: Color(0xFFFF9900), // Amazon Yellow
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
