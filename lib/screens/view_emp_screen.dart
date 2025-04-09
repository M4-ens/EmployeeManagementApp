import 'package:employee_management/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class ViewEmpScreen extends StatefulWidget {
  @override
  _ViewEmpScreenState createState() => _ViewEmpScreenState();
}

class _ViewEmpScreenState extends State<ViewEmpScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _depController = TextEditingController();
  String? _selectedDepartment;

  List<String> _departments = ['HR', 'IT', 'Finance', 'Marketing'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('View Employee Details',style: TextStyle(fontWeight: FontWeight.bold)),
      // ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('View Employee Details',style: TextStyle(color: Color(0xff6A0DAD),fontSize: 30,fontWeight: FontWeight.bold)),
              SizedBox(height:24 ,),
              TextField(
                controller: _idController,
                decoration: buildInputDecoration(label: 'Enter Employee ID'),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _fetchEmpDetails();
                  });
                },
                icon: Icon(Icons.search, color: Colors.cyanAccent),
                label: Text('View Details'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nameController,
                readOnly: true,
                decoration: buildInputDecoration(label: 'Name'),
              ),
              SizedBox(height: 16),
              // DropdownButtonFormField<String>(
              //   hint: Text('Department', style: TextStyle(color: Colors.cyan)),
              //   value: _selectedDepartment,
              //   decoration: buildInputDecoration(),
              //   items:
              //       _departments
              //           .map(
              //             (dep) => DropdownMenuItem<String>(
              //               value: dep,
              //               child: Text(
              //                 dep,
              //                 style: TextStyle(color: Colors.black),
              //               ),
              //             ),
              //           )
              //           .toList(),
              //   onChanged:
              //       (dep) => setState(() {
              //         _selectedDepartment = dep;
              //       }),
              // ),
              TextField(
                controller: _depController,
                readOnly: true,
                decoration: buildInputDecoration(label: 'Department'),
              ),
              SizedBox(height: 16),
              // TextField(
              //   controller: _dateController,
              //   readOnly: true,
              //   decoration: buildInputDecoration(
              //     label: 'Date of Joining',
              //   ).copyWith(
              //     prefixIcon: Icon(Icons.calendar_today, color: Colors.cyan),
              //   ),
              //   onTap: () {
              //     _selectDate(context);
              //   },
              // ),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: buildInputDecoration(
                  label: 'Date of Joining',
                ).copyWith(
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.cyan),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _salaryController,
                readOnly: true,
                decoration: buildInputDecoration(label: 'Salary'),
              ),
              SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MenuScreen()),
                  );
                },
                icon: Icon(Icons.menu_open, color: Colors.cyanAccent),
                label: Text('Menu'),
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

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dateController.text = pickedDate.toString().split(" ")[0];
      });
    }
  }

  Future<void> _fetchEmpDetails() async {
    String? employeeId = _idController.text.trim();
    // Ensure employee ID is not empty
    if (employeeId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Enter a valid Employee Id'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    //if (شرط يتاكد ان ال id موجود اصلا) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("This Employee Id isn't exist"),
    //       shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(16),
    //       ),
    //       behavior: SnackBarBehavior.floating,
    //     ),
    //   );
    //   return;
    // }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Employee details returns successfully'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
