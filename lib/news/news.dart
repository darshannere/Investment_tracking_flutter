import 'package:flutter/material.dart';
import 'package:project/news/models/article_model.dart';
import 'package:project/news/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class news extends StatefulWidget {
  const news({Key? key}) : super(key: key);

  @override
  _newsState createState() => _newsState();
}

// ignore: camel_case_types
class _newsState extends State<news> {
  late var newsres = {};

  Future<String> getnewsData() async {
    var response = await http.get(
      Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=b8d2fea63f7e4116a213da91af582f41'),
    );
    this.setState(() {
      print(response.body);
      newsres = jsonDecode(response.body);
    });

    return "Success!";
  }

  _launchURLBrowser(urllink) async {
    dynamic url = urllink;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    this.getnewsData();
    print(newsres["status"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Business News",
              style: TextStyle(
                color: Colors.white,
              )),
          backgroundColor: Colors.black,
          toolbarHeight: 40,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: newsres["totalResults"],
                      itemBuilder: (BuildContext context, int index) {
                        return new Container(
                          margin: EdgeInsets.all(12.0),
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 3.0,
                                ),
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              newsres["articles"][index]["urlToImage"] != null
                                  ? Container(
                                      height: 200.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                newsres["articles"][index]
                                                    ["urlToImage"]),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    )
                                  : Container(
                                      height: 200.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://images.unsplash.com/photo-1579407364450-481fe19dbfaa?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c3RvY2tzfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60'),
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                    ),
                              SizedBox(height: 8.0),
                              Container(
                                padding: EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Text(
                                  newsres["articles"][index]["source"]["name"],
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8.0),
                              TextButton(
                                onPressed: () {
                                  _launchURLBrowser(
                                      newsres["articles"][index]["url"]);
                                },
                                child: Text(
                                  newsres["articles"][index]["title"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      })),
            ],
          ),
        )
        // Column(
        //   children: [
        //     Text(newsres["status"].toString()),
        //     Text(newsres["articles"][0]["title"])
        //   ],
        // ),
        // body: FutureBuilder(
        //   future: client.getArticle(),
        //   builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
        //     if (snapshot.hasData) {
        //       List<Article>? articles = snapshot.data;
        //       return ListView.builder(
        //         itemBuilder: (context, index) => ListTile(
        //           title: Text(articles![index].title),
        //         ),
        //         itemCount: articles!.length,
        //       );
        //     }
        //     return Center(
        //       child: CircularProgressIndicator(),
        //     );
        //   },
        // ),
        );
  }
}
