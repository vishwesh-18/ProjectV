import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Model/UserModel.dart';
import '../Controller/AllUserController.dart';

class UserUpdateScreen extends StatelessWidget {
  final UserModel user;

  UserUpdateScreen({Key? key, required this.user}) : super(key: key);
  final AllUserController allUserController = Get.put(AllUserController());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController occupationController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    nameController.text = user.name;
    emailController.text = user.email;
    countryController.text = user.country!;
    genderController.text = user.gender!;
    occupationController.text = user.occupation!;
    contactController.text = user.contact!;


    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Color(0xFF232F3E),
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          '',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text("${user.id}"),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: TextStyle(color: Color(0xFF232F3E)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: genderController,
              decoration: InputDecoration(
                labelText: 'Gender',
                labelStyle: TextStyle(color: Color(0xFF232F3E)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: occupationController,
              decoration: InputDecoration(
                labelText: 'Occupation',
                labelStyle: TextStyle(color: Color(0xFF232F3E)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Color(0xFF232F3E)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contactController,
              decoration: InputDecoration(
                labelText: 'Mobile No',
                labelStyle: TextStyle(color: Color(0xFF232F3E)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: countryController,
              decoration: InputDecoration(
                labelText: 'country',
                labelStyle: TextStyle(color: Color(0xFF232F3E)),
              ),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () async {
                await allUserController.updateUser(
                  user.id,
                  nameController.text,
                  emailController.text,
                    countryController.text,
                    genderController.text ,
                    occupationController.text ,
                    contactController.text,
                );
                await allUserController.fetchUsers();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: Text('Save Changes', style: TextStyle(color: Colors.white)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF232F3E),
                padding: EdgeInsets.symmetric(vertical: 12.0),
                textStyle: TextStyle(fontSize: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
