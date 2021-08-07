import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addata extends StatefulWidget {
  const addata({Key? key}) : super(key: key);

  @override
  _addataState createState() => _addataState();
}

class _addataState extends State<addata> {
  final myController = TextEditingController();
  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  late String _name = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  adduser() {
    Map<String, dynamic> demoData = {
      "name": _auth.currentUser!.displayName,
      "email": _auth.currentUser!.email
    };
    String uid = _auth.currentUser!.uid.toString();
    DocumentReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('users').doc(uid);
    collectionReference.set(demoData);
  }

  Widget _buidname() {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(labelText: 'name'),
      validator: (value) {
        if (value!.isEmpty) {
          return "name is required";
        }
        return null;
      },
      onFieldSubmitted: (value) {
        setState(() {
          _name = value.toString();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Form ")),
        body: Column(
          children: [
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buidname(),
                    RaisedButton(
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          print(myController.text);

                          _formKey.currentState!.save();
                        }),
                    Text(myController.text)
                    // Add TextFormFields and ElevatedButton here.
                  ],
                ),
              ),
            ),
            Container(
              child: TextButton(
                onPressed: adduser,
                child: Text("add"),
              ),
            )
          ],
        ));
  }
}

class _auth {}
