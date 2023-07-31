import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_multi_role_base_with_shared_prefs/Screens/student_screen.dart';
import 'package:flutter_multi_role_base_with_shared_prefs/Screens/teacher_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'admin_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isLogin();
  }

  void isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool('isLogin') ?? false;
    String userType = sp.getString('userType') ?? '';

    if (isLogin) {
      if (userType == 'Student') {
        Timer(const Duration(seconds: 3), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const StudentScreen()));
        });
      } else if (userType == 'Teacher') {
        Timer(const Duration(seconds: 3), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TeacherScreen()));
        });
      } else if(sp.getString('userType') == 'Admin') {
        Timer(const Duration(seconds: 3), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AdminScreen()));
        });
      }
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Image(
        height: double.infinity, //Vertically spread on whole screen.
        fit: BoxFit.cover,
        image: AssetImage('lib/assets/image.jpg'),
      ),
    );
  }
}
