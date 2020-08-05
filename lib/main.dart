import 'package:exam_snap/screens/selection.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

final List<String> branches = [
  'cse',
  'mechanical',
  'civil',
  'ecm',
  'it',
  'eee',
  'ece'
];
final List<List<Color>> colors = [
  [Color(0x66FFA69E), Color(0x77861657)],
  [Color(0x775F0A87), Color(0x774508B)],
  [Color(0x7720BF55), Color(0x7701BAEF)],
  [Color(0x77A40606), Color(0x77D98324)],
  [Color(0x77380036), Color(0x770CBABA)],
  [Color(0x77EC9F05), Color(0x77FF4E00)],
  [Color(0x779E768F), Color(0x77FFFFFF)],
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExamSNAP',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF000000), Color(0x0000FFFF)])),
        child: SafeArea(
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Choose Branch",
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                    itemCount: branches.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  Selection(branch: branches[index]),
                            ),
                          );
                        },
                        hoverColor: Colors.black,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          margin: EdgeInsets.all(8.0),
                          elevation: 5.0,
                          child: Container(
                            height: 150.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: colors[index])),
                            child: Center(
                                child: Text(
                              branches[index].toUpperCase(),
                              style: TextStyle(
                                  fontSize: 40.0, color: Colors.white),
                            )),
                            // child: Image.asset(
                            //     'assets/images/${branches[index]}.png'),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
