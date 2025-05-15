import 'package:emp_management/logic/data/repositories/firebase_repositories.dart';
import 'package:emp_management/screens/login_screen.dart';
import 'package:emp_management/screens/view_screen.dart';
import 'package:flutter/material.dart';

class SettingsEmpScreen extends StatefulWidget {
  final TextEditingController emailController;

  const SettingsEmpScreen({super.key, required this.emailController});

  @override
  State<SettingsEmpScreen> createState() => _SettingsEmpScreenState();
}

class _SettingsEmpScreenState extends State<SettingsEmpScreen> {
  final TextEditingController _currentController = TextEditingController();
  final TextEditingController _newController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isVisible1 = false;
  bool _isVisible2 = false;
  bool _isVisible3 = false;

  int _index = 1;

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
                  'assets/images/imagePassword.jpg',
                  width: 150,
                  height: 150,
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(width: 8),
                    Icon(Icons.settings, size: 40, color: Color(0xff333333)),
                    SizedBox(width: 8),
                    Text(
                      'Change Your Password',
                      style: TextStyle(
                        color: Color(0xff6A0DAD),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffC8A2C8),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _currentController,
                          obscureText: !_isVisible1,
                          decoration: buildInputDecoration(
                            label: 'Current Password',
                          ).copyWith(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff3D004D),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible1 = !_isVisible1;
                                });
                              },
                              icon: Icon(
                                _isVisible1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xff3D004D),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _newController,
                          obscureText: !_isVisible2,
                          decoration: buildInputDecoration(
                            label: 'New Password',
                          ).copyWith(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff3D004D),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible2 = !_isVisible2;
                                });
                              },
                              icon: Icon(
                                _isVisible2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xff3D004D),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _confirmController,
                          obscureText: !_isVisible3,
                          decoration: buildInputDecoration(
                            label: 'Confirm New Password',
                          ).copyWith(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff3D004D),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible3 = !_isVisible3;
                                });
                              },
                              icon: Icon(
                                _isVisible3
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xff3D004D),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 64),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _changePassword();
                                  });
                                },
                                child: Text('Change'),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _currentController.clear();
                                    _newController.clear();
                                    _confirmController.clear();
                                  });
                                }, //لما نعمل الداتا بيز
                                child: Text('Clear'),
                              ),
                            ),
                            SizedBox(width: 64),
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
          selectedItemColor:Colors.white,
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
                MaterialPageRoute(builder: (context) => ViewScreen(emailController:widget.emailController)),
              );
            }
             if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsEmpScreen(emailController: widget.emailController,)),
              );
            }
            if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda),
              label: 'View',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
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

  void _changePassword() async {
  final current = _currentController.text;
  final newPass = _newController.text;
  final confirm = _confirmController.text;

  if (current.isEmpty || newPass.isEmpty || confirm.isEmpty) {
    _showMessage("All fields are required");
    return;
  }

  if (newPass != confirm) {
    _showMessage("New passwords do not match");
    return;
  }

  if (newPass == current) {
    _showMessage("New password must be different from current password");
    return;
  }

  try {
    await FirebaseRepositories().changePassword(current, newPass, widget.emailController.text);
    _showMessage("Password changed successfully!");
  } catch (e) {
    _showMessage("Failed to change password");
  }
}

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
