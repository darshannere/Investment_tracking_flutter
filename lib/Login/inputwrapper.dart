import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:project/home.dart';

import 'button.dart';

import 'inputfield.dart';

class InputWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 41,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: InputField(),
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            "Forgot Password?",
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 40,
          ),
          Button(),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
            child: Text('Home'),
          )
        ],
      ),
    );
  }
}
