import 'package:cloud_firestore/cloud_firestore.dart';

import 'LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// void createUserInDatabaseWithGoogleProvider(User firebaseUser) async {
//   await FirebaseFirestore.instance.collection(USERS_COLLECTION).doc(firebaseUser.uid).set({
//     NAME_FIELD : firebaseUser.displayName,
//     EMAIL_FIELD: firebaseUser.email,

//   })

//   await Fire.collection(USERS_COLLECTION).document(firebaseUser.uid).setData({
//     NAME_FIELD : firebaseUser.displayName,
//     EMAIL_FIELD: firebaseUser.email,
//   }).whenComplete(() => print('Created user in database with Google Provider. Name: ${firebaseUser.displayName} | Email: ${firebaseUser.email}')).catchError((error) {print(error.toString());});

// }

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  adduser(name, email) {
    Map<String, dynamic> demoData = {"name": name, "email": email};
    String uid = _auth.currentUser!.uid.toString();
    DocumentReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('users').doc(uid);
    collectionReference.set(demoData);
  }

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    if (user != null) {
      print("Account created Succesfull");
      adduser(name, email);
      return user;
    } else {
      print("Account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Login Sucessfull");
      return user;
    } else {
      print("Login Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}
