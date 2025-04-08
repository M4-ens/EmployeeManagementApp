import 'package:flutter/material.dart';
class ViewEmpScreen extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('View Employee Details'),
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
    );
  }
}