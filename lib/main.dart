import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_21/Teacher/teacherdashboard.dart';
import 'package:flutter_web_21/student/studentdashboard.dart';
import 'package:google_fonts/google_fonts.dart';

import 'demo.dart';
import 'login/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.aBeeZeeTextTheme(),
        primaryColor: Colors.white,
      ),
      initialRoute: Demo.routName,
      //FirebaseAuth.instance.currentUser!=null?TeacherHomePage.routName:LoginPage.routName,
      routes: {
        LoginPage.routName: (context) => LoginPage(),
        StudentHomePage.routName: (context) => StudentHomePage(),
        TeacherHomePage.routName: (context) => TeacherHomePage(),
        Demo.routName: (context) => Demo()
      },
    );
  }
}
