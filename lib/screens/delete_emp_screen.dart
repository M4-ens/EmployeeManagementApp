import 'package:flutter/material.dart';

class DeleteEmpScreen extends StatelessWidget {
  DeleteEmpScreen({super.key});
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Delete Employee Details'),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: idController,
                decoration: buildInputDecoration(label: 'Enter Employee ID'),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {}, //لما نعمل الداتا بيز
                icon: Icon(Icons.delete, color: Colors.cyanAccent),
                label: Text('Delete'),
              ),
            ],
          ),
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
}
