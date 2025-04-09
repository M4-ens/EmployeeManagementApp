import 'package:employee_management/screens/add_emp_screen.dart';
import 'package:employee_management/screens/delete_emp_screen.dart';
import 'package:employee_management/screens/modify_emp_screen.dart';
import 'package:employee_management/screens/view_emp_screen.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Employee Management System',style: TextStyle(fontWeight: FontWeight.bold),),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Add New Employee',style: TextStyle(color: Color(0xff6A0DAD),fontSize: 30,fontWeight: FontWeight.bold)),
            SizedBox(height:24 ,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(210, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddEmpScreen()),
                );
              },
              child: Text('Add Employee'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(210, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewEmpScreen()),
                );
              },
              child: Text('View Employee Details'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(210, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ModifyEmpScreen()),
                );
              },
              child: Text('Modify Employee Details'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(210, 50)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DeleteEmpScreen()),
                );
              },
              child: Text('Delete Employee'),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
