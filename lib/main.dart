import 'package:employee_management/screens/add_emp_screen.dart';
import 'package:employee_management/screens/delete_emp_screen.dart';
import 'package:employee_management/screens/first_screen.dart';
import 'package:employee_management/screens/login_screen.dart';
import 'package:employee_management/screens/menu_screen.dart';
import 'package:employee_management/screens/modify_emp_screen.dart';
import 'package:employee_management/screens/view_emp_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Management System',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue[800],
        scaffoldBackgroundColor: Color(0xffE6E6FA),  
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xffE6E6FA),
          foregroundColor:  Color(0xff6A0DAD),
          ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xff9966A3), 
            foregroundColor: Colors.white,    
          ),
        ),
      ),
      home: LoginScreen(),
    );
  }
}