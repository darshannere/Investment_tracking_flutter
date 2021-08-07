import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class addata extends StatefulWidget {
  const addata({Key? key}) : super(key: key);

  @override
  _addataState createState() => _addataState();
}

class _addataState extends State<addata> {
  TextEditingController name = new TextEditingController();
  TextEditingController quant = new TextEditingController();
  TextEditingController pri = new TextEditingController();
  final myController = TextEditingController();
  var dataadded = false;
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

  adduserstock() {
    Map<String, dynamic> demoData = {
      "name": _auth.currentUser!.displayName,
      "email": _auth.currentUser!.email
    };
    Map<String, dynamic> stockd = {
      "stockname": " Nothing yet",
      "price": "0",
      "quantity": "0"
    };
    String uid = _auth.currentUser!.uid.toString();
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('stocks');
    collectionReference.add(stockd);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(hintText: "stockname"),
                  ),
                  TextFormField(
                    controller: quant,
                    decoration: InputDecoration(hintText: "quantity"),
                  ),
                  TextFormField(
                    controller: pri,
                    decoration: InputDecoration(hintText: "price"),
                  ),

                  RaisedButton(
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      ),
                      onPressed: () {
                        Map<String, dynamic> data = {
                          "stockname": name.text,
                          "quantity": quant.text,
                          "price": pri.text
                        };
                        String uid = _auth.currentUser!.uid.toString();
                        CollectionReference<Map<String, dynamic>>
                            collectionReference = FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .collection('stocks');
                        collectionReference.add(data);
                      }),
                  Text(myController.text)
                  // Add TextFormFields and ElevatedButton here.
                ],
              ),
            ),
            Container(
              child: TextButton(
                onPressed: adduserstock,
                child: Text("add"),
              ),
            )
          ],
        ));
  }
}

class _auth {}
