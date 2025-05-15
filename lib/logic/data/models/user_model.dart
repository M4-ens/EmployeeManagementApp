class UserModel {
  final String? id;
  final String name;
  final String email;
  final String? password;
  final String salary;
  final String department;
  final String dateOfJoining;
  final bool isAdmin;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.password,
    required this.salary,
    required this.department,
    required this.dateOfJoining,
    this.isAdmin = false,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String?,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String?,
      salary: map['salary'] as String,
      department: map['department'] as String,
      dateOfJoining: map['dateOfJoining'] as String,
      isAdmin: map['isAdmin'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'email': email,
      if (password != null) 'password': password,
      'salary': salary,
      'department': department,
      'dateOfJoining': dateOfJoining,
      'isAdmin': isAdmin,
    };
  }
}

