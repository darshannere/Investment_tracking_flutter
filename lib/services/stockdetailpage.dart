import 'dart:convert';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project/home_page.dart';
import 'package:project/services/process.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

var chartdata;

class stockdetailpage extends StatefulWidget {
  final List passedlist;
  final int passedindex;
  const stockdetailpage(
      {Key? key, required this.passedlist, required this.passedindex})
      : super(key: key);

  @override
  _stockdetailpageState createState() => _stockdetailpageState();
}

class _stockdetailpageState extends State<stockdetailpage> {
  var stockdetail = {};
  Map stockdesc = {};
  var dec;
  var maxy;
  var miny;
  var stockchartlist;
  var stockchartdata;

  late String stockname;
  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  Future<String> getData2() async {
    var response = await http.get(
        Uri.parse(
            'https://yahoo-finance-low-latency.p.rapidapi.com/v8/finance/chart/$stockname?region=IN&events=div%2Csplit'),
        headers: {
          "X-RapidAPI-Key":
              "b5e366e646msh24e4c9775b01424p1a625fjsnf41e0d7c9961",
          "x-rapidapi-host": "yahoo-finance-low-latency.p.rapidapi.com"
        });
    this.setState(() {
      stockchartdata = jsonDecode(response.body);
      stockchartlist = stockchartdata["chart"]["result"][0]["indicators"]
          ["quote"][0]["close"];
      print(stockchartlist);
      if (stockchartlist != null && stockchartlist.isNotEmpty) {
        dynamic max = stockchartlist.first;
        for (int i = 0; i <= 30; i++) {
          if (stockchartlist[i] > max) {
            max = stockchartlist[i];
          }
        }
        maxy = max.toDouble() + (max.toDouble() * 0.005);
        print(maxy);
      }
      if (stockchartlist != null && stockchartlist.isNotEmpty) {
        dynamic min = stockchartlist.first;
        for (int i = 0; i <= 30; i++) {
          if (stockchartlist[i] < min) {
            min = stockchartlist[i];
          }
        }
        miny = min.toDouble() - (min.toDouble() * 0.01);
        print(miny);
      }

      //maxy = stockchartlist.reduce(max);
      //print(maxy);

      //print(stockdetail ["Time Series (Daily)"]);
    });

    return "Success!";
  }

