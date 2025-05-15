import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emp_management/core/const/const.dart';
import 'package:emp_management/logic/data/models/user_model.dart';
import 'package:flutter/material.dart';

class FirebaseRepositories {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore
            .collection(Const.usersCollection)
            .where('email', isEqualTo: email)
            .where('password', isEqualTo: password)
            .get();
    return snapshot.docs.isNotEmpty;
  }

  Future<bool> isAdmin(String email, String password) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore
            .collection(Const.usersCollection)
            .where('email', isEqualTo: email)
            .where('password', isEqualTo: password)
            .where('isAdmin', isEqualTo: true)
            .get();
    return snapshot.docs.isNotEmpty;
  }

 Future<bool> addEmployee(UserModel user) async {
  QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
      .collection(Const.usersCollection)
      .where('email', isEqualTo: user.email)
      .get();

  if (snapshot.docs.isEmpty) {
    DocumentReference docRef =
        firestore.collection(Const.usersCollection).doc();
    await docRef.set({'id': docRef.id, ...user.toMap()});
    return true; 
  } else {
    return false;
  }
}


    Future<bool> deleteEmployee(String id) async {
    try {
      final docRef = firestore.collection(Const.usersCollection).doc(id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        return false; 
      }

      await docRef.delete();
      return true; 
    } catch (e) {
      print('Error deleting employee: $e');
      return false;
    }
  }


  Future<UserModel?> getEmployeeById(String id) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection(Const.usersCollection).doc(id).get();
    if (snapshot.exists) {
      return UserModel.fromMap(snapshot.data()!);
    }
    return null;
  }

  Future<UserModel?> getEmployeeByEmail(String email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore
            .collection(Const.usersCollection)
            .where('email', isEqualTo: email)
            .get();
    if (snapshot.docs.isNotEmpty) {
      return UserModel.fromMap(snapshot.docs.first.data());
    }
    return null;
  }


  Future<void> changePassword(String currentPassword, String newPassword, String email) async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await firestore
            .collection(Const.usersCollection)
            .where('email', isEqualTo: email)
            .where('password', isEqualTo: currentPassword)
            .get();
    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference
          .update({'password': newPassword});
    }
  }

  Future<void> updateEmployee(UserModel employee) async {
    await firestore
        .collection(Const.usersCollection)
        .doc(employee.id)
        .update(employee.toMap());
  }
}
