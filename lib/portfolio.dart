import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class portfolio extends StatefulWidget {
  const portfolio({Key? key}) : super(key: key);

  @override
  _portfolioState createState() => _portfolioState();
}

class _portfolioState extends State<portfolio> {
  var data;

  fetchData() {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('stocks');
    collectionReference.snapshots().listen((snapshot) {
      setState(() {
        data = snapshot.docs[0].data();
      });
    });
  }

  late List<PieChartSectionData> _sections;

  @override
  void initState() {
    super.initState();
    this.fetchData();
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
        body: Scrollbar(
          child: Column(children: [
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
                      Column(children: [
                        Container(
                          child: AspectRatio(
                              aspectRatio: 1.9,
                              child: PieChart(PieChartData(
                                  sections: _sections,
                                  borderData: FlBorderData(show: false),
                                  centerSpaceRadius: 40))),
                        ),
                        Container(
                          child: ListTile(
                            title: Text(
                              _sections[0].title.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Total value' + _sections[0].value.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            title: Text(
                              _sections[1].title.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Total value' + _sections[1].value.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            title: Text(
                              _sections[2].title.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Total value' + _sections[2].value.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            title: Text(
                              _sections[3].title.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              'Total value' + _sections[3].value.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        // Container(
                        //   child: new ListView.builder(
                        //     // ignore: unnecessary_null_comparison
                        //     itemCount: _sections == null ? 0 : _sections.length,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       // ignore: unused_local_variable

                        //       return new ListTile(
                        //         dense: true,
                        //         // leading: new CircleAvatar(
                        //         //   backgroundColor: Color(
                        //         //           (Random().nextDouble() * 0xFFFFFF)
                        //         //               .toInt())
                        //         //       .withOpacity(1.0),
                        //         //   child: new Text(_sections[index].title[0]),
                        //         // ),
                        //         title: new Text(
                        //           _sections[index].title,
                        //           style: new TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.white),
                        //         ),
                        //         subtitle: new Text(
                        //           'Total value' +
                        //               _sections[index].value.toString(),
                        //           style: new TextStyle(
                        //               fontWeight: FontWeight.bold,
                        //               color: Colors.white),
                        //         ),
                        //       );
                        //     },
                        //   ),
                        // )
                      ]),
                    ]))
          ]),
        ));
  }
}


// ListTile(
//                             title: Text(
//                           _sections[0].title.toString(),
//                           style: TextStyle(color: Colors.white),)),