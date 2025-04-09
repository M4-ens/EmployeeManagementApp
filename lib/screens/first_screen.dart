import 'package:employee_management/screens/login_screen.dart';
import 'package:flutter/material.dart';
class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed:(){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        } ,
        label:Icon(Icons.arrow_right_alt_outlined,color:Color( 0xffE6E6FA),),
        icon:Text("Let's Go",style: TextStyle(color: Color( 0xffE6E6FA))),
        backgroundColor: Color(0xff9966A3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child:Text('Employee Management App',style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Color(0xff6A0DAD))),
        ),
      ),
    );
  }
}