import 'package:employee_management/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.cyanAccent),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.account_circle,
              color: Colors.cyanAccent,
            ), // User account icon
            iconSize: 40,
            onPressed: () {
              print("User account icon tapped");
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _idController,
              decoration: buildInputDecoration(
                label: 'Employee Id',
              ).copyWith(prefixIcon: Icon(Icons.people, color: Colors.cyan)),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: !_isVisible,
              decoration: buildInputDecoration(label: 'Password').copyWith(
                prefixIcon: Icon(Icons.lock, color: Colors.cyan),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isVisible = !_isVisible;
                    });
                  },
                  icon: Icon(
                    _isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.cyan,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _validateCredentials(context),
              icon: Icon(Icons.login, color: Colors.cyanAccent),
              label: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration buildInputDecoration({String? label}) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.cyan),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 2, color: Colors.deepPurpleAccent),
      ),
      enabled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(width: 2, color: Colors.deepPurpleAccent),
      ),
    );
  }

  void _validateCredentials(BuildContext context) {
    String id = _idController.text.trim();
    String password = _passwordController.text.trim();
    //حسب اللي هيتخزن في الداتا بيز
    if (id == "admin" && password == "password") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MenuScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalide Credentials'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
