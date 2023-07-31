import 'package:flutter/material.dart';
import 'package:flutter_multi_role_base_with_shared_prefs/Screens/student_screen.dart';
import 'package:flutter_multi_role_base_with_shared_prefs/Screens/teacher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<String> dropdownOptions = ['Student', 'Teacher', 'Admin'];
  String selectedOption = 'Student';
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final ageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedOption = dropdownOptions[0]; // Set initial selected option
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                  hintText: 'Email', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passController,
              decoration: const InputDecoration(
                  hintText: 'Password', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  hintText: 'Age', border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            InputDecorator(
              decoration: const InputDecoration(
                //labelText: 'Select an option',
                border: OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedOption,
                  isDense: true,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedOption = newValue ?? dropdownOptions[0];
                    });
                  },
                  items: dropdownOptions.map((String option) {
                    return DropdownMenuItem<String>(
                      value: option,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedOption = option;
                          });
                          Navigator.pop(context);
                        },
                        child: Text(option),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Display the selected option
            // Text(
            //   'Selected Option: ${selectedOption ?? 'None'}',
            //   style: TextStyle(fontSize: 16),
            // ),
            InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString('email', emailController.text.toString());
                sp.setString('age', ageController.text.toString());

                //admin, student, teacher
                sp.setString('userType', selectedOption);
                sp.setBool('isLogin', true);
                if (sp.getString('userType') == 'Teacher') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TeacherScreen()));
                } else if (sp.getString('userType') == 'Student') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentScreen()));
                } else if(sp.getString('userType') == 'Admin'){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminScreen()));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(5)),
                height: 60,
                width: double.infinity,
                child: const Center(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
