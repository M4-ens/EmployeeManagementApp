import 'package:emp_management/logic/data/models/user_model.dart';
import 'package:emp_management/logic/data/repositories/firebase_repositories.dart';
import 'package:emp_management/screens/login_screen.dart';
import 'package:emp_management/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ModifyEmpScreen extends StatefulWidget {
  const ModifyEmpScreen({super.key});

  @override
  //Edited By Mostafa
  State<ModifyEmpScreen> createState() => _ModifyEmpScreenState();
}

class _ModifyEmpScreenState extends State<ModifyEmpScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _typeAdminController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  bool _isAdmin = false;
  String? _selectedDepartment;

  //Edited By Mostafa
  //The private field _departments could be 'final'.
  // List<String> _departments = ['HR', 'IT', 'Finance', 'Marketing'];
  final List<String> _departments = ['IT', 'HR', 'Finance', 'Marketing', 'Security', 'IS', 'CS'];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    if(_isAdmin == true){
      _typeAdminController.text = 'Admin';
    }else{
      _typeAdminController.text = 'Employee';
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Modify Details',
                style: TextStyle(
                  color: Color(0xff6A0DAD),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffC8A2C8),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _idController,
                        decoration: buildInputDecoration(
                          label: 'Enter Employee ID',
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            _fetchEmpDetails();
                          });
                        },
                      ),
                      SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          HapticFeedback.vibrate();
                          setState(() {
                            _fetchEmpDetails();
                          });
                        },
                        child: Text('Fetch Details'),
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _nameController,
                        decoration: buildInputDecoration(
                          label: 'Name',
                        ).copyWith(
                          prefixIcon: Icon(
                            Icons.person,
                            color: Color(0xff3D004D),
                          ),
                        ),
                      ),
                       SizedBox(height: 12),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xffE6E6FA),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          width: double.infinity,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              Icon(
                                Icons.admin_panel_settings,
                                color: Color(0xff3D004D),
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _isAdmin ? 'Admin' : 'Employee',
                                  style: TextStyle(
                                    color: Color(0xff333333),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Switch(
                                value: _isAdmin,
                                onChanged: (value) {
                                  setState(() {
                                    _isAdmin = !_isAdmin;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: buildInputDecoration(
                          label: 'Email',
                        ).copyWith(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Color(0xff3D004D),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        hint: Text(
                          'Department',
                          style: TextStyle(color: Color(0xff333333)),
                        ),
                        value: _selectedDepartment,
                        decoration: buildInputDecoration().copyWith(
                          prefixIcon: Icon(
                            Icons.apartment,
                            color: Color(0xff3D004D),
                          ),
                        ),
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
                      SizedBox(height: 12),
                      TextField(
                        controller: _dateController,
                        readOnly: true,
                        decoration: buildInputDecoration(
                          label: 'Date of Joining',
                        ).copyWith(
                          prefixIcon: Icon(
                            Icons.calendar_today,
                            color: Color(0xff3D004D),
                          ),
                        ),
                        onTap: () {
                          _selectDate(context);
                        },
                      ),
                      SizedBox(height: 12),
                      TextField(
                        controller: _salaryController,
                        keyboardType: TextInputType.number,
                        decoration: buildInputDecoration(
                          label: 'Salary',
                        ).copyWith(
                          prefixIcon: Icon(
                            Icons.attach_money,
                            color: Color(0xff3D004D),
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 64),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _saveChanges();
                                });
                              },
                              child: Text('Modify'),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                HapticFeedback.vibrate();
                                setState(() {
                                  _idController.clear();
                                  _nameController.clear();
                                  _emailController.clear();
                                  _selectedDepartment = null;
                                  _dateController.clear();
                                  _salaryController.clear();
                                });
                              },
                              child: Text('Clear'),
                            ),
                          ),
                          SizedBox(width: 64),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.0),
          topRight: Radius.circular(8.0),
        ),
        child: BottomNavigationBar(
          selectedItemColor: Colors.purple[100],
          unselectedItemColor: Colors.purple[100],
          backgroundColor: Color(0xff3D004D),
          currentIndex: _index,
          onTap: (int index) {
            setState(() {
              _index = index;
            });
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              );
            }
            if (index == 1) {
              //المفروض نخليه يعمل logout هنا
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Menu'),
            BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'Logout'),
          ],
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

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime.now().add(Duration(days: 90)),
    );
    setState(() {
      _dateController.text = pickedDate.toString().split(" ")[0];
    });
  }

  Future<void> _fetchEmpDetails() async {
    String? employeeId = _idController.text.trim();
    if (employeeId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Enter a Employee Id'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final UserModel? employeeDetails = await FirebaseRepositories()
        .getEmployeeById(employeeId);

    if (employeeDetails == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No Employee found with this id'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    setState(() {
      _idController.text = employeeDetails.id!;
      _nameController.text = employeeDetails.name;
      _emailController.text = employeeDetails.email;
      _isAdmin = employeeDetails.isAdmin;
      _selectedDepartment = employeeDetails.department;
      _dateController.text = employeeDetails.dateOfJoining;
      _salaryController.text = employeeDetails.salary;

      
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Employee details fetched successfully'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _saveChanges() async {
    final UserModel employee = UserModel(
      id: _idController.text,
      name: _nameController.text,
      email: _emailController.text,
      isAdmin: _isAdmin,
      department: _selectedDepartment!,
      dateOfJoining: _dateController.text,
      salary: _salaryController.text,
    );
    await FirebaseRepositories().updateEmployee(employee);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Employee details Modified successfully'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
