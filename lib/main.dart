import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/adddata.dart';
import 'package:project/infopages/about.dart';
import 'package:project/infopages/contacts.dart';
import 'package:project/news/news.dart';
import 'package:flutter/material.dart';
import 'package:project/calculator.dart';
import 'package:project/services/cryptolist.dart';
import 'Login/loginpage.dart';
import 'home.dart';
import 'package:project/services/process.dart';
import 'package:firebase_core/firebase_core.dart';

import 'loginpages/Authenticate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  {
    runApp(MaterialApp(
      theme: new ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/addata': (context) => addata(),
        '/about': (context) => about(),
        '/contacts': (context) => contacts(),
        '/news': (context) => news(),
        '/calculator': (context) => Calculator(),
        '/cryptolist': (context) => cryptoHome_Page(),
        '/stocklist': (context) => test5(),
        '/': (context) => Authenticate(),
        '/home': (context) => Home(),
      },
    ));
  }
}
