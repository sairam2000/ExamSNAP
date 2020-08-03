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
  'chemical'
];
final List<Color> colors = <Color>[
  Color(0x55FFA07A),
  Color(0x55FFA500),
  Color(0x55EEE8AA),
  Color(0x55FFC0CB),
  Color(0x77FFFFE0),
  Color(0x77F5F5F5),
  Color(0x77E6E6FA)
];

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ExamSNAP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
      appBar: AppBar(
        title: Text(
          "ExamSNAP",
          style: TextStyle(
            height: 1.4,
            letterSpacing: 1.5,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: branches.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Selection(branch: branches[index]),
                  ),
                );
              },
              hoverColor: Colors.black,
              child: Card(
                elevation: 4.0,
                shadowColor: colors[index],
                color: colors[index],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Image.asset('assets/images/${branches[index]}.png'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
