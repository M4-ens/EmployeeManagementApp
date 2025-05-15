import 'package:emp_management/logic/data/models/user_model.dart';
import 'package:emp_management/logic/data/repositories/firebase_repositories.dart';
import 'package:emp_management/screens/login_screen.dart';
import 'package:emp_management/screens/menu_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddEmpScreen extends StatefulWidget {
  const AddEmpScreen({super.key});

  @override
  State<AddEmpScreen> createState() => _AddEmpScreenState();
}

class _AddEmpScreenState extends State<AddEmpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  
  final List<String> _departments = ['IT', 'HR', 'Finance', 'Marketing', 'Security', 'IS', 'CS'];
  String? _selectedDep;

  int _index = 0;
  bool _isVisible1 = false;
  bool _isVisible2 = false;
  bool _isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add Employee',
                  style: TextStyle(
                    color: Color(0xff6A0DAD),
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffC8A2C8),
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isVisible1,
                          decoration: buildInputDecoration(
                            label: 'Password',
                          ).copyWith(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff3D004D),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible1 = !_isVisible1;
                                });
                              },
                              icon: Icon(
                                _isVisible1
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xff3D004D),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _confirmController,
                          obscureText: !_isVisible2,
                          decoration: buildInputDecoration(
                            label: 'Confirm Password',
                          ).copyWith(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff3D004D),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible2 = !_isVisible2;
                                });
                              },
                              icon: Icon(
                                _isVisible2
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Color(0xff3D004D),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          decoration: buildInputDecoration().copyWith(
                            prefixIcon: Icon(
                              Icons.apartment,
                              color: Color(0xff3D004D),
                            ),
                          ),
                          hint: Text(
                            'Select Department',
                            style: TextStyle(color: Color(0xff333333)),
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
                        SizedBox(height: 12),
                        TextField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: buildInputDecoration(
                            label: 'Date of joining',
                          ).copyWith(
                            prefixIcon: Icon(
                              Icons.calendar_today,
                              color: Color(0xff3D004D),
                            ),
                          ),
                          onTap: () {
                            _selectDate();
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
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                             onPressed: () async {
                              HapticFeedback.vibrate();
                              if (formValidator()) {
                                final UserModel newEmployee = UserModel(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  salary: _salaryController.text,
                                  department: _selectedDep!,
                                  dateOfJoining: _dateController.text,
                                  isAdmin: _isAdmin,
                                );

                                final bool result = await FirebaseRepositories().addEmployee(newEmployee);

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        result
                                          ? 'Employee Added Successfully'
                                          : 'This Employee already exists',
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }

                                if (result) {
                                  setState(() {
                                    _nameController.clear();
                                    _emailController.clear();
                                    _passwordController.clear();
                                    _confirmController.clear();
                                    _selectedDep = null;
                                    _dateController.clear();
                                    _salaryController.clear();
                                  });
                                }
                              }
                            },
                            child: Text(' Add '),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _nameController.clear();
                                  _emailController.clear();
                                  _passwordController.clear();
                                  _confirmController.clear();
                                  _selectedDep = null;
                                  _dateController.clear();
                                  _salaryController.clear();
                                });
                              },
                              child: Text('Clear'),
                            ),
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
              HapticFeedback.vibrate();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MenuScreen()),
              );
            }
            if (index == 1) {
              HapticFeedback.vibrate();
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

  Future<void> _selectDate() async {
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

  bool formValidator() {
        if (_nameController.text.isEmpty || 
        _emailController.text.isEmpty || 
        _passwordController.text.isEmpty || 
        _confirmController.text.isEmpty || 
        _salaryController.text.isEmpty || 
        _dateController.text.isEmpty || 
        _selectedDep == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }

    final password = _passwordController.text;
    final confirmPassword = _confirmController.text;
    final bool isMatch = password == confirmPassword;
    if (!isMatch) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Password and Confirm not Matched',
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return false;
    }
    return true;
  }
}
