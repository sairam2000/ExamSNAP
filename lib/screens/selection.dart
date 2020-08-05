import 'package:exam_snap/screens/subjects.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Selection extends StatefulWidget {
  String branch;
  Selection({Key key, @required this.branch}) : super(key: key);
  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              stops: [0.0, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF000000), Color(0x0000FFFF)])),
      child: Scaffold(
        backgroundColor: Color(0x00000000),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        widget.branch.toUpperCase(),
                        style: TextStyle(fontSize: 30.0, color: Colors.white),
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black38,
                    thickness: 1.0,
                  ),
                  BuildExpansionWidget(
                    year: "First Year",
                    branch: widget.branch,
                    year_int: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.black38,
                      thickness: 1.0,
                    ),
                  ),
                  BuildExpansionWidget(
                    year: "Second Year",
                    branch: widget.branch,
                    year_int: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.black38,
                      thickness: 1.0,
                    ),
                  ),
                  BuildExpansionWidget(
                    year: "Third Year",
                    branch: widget.branch,
                    year_int: 3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.black38,
                      thickness: 1.0,
                    ),
                  ),
                  BuildExpansionWidget(
                    year: "Fourth Year",
                    branch: widget.branch,
                    year_int: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      color: Colors.black38,
                      thickness: 1.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BuildExpansionWidget extends StatelessWidget {
  String year;
  // ignore: non_constant_identifier_names
  int year_int;
  String branch;
  BuildExpansionWidget(
      {@required this.year,
      @required this.branch,
      // ignore: non_constant_identifier_names
      @required this.year_int,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(
      borderRadius: 30,
      // background: Image.asset(
      //   "assets/images/planet-1.gif",
      //   fit: BoxFit.cover,
      // ),
      title: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                year,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 7),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Subjects(
                          branch: branch, year: year_int, sem: 'semister-1'),
                    ),
                  );
                },
                title: Center(
                    child: Text(
                  "SEM : 1",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Subjects(
                          branch: branch, year: year_int, sem: 'semister-2'),
                    ),
                  );
                },
                title: Center(
                    child: Text(
                  "SEM : 2",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
