import 'package:flutter/material.dart';
import 'package:project/services/process.dart';

import 'loginpages/Methods.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: TextButton(
            onPressed: () {
              logOut(context);
            },
            child: Text("logout")),
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
        ]),
      ),
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
