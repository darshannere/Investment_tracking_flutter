import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class portfolio extends StatefulWidget {
  const portfolio({Key? key}) : super(key: key);

  @override
  _portfolioState createState() => _portfolioState();
}

class _portfolioState extends State<portfolio> {
  var data;
  var stocklist;
  List stocks = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> getsData(stname) async {
    var stock;
    var response = await http.get(
        Uri.parse(
            'https://latest-stock-price.p.rapidapi.com/any?Identifier=$stname' +
                'EQN'),
        headers: {
          "X-RapidAPI-Key": "b5e366e646msh24e4c9775b01424p1a625fjsnf41e0d7c9961"
        });
    this.setState(() {
      stock = jsonDecode(response.body);
      print(stock);
    });

    return "Success!";
  }

  fetchuserstockdata() async {
    List itemsList = [];
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    if (firebaseUser != null)
      await FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseUser.uid)
          .collection('stocks')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach(
          (element) {
            itemsList.add(element.data);
          },
        );
        stocklist = itemsList;
      }).catchError((e) {
        print(e);
      });
    print(itemsList);
    return itemsList;
  }

  late List<PieChartSectionData> _sections;

  @override
  void initState() {
    super.initState();
    this.fetchuserstockdata();

    print(stocklist);

    PieChartSectionData _item1 = PieChartSectionData(
        color: Colors.blueAccent,
        value: 500000,
        title: 'WIPRO',
        radius: 50,
        titleStyle: TextStyle(color: Colors.white, fontSize: 14));
    PieChartSectionData _item2 = PieChartSectionData(
        color: Colors.purpleAccent,
        value: 640000,
        title: 'Reliance',
        radius: 50,
        titleStyle: TextStyle(color: Colors.white, fontSize: 14));
    PieChartSectionData _item3 = PieChartSectionData(
        color: Colors.cyanAccent,
        value: 1000000,
        title: 'SBIN',
        radius: 50,
        titleStyle: TextStyle(color: Colors.white, fontSize: 14));
    PieChartSectionData _item4 = PieChartSectionData(
        color: Colors.orangeAccent,
        value: 1300000,
        title: 'NTPC',
        radius: 50,
        titleStyle: TextStyle(color: Colors.white, fontSize: 14));
    _sections = [_item1, _item2, _item3, _item4];
  }

// ignore: deprecated_member_use

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(children: [
          Container(
              padding: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Portfolio',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                    Container(
                      child: AspectRatio(
                          aspectRatio: 2,
                          child: PieChart(PieChartData(
                              sections: _sections,
                              borderData: FlBorderData(show: false),
                              centerSpaceRadius: 40))),
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(_auth.currentUser!.uid)
                            .collection('stocks')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return SizedBox(
                            height: 300,
                            child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      subtitle: _getSubtitleText(
                                          double.parse(snapshot
                                              .data!.docs[index]["price"]),
                                          (snapshot.data!.docs[index]
                                              ["stockname"])),
                                      trailing: Text(snapshot.data!.docs[index]
                                          ["quantity"]),
                                      title: Text(snapshot.data!.docs[index]
                                          ["stockname"]),
                                    ),
                                  );
                                }),
                          );
                        },
                      ),
                    ),
                  ]))
        ]));
  }

  Widget _getSubtitleText(double price, String sname) {
    TextSpan priceTextWidget = new TextSpan(
        text: "price bought: ₹$price   ",
        style: TextStyle(color: Colors.grey[600]));

    TextSpan cpriceTextWidget = new TextSpan(
        text: "price : ₹  ", style: TextStyle(color: Colors.grey[600]));

    return new RichText(
        text: new TextSpan(children: [priceTextWidget, cpriceTextWidget]));
  }
}


// ListTile(

//                             title: Text(
//                           _sections[0].title.toString(),
//                           style: TextStyle(color: Colors.white),)),









  // Container(
  //                       child: ListTile(
  //                         title: Text(
  //                           _sections[0].title.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         subtitle: Text(
  //                           'Total value' + _sections[0].value.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       child: ListTile(
  //                         title: Text(
  //                           _sections[1].title.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         subtitle: Text(
  //                           'Total value' + _sections[1].value.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       child: ListTile(
  //                         title: Text(
  //                           _sections[1].title.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         subtitle: Text(
  //                           'Total value' + _sections[1].value.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       child: ListTile(
  //                         title: Text(
  //                           _sections[1].title.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         subtitle: Text(
  //                           'Total value' + _sections[1].value.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       child: ListTile(
  //                         title: Text(
  //                           _sections[2].title.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         subtitle: Text(
  //                           'Total value' + _sections[2].value.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       child: ListTile(
  //                         title: Text(
  //                           _sections[3].title.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                         subtitle: Text(
  //                           'Total value' + _sections[3].value.toString(),
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
