import 'package:flutter/material.dart';

class ModifyEmpScreen extends StatefulWidget {
  ModifyEmpScreen({super.key});

  @override
  _ModifyEmpScreenState createState() => _ModifyEmpScreenState();
}

class _ModifyEmpScreenState extends State<ModifyEmpScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  String? _selectedDepartment;

  List<String> _departments = ['HR', 'IT', 'Finance', 'Marketing'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Modify Employee Details'),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
              label: Text('Fetch Details'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: buildInputDecoration(label: 'Name'),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              hint: Text('Department', style: TextStyle(color: Colors.cyan)),
              value: _selectedDepartment,
              decoration: buildInputDecoration(),
              items:
                  _departments
                      .map(
                        (dep) => DropdownMenuItem<String>(
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
                    _selectedDepartment = dep;
                  }),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _dateController,
              readOnly: true,
              decoration: buildInputDecoration(
                label: 'Date of Joining',
              ).copyWith(
                prefixIcon: Icon(Icons.calendar_today, color: Colors.cyan),
              ),
              onTap: () {
                _selectDate(context);
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _salaryController,
              keyboardType: TextInputType.number,
              decoration: buildInputDecoration(label: 'Salary'),
            ),
            SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _saveChanges();
                });
              },
              icon: Icon(Icons.save, color: Colors.cyanAccent),
              label: Text('Save Changes'),
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
    //عشان لو مخدلش الid
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

    //المفروض نحط شرط هنا يتاكد ان الid ده موجود اصلا
    // if(){
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
        content: Text('Employee details fetched successfully'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _saveChanges() async {
    //عشان لو مدخلش البيانات كلها
    if (_nameController.text.isEmpty ||
        _selectedDepartment!.isEmpty ||
        _dateController.text.isEmpty ||
        _salaryController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all the details'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }

    String? name = _nameController.text;
    String? department = _selectedDepartment!;
    String? date = _dateController.text;
    String? salary = _salaryController.text;

    //على اعتبار ان البيانات اتحفظت صح
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Employee details saved successfully'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
