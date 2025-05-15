import 'package:emp_management/logic/data/repositories/firebase_repositories.dart';
import 'package:emp_management/screens/menu_screen.dart';
import 'package:emp_management/screens/view_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isVisible = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xff6A0DAD),
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 68),
                    Image.asset(
                      'assets/images/image4.jpg',
                      width: 150,
                      height: 150,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
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
                      Row(
                        children: [
                          SizedBox(width: 8),
                          Text(
                            'Welcome back ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Text('👋', style: TextStyle(fontSize: 24)),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      TextField(
                        controller: _emailController,
                        decoration: buildInputDecoration(
                          label: 'Email',
                        ).copyWith(
                          prefixIcon: Icon(
                            Icons.people,
                            color: Color(0xff3D004D),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isVisible,
                        decoration: buildInputDecoration(
                          label: 'Password',
                        ).copyWith(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Color(0xff3D004D),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            icon: Icon(
                              _isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xff3D004D),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      InkWell(
                        onTap: () => _validateCredentials(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff3D004D),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          width: double.infinity,
                          height: 55,
                          child: Center(
                            child: Text(
                              'Login',
                              style: TextStyle(color: Color(0xffE6E6FA)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Text(
                '© 2025 Employee Management App. All rights reserved',
                style: TextStyle(fontSize: 14, color: Color(0xff6A0DAD)),
              ),
            ],
          ),
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

  void _validateCredentials(BuildContext context) async {
    HapticFeedback.vibrate();
    try {
      final isLoggedIn = await FirebaseRepositories().login(
        _emailController.text,
        _passwordController.text,
      );
      if (!context.mounted) return;
      if (isLoggedIn) {
        final isAdmin = await FirebaseRepositories().isAdmin(
          _emailController.text,
          _passwordController.text,
        );
        if (isAdmin) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MenuScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ViewScreen(emailController: _emailController),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error Username or Password is not correct')),
        );
      }
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('An error occurred: $e')));
    }
  }
}
