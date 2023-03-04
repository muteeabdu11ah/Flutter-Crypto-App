import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptocurrency_app/ui/home.dart';
import 'package:cryptocurrency_app/ui/screens/lottery.dart';
import 'package:cryptocurrency_app/ui/widgets/details/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authMethods extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //SIGNIN USER
  Future<void> signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      //CREATE USER
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          FirebaseAuthException == false) {
        UserCredential cred = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      }
    } on FirebaseAuthException catch (err) {
      showsnackbar(context, err.message!);
    }
    notifyListeners();
  }

  //SIGNUP USER
  Future<void> signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      //CREATE USER
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
        //ADD USER DATA TO DATABASE
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'username': name,
          'uid': cred.user!.uid,
          'email': email,
          'balance': 1000,
        });
      }
    } on FirebaseAuthException catch (err) {
      showsnackbar(context, err.message!);
    }
  }

  Future<void> SignOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home()));
  }

  fetchdata(UserCredential cred) {
    _firestore.collection('users').doc(cred.user!.uid).get();
  }
}
