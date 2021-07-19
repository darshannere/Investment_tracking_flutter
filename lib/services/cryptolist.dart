import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'cryptodetailpage.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class cryptoclass {
  late List cryptolist1;
  cryptoclass(this.cryptolist1);
}

// ignore: camel_case_types
class cryptoHome_Page extends StatefulWidget {
  @override
  cryptoHome_PageState createState() => new cryptoHome_PageState();
}

// ignore: camel_case_types
class cryptoHome_PageState extends State<cryptoHome_Page> {
  List cryptos = [];

  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  Future<String> getData1() async {
    var response = await http.get(
        Uri.parse('https://coinpaprika1.p.rapidapi.com/tickers'),
        headers: {
          "X-RapidAPI-Key": "b5e366e646msh24e4c9775b01424p1a625fjsnf41e0d7c9961"
        });
    this.setState(() {
      cryptos = jsonDecode(response.body);
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData1();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:
          new AppBar(title: new Text("Cryptos"), backgroundColor: Colors.black),
      body: Column(
        children: [
          Expanded(
            child: new ListView.builder(
              // ignore: unnecessary_null_comparison
              itemCount: cryptos == null ? 0 : cryptos.length,
              itemBuilder: (BuildContext context, int index) {
                // ignore: unused_local_variable
                final MaterialColor color = _colors[index % _colors.length];

                return new ListTile(
                  tileColor: Colors.black,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => cryptodetailpage(
                          passedlist: cryptos,
                          passedindex: index,
                        ),
                        // Pass the arguments as part of the RouteSettings. The
                        // DetailScreen reads the arguments from these settings.
                        settings: RouteSettings(
                          arguments: cryptos[index],
                        ),
                      ),
                    );
                  },
                  leading: new CircleAvatar(
                    backgroundColor:
                        Color((Random().nextDouble() * 0xFFFFFF).toInt())
                            .withOpacity(1.0),
                    child: new Text(cryptos[index]['name'][0]),
                  ),
                  title: new Text(
                    cryptos[index]['name'],
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18),
                  ),
                  subtitle: _getSubtitleText(
                      cryptos[index]['quotes']['USD']['price'].toDouble(),
                      cryptos[index]['quotes']['USD']['percent_change_1h']
                          .toDouble()),
                  isThreeLine: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _getSubtitleText(double price, double precentageChange) {
  TextSpan priceTextWidget = new TextSpan(
      text: "\$$price     ",
      style: TextStyle(color: Colors.grey[400], fontSize: 15));
  String precentageChangeText = " $precentageChange%";
  TextSpan percentageChangeTextWidget;

  percentageChangeTextWidget = new TextSpan(
      text: precentageChangeText,
      style: new TextStyle(backgroundColor: Colors.green));
  if (precentageChange > 0) {
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
