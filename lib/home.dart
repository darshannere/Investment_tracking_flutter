import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/news/news.dart';
import 'package:project/portfolio.dart';
import 'package:project/services/cryptolist.dart';
import 'package:project/services/process.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ionicons/ionicons.dart';
import 'calculator.dart';
import 'loginpages/Methods.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final tabs = [portfolio(), test5(), cryptoHome_Page(), Calculator(), news()];

  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  var _userName;
  var data;
  var document = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .get();
  var myEmail;

  // fetchuserdata() {
  //   String uid = _auth.currentUser!.uid.toString();
  //   DocumentReference<Map<String, dynamic>> collectionReference =
  //       FirebaseFirestore.instance.collection('users').doc(uid);

  //   // ignore: non_constant_identifier_names
  //   _userName = collectionReference
  //       .get()
  //       .then((ds) => print(ds.data()));
  // }

  addData() {
    Map<String, dynamic> demoData = {"name": "Darshan Nere", "age": "19"};
    String uid = _auth.currentUser!.uid.toString();
    DocumentReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('data').doc(uid);
    collectionReference.set(demoData);
  }

  fetchData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('data');
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.docs[0].data();
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
        child: Container(
          color: Colors.grey[900],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659651_1280.png"),
                  radius: 80,
                ),
              ),
              Divider(
                height: 50,
              ),
              FutureBuilder(
                  future: fetchuserdata(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done)
                      return Text("Loading data...Please wait");
                    return Text(
                      "  Name : $_userName",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontSize: 15,
                      ),
                    );
                  }),
              SizedBox(
                height: 35,
              ),
              Text(
                "  Email : " + _auth.currentUser!.email.toString(),
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/about');
                  },
                  child: Text("  About")),
              TextButton(
                  onPressed: () {
                    logOut(context);
                  },
                  child: Text("  Logout")),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/contacts');
                  },
                  child: Text("  Contacts")),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/addata');
                  },
                  child: Text("  Addata")),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
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
              Icons.stacked_line_chart,
              color: Colors.grey,
            ),
            label: 'Stocks',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.monetization_on_rounded,
              color: Colors.grey,
            ),
            label: 'Crypto',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.calculate_rounded,
              color: Colors.grey,
            ),
            label: 'Calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.news_solid,
              color: Colors.grey,
            ),
            label: 'News',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  fetchuserdata() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myEmail = ds.data()!['email'];
        _userName = ds.data()!['name'];
        print(myEmail);
      }).catchError((e) {
        print(e);
      });
  }
}
