import 'package:employee_management/screens/add_emp_screen.dart';
import 'package:employee_management/screens/delete_emp_screen.dart';
import 'package:employee_management/screens/login_screen.dart';
import 'package:employee_management/screens/menu_screen.dart';
import 'package:employee_management/screens/modify_emp_screen.dart';

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
        scaffoldBackgroundColor: Colors.blue[50],  
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white,
          ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[800], 
            foregroundColor: Colors.white,    
          ),
        ),
      ),
      home: ModifyEmpScreen(),
    );
  }
}