import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../model/users.dart';

class AuthController extends StateNotifier<Users> {
  AuthController() : super(Users());

  Future<Users?> checkUsers() async {
    final result = FirebaseAuth.instance.currentUser;
    if (result != null) {
      final user = await getUsers(uid: result.uid);
      return user;
    }
    return null;
  }

  Future<Users> getUsers({required String uid}) async {
    var checkUsers = await FirebaseFirestore.instance.collection('users').doc(uid).get();

    final users = Users.fromJson(checkUsers.data()!);
    state = users;
    return users;
  }

  Future<void> googleSignOut() async {
    await FirebaseAuth.instance.signOut();
    state = Users();
  }

  Future logIn(BuildContext context, String email, String password) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: HexColor('#B1B2FF'),
              ),
            ));

    try {
      var credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        var checkUsers = await FirebaseFirestore.instance
            .collection('users')
            .doc(
              credential.user!.uid,
            )
            .get();

        if (!checkUsers.exists) {
          return;
        } else {
          final users = Users.fromJson(checkUsers.data()!);

          state = users;
        }

        final users = Users.fromJson(checkUsers.data()!);

        if (!mounted) return;

        if (users.role == 'user') {
          Navigator.pushReplacementNamed(context, '/userhome');
        } else if (users.role == 'admin') {
          Navigator.pushReplacementNamed(context, '/adminhome');
        } else if (users.role == 'petugas') {
          Navigator.pushReplacementNamed(context, '/petugashome');
        }
      }
    } on FirebaseAuthException {
      Navigator.pop(context);
      AlertDialog(
        title: const Text('Login Failed :('),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('You failed to login using this account '),
              Text('Create new account or reset your password'),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    }
  }

  Future signUp(
    BuildContext context,
    String email,
    String password,
    String name,
  ) async {
    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: HexColor('#B1B2FF'),
              ),
            ));

    try {
      var credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      var checkUsers = await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).get();
      if (!checkUsers.exists) {
        await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set({
          'uid': credential.user!.uid,
          'name': name,
          'email': email,
          'photoUrl': '',
          'about': 'This is about section!',
          'role': 'user',
          'status': '',
        });
        final users = Users(
          uid: credential.user!.uid,
          name: name,
          email: email,
          photoUrl: '',
          about: 'This is about section!',
          role: 'user',
        );
        state = users;
      }
      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/userhome');
    } on FirebaseAuthException {
      Navigator.pop(context);
    }
  }
}

final authControllerProvider = StateNotifierProvider<AuthController, Users>(
  (ref) => AuthController(),
);
