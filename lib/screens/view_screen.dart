import 'package:emp_management/logic/data/models/user_model.dart';
import 'package:emp_management/logic/data/repositories/firebase_repositories.dart';
import 'package:emp_management/screens/login_screen.dart';
import 'package:emp_management/screens/settings_emp_screen.dart';
import 'package:flutter/material.dart';

class ViewScreen extends StatefulWidget {
  final TextEditingController emailController;

  const ViewScreen({super.key, required this.emailController});

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _depController = TextEditingController();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.emailController.text;

    _fetchEmpDetails();
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _dateController.dispose();
    _salaryController.dispose();
    _depController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Details',
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextField(
                          controller: _nameController,
                          readOnly: true,
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
                        TextField(
                          controller: _emailController,
                          readOnly: true,
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
                          controller: _depController,
                          readOnly: true,
                          decoration: buildInputDecoration(
                            label: 'Department',
                          ).copyWith(
                            prefixIcon: Icon(
                              Icons.apartment,
                              color: Color(0xff3D004D),
                            ),
                          ),
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
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _salaryController,
                          readOnly: true,
                          decoration: buildInputDecoration(
                            label: 'Salary',
                          ).copyWith(
                            prefixIcon: Icon(
                              Icons.attach_money,
                              color: Color(0xff3D004D),
                            ),
                          ),
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
          selectedItemColor: Colors.white,
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
                MaterialPageRoute(
                  builder:
                      (context) =>
                          ViewScreen(emailController: widget.emailController),
                ),
              );
            }
            if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => SettingsEmpScreen(
                        emailController: widget.emailController,
                      ),
                ),
              );
            }
            if (index == 2) {
              //المفروض نخليه يعمل logout هنا
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda),
              label: 'View',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
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
  Future<void> _fetchEmpDetails() async {
    final UserModel? employeeDetails = await FirebaseRepositories()
        .getEmployeeByEmail(_emailController.text);

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
      _nameController.text = employeeDetails.name;
      _emailController.text = employeeDetails.email;
      _depController.text = employeeDetails.department;
      _dateController.text = employeeDetails.dateOfJoining;
      _salaryController.text = employeeDetails.salary;
    });
  }
}
