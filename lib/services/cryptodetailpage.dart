import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class cryptodetailpage extends StatefulWidget {
  final List passedlist;
  final int passedindex;
  const cryptodetailpage(
      {Key? key, required this.passedlist, required this.passedindex})
      : super(key: key);

  @override
  _cryptodetailpageState createState() => _cryptodetailpageState();
}

class _cryptodetailpageState extends State<cryptodetailpage> {
  var cryptores;
  var cryptodata;
  var cryptochartlist;
  var maxy;
  var miny;
  late String cryptoname;
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  Future<String> getcryptodata() async {
    var response = await http.get(
        Uri.parse(
            'https://coingecko.p.rapidapi.com/coins/$cryptoname?localization=true&tickers=true&market_data=true&community_data=true&developer_data=true&sparkline=false'),
        headers: {
          "X-RapidAPI-Key":
              "b5e366e646msh24e4c9775b01424p1a625fjsnf41e0d7c9961",
          "x-rapidapi-host": "coingecko.p.rapidapi.com"
        });
    this.setState(() {
      cryptodata = jsonDecode(response.body);
      print(cryptodata);
    }

        //print(stockdetail ["Time Series (Daily)"]);
        );

    return "Success!";
  }

  Future<String> getcryptochartdata() async {
    var response = await http.get(
        Uri.parse(
            'https://coingecko.p.rapidapi.com/coins/$cryptoname/market_chart?vs_currency=usd&days=10'),
        headers: {
          "X-RapidAPI-Key":
              "26a2809002msh48a501964d878cap1f4e81jsnca7905f362b0",
          "x-rapidapi-host": "coingecko.p.rapidapi.com"
        });
    this.setState(() {
      cryptores = jsonDecode(response.body);
      cryptochartlist = cryptores["prices"];

      if (cryptochartlist != null && cryptochartlist.isNotEmpty) {
        dynamic max = cryptochartlist.first[1];
        for (int i = 0; i <= 30; i++) {
          if (cryptochartlist[i][1] > max) {
            max = cryptochartlist[i][1];
          }
        }
        maxy = max.toDouble() + (max.toDouble() * 0.005);
        print(maxy);
      }
      if (cryptochartlist != null && cryptochartlist.isNotEmpty) {
        dynamic min = cryptochartlist.first[1];
        for (int i = 0; i <= 30; i++) {
          if (cryptochartlist[i][1] < min) {
            min = cryptochartlist[i][1];
          }
        }
        miny = min.toDouble() - (min.toDouble() * 0.01);
        print(miny);
      }

      //print(stockdetail ["Time Series (Daily)"]);
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    cryptoname = widget.passedlist[widget.passedindex]["name"].toLowerCase();
    print(cryptoname);
    this.getcryptochartdata();
    this.getcryptodata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.passedlist[widget.passedindex]['symbol']),
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: ListView(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(cryptodata["image"]["small"]),
                          backgroundColor: Colors.transparent,
                          radius: 20,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "  " + widget.passedlist[widget.passedindex]['name'],
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "  \$" +
                          widget.passedlist[widget.passedindex]['quotes']['USD']
                                  ['price']
                              .toString(),
                      style: TextStyle(color: Colors.grey[600], fontSize: 25),
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 60,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 40, 10),
                child: Container(
                  child: LineChart(LineChartData(
                      maxX: 50,
                      maxY: maxy,
                      minX: 0,
                      minY: miny,
                      gridData:
                          FlGridData(show: false, drawHorizontalLine: false),
                      lineBarsData: [
                        LineChartBarData(
                            spots: [
                              FlSpot(0, cryptochartlist[0][1]),
                              FlSpot(1, cryptochartlist[1][1]),
                              FlSpot(2, cryptochartlist[2][1]),
                              FlSpot(3, cryptochartlist[3][1]),
                              FlSpot(4, cryptochartlist[4][1]),
                              FlSpot(5, cryptochartlist[5][1]),
                              FlSpot(6, cryptochartlist[6][1]),
                              FlSpot(7, cryptochartlist[7][1]),
                              FlSpot(8, cryptochartlist[8][1]),
                              FlSpot(9, cryptochartlist[9][1]),
                              FlSpot(10, cryptochartlist[10][1]),
                              FlSpot(11, cryptochartlist[11][1]),
                              FlSpot(12, cryptochartlist[12][1]),
                              FlSpot(13, cryptochartlist[13][1]),
                              FlSpot(14, cryptochartlist[14][1]),
                              FlSpot(15, cryptochartlist[15][1]),
                              FlSpot(16, cryptochartlist[16][1]),
                              FlSpot(17, cryptochartlist[17][1]),
                              FlSpot(18, cryptochartlist[18][1]),
                              FlSpot(19, cryptochartlist[19][1]),
                              FlSpot(20, cryptochartlist[20][1]),
                              FlSpot(21, cryptochartlist[21][1]),
                              FlSpot(22, cryptochartlist[22][1]),
                              FlSpot(23, cryptochartlist[23][1]),
                              FlSpot(24, cryptochartlist[24][1]),
                              FlSpot(25, cryptochartlist[25][1]),
                              FlSpot(26, cryptochartlist[26][1]),
                              FlSpot(27, cryptochartlist[27][1]),
                              FlSpot(28, cryptochartlist[28][1]),
                              FlSpot(29, cryptochartlist[29][1]),
                              FlSpot(30, cryptochartlist[30][1]),
                              FlSpot(31, cryptochartlist[31][1]),
                              FlSpot(32, cryptochartlist[32][1]),
                              FlSpot(33, cryptochartlist[33][1]),
                              FlSpot(34, cryptochartlist[34][1]),
                              FlSpot(35, cryptochartlist[35][1]),
                              FlSpot(36, cryptochartlist[36][1]),
                              FlSpot(37, cryptochartlist[37][1]),
                              FlSpot(38, cryptochartlist[38][1]),
                              FlSpot(39, cryptochartlist[39][1]),
                              FlSpot(40, cryptochartlist[40][1]),
                              FlSpot(41, cryptochartlist[41][1]),
                              FlSpot(42, cryptochartlist[42][1]),
                              FlSpot(43, cryptochartlist[43][1]),
                              FlSpot(44, cryptochartlist[44][1]),
                              FlSpot(45, cryptochartlist[45][1]),
                              FlSpot(46, cryptochartlist[46][1]),
                              FlSpot(47, cryptochartlist[47][1]),
                              FlSpot(48, cryptochartlist[48][1]),
                              FlSpot(49, cryptochartlist[49][1]),
                              FlSpot(50, cryptochartlist[50][1]),
                            ],
                            isCurved: true,
                            colors: gradientColors,
                            barWidth: 3,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(
                                colors: gradientColors
                                    .map((color) => color.withOpacity(0.3))
                                    .toList()))
                      ])),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Summary",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            Row(children: [
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text("Price\n", style: TextStyle(color: Colors.grey[600])),
                  Text("volume_24h\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("market_cap\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("circulating_supply\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("total_supply\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("first_data_at\n",
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      widget.passedlist[widget.passedindex]['quotes']['USD']
                                  ['price']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['quotes']['USD']
                                  ['volume_24h']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['quotes']['USD']
                                  ['market_cap']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]
                                  ['circulating_supply']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['total_supply']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['first_data_at']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                ],
              )
            ]),
          ],
        ));
  }
}