  Future<String> getData1() async {
    var response = await http.get(
        Uri.parse(
            'https://yahoo-finance-low-latency.p.rapidapi.com/v11/finance/quoteSummary/$stockname?modules=defaultKeyStatistics%2CassetProfile%2Cprice%2CfinancialData'),
        headers: {
          "X-RapidAPI-Key":
              "26a2809002msh48a501964d878cap1f4e81jsnca7905f362b0",
          "x-rapidapi-host": "yahoo-finance-low-latency.p.rapidapi.com"
        });
    this.setState(() {
      stockdetail = jsonDecode(response.body);
      dec = stockdetail["quoteSummary"]["result"][0]["assetProfile"]
          ["longBusinessSummary"];

      //print(stockdetail ["Time Series (Daily)"]);
    });

    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    stockname = widget.passedlist[widget.passedindex]['symbol'] + '.NS';
    print(stockname);
    this.getData1();
    this.getData2();
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
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "  " + widget.passedlist[widget.passedindex]['symbol'],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "  ₹" +
                        widget.passedlist[widget.passedindex]["lastPrice"]
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
                            FlSpot(0, stockchartlist[0]),
                            FlSpot(1, stockchartlist[1]),
                            FlSpot(2, stockchartlist[2]),
                            FlSpot(3, stockchartlist[3]),
                            FlSpot(4, stockchartlist[4]),
                            FlSpot(5, stockchartlist[5]),
                            FlSpot(6, stockchartlist[6]),
                            FlSpot(7, stockchartlist[7]),
                            FlSpot(8, stockchartlist[8]),
                            FlSpot(9, stockchartlist[9]),
                            FlSpot(10, stockchartlist[10]),
                            FlSpot(11, stockchartlist[11]),
                            FlSpot(12, stockchartlist[12]),
                            FlSpot(13, stockchartlist[13]),
                            FlSpot(14, stockchartlist[14]),
                            FlSpot(15, stockchartlist[15]),
                            FlSpot(16, stockchartlist[16]),
                            FlSpot(17, stockchartlist[17]),
                            FlSpot(18, stockchartlist[18]),
                            FlSpot(19, stockchartlist[19]),
                            FlSpot(20, stockchartlist[20]),
                            FlSpot(21, stockchartlist[21]),
                            FlSpot(22, stockchartlist[22]),
                            FlSpot(23, stockchartlist[23]),
                            FlSpot(24, stockchartlist[24]),
                            FlSpot(25, stockchartlist[25]),
                            FlSpot(26, stockchartlist[26]),
                            FlSpot(27, stockchartlist[27]),
                            FlSpot(28, stockchartlist[28]),
                            FlSpot(29, stockchartlist[29]),
                            FlSpot(30, stockchartlist[30]),
                            FlSpot(31, stockchartlist[31]),
                            FlSpot(32, stockchartlist[32]),
                            FlSpot(33, stockchartlist[33]),
                            FlSpot(34, stockchartlist[34]),
                            FlSpot(35, stockchartlist[35]),
                            FlSpot(36, stockchartlist[36]),
                            FlSpot(37, stockchartlist[37]),
                            FlSpot(38, stockchartlist[38]),
                            FlSpot(39, stockchartlist[39]),
                            FlSpot(40, stockchartlist[40]),
                            FlSpot(41, stockchartlist[41]),
                            FlSpot(42, stockchartlist[42]),
                            FlSpot(43, stockchartlist[43]),
                            FlSpot(44, stockchartlist[44]),
                            FlSpot(45, stockchartlist[45]),
                            FlSpot(46, stockchartlist[46]),
                            FlSpot(47, stockchartlist[47]),
                            FlSpot(48, stockchartlist[48]),
                            FlSpot(49, stockchartlist[49]),
                            FlSpot(50, stockchartlist[50]),
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
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text("Open\n", style: TextStyle(color: Colors.grey[600])),
                  Text("Prev close\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("Day High\n", style: TextStyle(color: Colors.grey[600])),
                  Text("Day Low\n", style: TextStyle(color: Colors.grey[600])),
                  Text("52 WK High\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("52 WK Low\n",
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      widget.passedlist[widget.passedindex]['open'].toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['previousClose']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['dayHigh']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['dayLow']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['yearHigh']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['yearLow']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text("totalTradedVolume\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("totalTradedValue\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("perChange365d\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("perChange30d\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("52 WK High\n",
                      style: TextStyle(color: Colors.grey[600])),
                  Text("52 WK Low\n",
                      style: TextStyle(color: Colors.grey[600])),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                      widget.passedlist[widget.passedindex]['totalTradedVolume']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['totalTradedValue']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['perChange365d']
                              .toString() +
                          "%\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['perChange30d']
                              .toString() +
                          "%\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['yearHigh']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                  Text(
                      widget.passedlist[widget.passedindex]['yearLow']
                              .toString() +
                          "\n",
                      style: TextStyle(color: Colors.white)),
                ],
              )
            ],
          ),
          Column(
            children: [
              Text("About  Company",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
              ListTile(
                leading: Text("Industry:",
                    style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                trailing: Text(
                    stockdetail["quoteSummary"]["result"][0]["assetProfile"]
                        ["industry"],
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
              ListTile(
                leading: Text("Sector:",
                    style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                trailing: Text(
                    stockdetail["quoteSummary"]["result"][0]["assetProfile"]
                        ["sector"],
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
              ListTile(
                leading: Text(
                    stockdetail["quoteSummary"]["result"][0]["assetProfile"]
                            ["companyOfficers"][0]["title"]
                        .toString(),
                    style: TextStyle(color: Colors.grey[600], fontSize: 15)),
                trailing: Text(
                    stockdetail["quoteSummary"]["result"][0]["assetProfile"]
                            ["companyOfficers"][0]["name"]
                        .toString(),
                    style: TextStyle(color: Colors.white, fontSize: 15)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                child: Text("  $dec",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.grey[600], fontSize: 15)),
              )
            ],
          ),
        ],
      ),
    );
  }
}


// ignore: must_be_immutable
/*class LinechartWidget extends StatelessWidget {
  var passeddata;
  LinechartWidget({Key? key, required this.passeddata}) : super(key: key);

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a)
  ];

  @override
  Widget build(BuildContext context) =>
      LineChart(LineChartData(minX: 0, maxX: 99, lineBarsData: [
        LineChartBarData(spots: [
          FlSpot(chartdata[1], 10),
          FlSpot(10, 230),
        ])
      ]));
}

*/

