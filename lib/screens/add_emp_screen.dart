import 'package:flutter/material.dart';

class AddEmpScreen extends StatefulWidget {
  const AddEmpScreen({super.key});

  @override
  State<AddEmpScreen> createState() => _AddEmpScreenState();
}

class _AddEmpScreenState extends State<AddEmpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  List<String> _departments = ['IT', 'HR', 'Finance', 'Marketing'];
  String? _selectedDep;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: Text('Add New Employee',style: TextStyle(fontWeight: FontWeight.bold)),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add New Employee',style: TextStyle(color: Color(0xff6A0DAD),fontSize: 30,fontWeight: FontWeight.bold)),
              SizedBox(height:24 ,),
              TextField(
                controller: _nameController,
                decoration: buildInputDecoration(label: 'Name'),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: buildInputDecoration(),
                hint: Text(
                  'Select Department',
                  style: TextStyle(color: Colors.cyan),
                ),
                value: _selectedDep,
                items:
                    _departments
                        .map(
                          (dep) => DropdownMenuItem(
                            value: dep,
                            child: Text(
                              dep,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                        .toList(),
                onChanged:
                    (dep) => setState(() {
                      _selectedDep = dep;
                    }),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _dateController,
                readOnly: true,
                decoration: buildInputDecoration(label: 'Date of joining').copyWith(
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.cyan),
                ),
                onTap: () {
                  _selectDate();
                },
              ),
              SizedBox(height: 16),
              TextField(
                controller: _salaryController,
                keyboardType: TextInputType.number,
                decoration: buildInputDecoration(label: 'Salary'),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {}, //لما نعمل الداتا بيز
                    icon: Icon(Icons.save, color: Colors.cyanAccent),
                    label: Text('Submit'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _nameController.clear();
                        _selectedDep = null;
                        _dateController.clear();
                        _salaryController.clear();
                      });
                    },
                    icon: Icon(Icons.delete, color: Colors.cyanAccent),
                    label: Text('Cancel'),
                  ),
                ],
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

  Future<void> _selectDate() async {
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
}
