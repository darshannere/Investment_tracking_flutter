import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/news/news.dart';
import 'package:flutter/material.dart';
import 'package:project/calculator.dart';
import 'package:project/services/cryptolist.dart';
import 'home_page.dart';
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
