import 'package:emp_management/screens/add_emp_screen.dart';
import 'package:emp_management/screens/delete_emp_screen.dart';
import 'package:emp_management/screens/login_screen.dart';
import 'package:emp_management/screens/modify_emp_screen.dart';
import 'package:emp_management/screens/view_emp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  //Edited By Mostafa
  // warning: implement _MenuScreenState createState() => _MenuScreenState();
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Menu',
                style: TextStyle(
                  color: Color(0xff6A0DAD),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 36),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(210, 80)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEmpScreen()),
                  );
                },
                child: Text('Add Employee'),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(210, 80)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewEmpScreen()),
                  );
                },
                child: Text('View Employee Details'),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(210, 80)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ModifyEmpScreen()),
                  );
                },
                child: Text('Modify Employee Details'),
              ),
              SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: Size(210, 80)),
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
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.purple[100],
          backgroundColor: Color(0xff3D004D),
          currentIndex: _index,
          onTap: (int index) {
            setState(() {
              _index = index;
            });
            if (index == 0) {
              HapticFeedback.vibrate();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              );
            }
            if (index == 1) {
              HapticFeedback.vibrate();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
          ],
        ),
    );
  }
}
