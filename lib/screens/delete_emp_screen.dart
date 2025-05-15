import 'package:emp_management/logic/data/repositories/firebase_repositories.dart';
import 'package:emp_management/screens/login_screen.dart';
import 'package:emp_management/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeleteEmpScreen extends StatefulWidget {
  //Edited By Mostafa Constructor Must be const
  const DeleteEmpScreen({super.key});

  @override
  //Edited By Mostafa Fix State Api
  State<DeleteEmpScreen> createState() => _DeleteEmpScreenState();
}

class _DeleteEmpScreenState extends State<DeleteEmpScreen> {
  final TextEditingController _idController = TextEditingController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/delete_image.png',
                  width: 100,
                  height: 150,
                ),

                Text(
                  'Delete Employee',
                  style: TextStyle(
                    color: Color(0xff6A0DAD),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffC8A2C8),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _idController,
                          decoration: buildInputDecoration(
                            label: 'Enter Employee ID',
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              size: (30),
                              color: Color(0xff3D004D),
                            ),
                            SizedBox(width: 16.0),
                            Text(
                              "Are you sure you want to delete this employee?",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              // onPressed: () {
                              //   HapticFeedback.vibrate();
                              //   FirebaseRepositories().deleteEmployee(
                              //     _idController.text,
                              //   );
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //         content: Text(
                              //           'Employee Deleted Successfully',
                              //         ),
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(16),
                              //         ),
                              //         behavior: SnackBarBehavior.floating,
                              //       ),
                              //     );
                              //   if (_idController.text.isEmpty) {
                              //     ScaffoldMessenger.of(context).showSnackBar(
                              //       SnackBar(
                              //         content: Text('Please Enter Employee ID'),
                              //         behavior: SnackBarBehavior.floating,
                              //         shape: RoundedRectangleBorder(
                              //           borderRadius: BorderRadius.circular(12),
                              //         ),
                              //       ),
                              //     );
                              //   }
                              // },
                              onPressed: () async {
                                  HapticFeedback.vibrate();

                                  if (_idController.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Please Enter Employee ID'),
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  bool result = await FirebaseRepositories().deleteEmployee(_idController.text);

                                  if (result) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Employee Deleted Successfully'),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Employee ID Not Found'),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  }
                                },

                              child: Text('Delete'),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                HapticFeedback.vibrate();
                                setState(() {
                                  _idController.clear();
                                });
                              },
                              child: Text(' Clear '),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.purple[100],
          unselectedItemColor: Colors.purple[100],
          backgroundColor: Color(0xff3D004D),
          currentIndex: _index,
          onTap: (int index) {
            setState(() {
              _index = index;
            });
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              );
            }
            if (index == 1) {
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
      ),
    );
  }

  InputDecoration buildInputDecoration({String? label}) {
    return InputDecoration(
      hintText: label,
      hintStyle: TextStyle(color: Color(0xff333333)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 2, color: Color(0xffE6E6FA)),
      ),
      enabled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 2, color: Color(0xffE6E6FA)),
      ),
      filled: true,
      fillColor: Color(0xffE6E6FA),
    );
  }
}
