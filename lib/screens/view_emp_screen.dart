import 'package:emp_management/logic/data/models/user_model.dart';
import 'package:emp_management/logic/data/repositories/firebase_repositories.dart';
import 'package:emp_management/screens/login_screen.dart';
import 'package:emp_management/screens/menu_screen.dart';
import 'package:flutter/material.dart';

class ViewEmpScreen extends StatefulWidget {
  const ViewEmpScreen({super.key});

  @override
  State<ViewEmpScreen> createState() => _ViewEmpScreenState();
}

class _ViewEmpScreenState extends State<ViewEmpScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _depController = TextEditingController();
  int _index = 0;

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
                          controller: _idController,
                          decoration: buildInputDecoration(
                            label: 'Enter Employee ID',
                          ),
                        ),
                        SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _fetchEmpDetails();
                            });
                          },
                          child: Text('View Details'),
                        ),
                        SizedBox(height: 12),
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
      _depController.text = employeeDetails.department;
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
}
