import 'dart:async';
import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// ignore: unused_import
import 'package:project/loginpages/Methods.dart';
import 'package:project/services/stockdetailpage.dart';

// ignore: camel_case_types
class stockclass {
  late List stocklist;
  stockclass(this.stocklist);
}

// ignore: camel_case_types
class test5 extends StatefulWidget {
  const test5({Key? key}) : super(key: key);

  @override
  _ProcessState createState() => _ProcessState();
}

class _ProcessState extends State<test5> {
  List stocks = [];
  final List<MaterialColor> _colors = [
    Colors.blue,
    Colors.indigo,
    Colors.red,
    Colors.amber,
    Colors.deepPurple
  ];

  Future<String> getData() async {
    var response = await http.get(
        Uri.parse('https://latest-stock-price.p.rapidapi.com/any'),
        headers: {
          "X-RapidAPI-Key": "b5e366e646msh24e4c9775b01424p1a625fjsnf41e0d7c9961"
        });
    this.setState(() {
      stocks = jsonDecode(response.body);
    });

    print(stocks);

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Stocks',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                // Text(
                //   "November 23",
                //   style: TextStyle(
                //     color: Colors.grey[400],
                //     fontSize: 29,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 0,
                    // child: TextField(
                    //   decoration: InputDecoration(
                    //       hintStyle: TextStyle(color: Colors.grey),
                    //       hintText: 'Search',
                    //       prefix: Icon(
                    //         Icons.search,
                    //         color: Colors.grey,
                    //       ),
                    //       fillColor: Colors.grey[800],
                    //       filled: true,
                    //       border: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(20)),
                    //           borderSide: BorderSide(style: BorderStyle.none))),
                    // ),
                  ),
                ),
                Expanded(
                  child: new ListView.builder(
                    // ignore: unnecessary_null_comparison
                    itemCount: stocks == null ? 0 : stocks.length,
                    itemBuilder: (BuildContext context, int index) {
                      // ignore: unused_local_variable
                      final MaterialColor color =
                          _colors[index % _colors.length];

                      return new ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => stockdetailpage(
                                passedlist: stocks,
                                passedindex: index,
                              ),
                              // Pass the arguments as part of the RouteSettings. The
                              // DetailScreen reads the arguments from these settings.
                              settings: RouteSettings(
                                arguments: stocks[index],
                              ),
                            ),
                          );
                        },
                        leading: new CircleAvatar(
                          backgroundColor:
                              Color((Random().nextDouble() * 0xFFFFFF).toInt())
                                  .withOpacity(1.0),
                          child: new Text(stocks[index]['symbol'][0]),
                        ),
                        title: new Text(
                          stocks[index]['symbol'],
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        subtitle: _getSubtitleText(
                            stocks[index]['lastPrice'].toDouble(),
                            stocks[index]['pChange'].toDouble()),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _getSubtitleText(double price, double precentageChange) {
    TextSpan priceTextWidget = new TextSpan(
        text: "₹$price   ", style: TextStyle(color: Colors.grey[600]));
    String precentageChangeText = "  $precentageChange%";
    TextSpan percentageChangeTextWidget;

    percentageChangeTextWidget = new TextSpan(
        text: precentageChangeText, style: new TextStyle(color: Colors.green));
    if (precentageChange > 0.00) {
      percentageChangeTextWidget = new TextSpan(
          text: precentageChangeText,
          style: new TextStyle(backgroundColor: Colors.green));
    } else {
      percentageChangeTextWidget = new TextSpan(
          text: precentageChangeText,
          style: new TextStyle(backgroundColor: Colors.red));
    }

    return new RichText(
        text: new TextSpan(
            children: [priceTextWidget, percentageChangeTextWidget]));
  }
}
