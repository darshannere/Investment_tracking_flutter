import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: camel_case_types
class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  _aboutState createState() => _aboutState();
}

// ignore: camel_case_types
class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("About the application"),
      ),
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Image.asset('assets/icon/icon.png'),
            ),
            SizedBox(
              height: 80,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text(
                'It reduces money handling problems easily.It makes it more feasible to every class of the people and make it customer friendly.It also has many features like investment reminder means it will remind a person when his investment are getting mature and inform us for taking action on iThis makes investment planning possible because many people pay extra cash for handling their finances but this will take a small step to make it on customer fingertips.',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600]),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
