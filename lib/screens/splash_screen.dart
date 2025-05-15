import 'package:emp_management/screens/login_screen.dart';
import 'package:flutter/material.dart';



// What is this??
// Flutter itself creates a splash screen, you don't need this.
// And by the way, if you want to make users wait 3 full seconds to log in???, remove this splash screen nowwwwwwwww.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3), () {});
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(
              //   'Employee ',
              //   style: TextStyle(
              //     fontSize: 40,
              //     fontWeight: FontWeight.bold,
              //     color: Color(0xff6A0DAD),
              //   ),
              // ),
              Image.asset(
                'assets/images/image.jpg',
                fit: BoxFit.cover,
                // width: double.infinity,
                // height: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}