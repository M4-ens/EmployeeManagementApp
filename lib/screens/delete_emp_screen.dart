import 'package:flutter/material.dart';

class DeleteEmpScreen extends StatelessWidget {
  DeleteEmpScreen({super.key});
  final TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Delete Employee Details',style: TextStyle(fontWeight: FontWeight.bold)),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Delete Employee Details',style: TextStyle(color: Color(0xff6A0DAD),fontSize: 30,fontWeight: FontWeight.bold)),
              SizedBox(height:24 ,),
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
