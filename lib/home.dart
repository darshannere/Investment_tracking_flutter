import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/services/process.dart';

import 'loginpages/Methods.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var data;

  addData() {
    Map<String, dynamic> demoData = {"name": "Darshan Nere", "age": "19"};
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    collectionReference.add(demoData);
  }

  fetchData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.docs[0].data();
        print(data);
      });
    });
  }

  deletdata() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    QuerySnapshot querySnapshot = await collectionReference.get();
    querySnapshot.docs[0].reference.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 90, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1542779283-429940ce8336?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cG9rZW1vbnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"),
                  radius: 50,
                ),
              ),
              Divider(
                height: 50,
              ),
              Text(
                'Name:',
                style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 2,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'Email id:',
                style: TextStyle(
                  color: Colors.blueGrey,
                  letterSpacing: 2,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 35,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  child: Text("About")),
              SizedBox(
                height: 35,
              ),
              TextButton(
                  onPressed: () {
                    logOut(context);
                  },
                  child: Text("logout")),
              SizedBox(
                height: 35,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/contacts');
                  },
                  child: Text("Contacts")),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text('Homescreen'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: ListView(children: [
          SizedBox(
            height: 30,
          ),
          Container(
            child: TextButton(
              onPressed: addData,
              child: Text("Add data"),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: fetchData,
              child: Text("Fetch data"),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: deletdata,
              child: Text("Delete data"),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                logOut(context);
              },
              child: Text(
                "LogOut",
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/cryptolist');
            },
            child: Card(
              elevation: 10,
              color: Colors.grey[900],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Text(
                  'Cryptos',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/stocklist');
            },
            child: Card(
              elevation: 10,
              color: Colors.grey[900],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Text(
                  'Stocks',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/calculator');
            },
            child: Card(
              elevation: 10,
              color: Colors.grey[900],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Text(
                  'Calculator',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/news');
            },
            child: Card(
              elevation: 10,
              color: Colors.grey[900],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Text(
                  'News',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Text(data.toString(), style: TextStyle(color: Colors.white))
        ]),
      ),

// sdad
//sdasd
//dsadsdsa,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monetization_on_rounded,
              color: Colors.grey,
            ),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.now_widgets,
              color: Colors.grey,
            ),
            label: 'School',
          ),
        ],
      ),
    );
  }
}
