import 'package:exam_snap/screens/subjects.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';

class Selection extends StatefulWidget {
  String branch;
  Selection({Key key, @required this.branch}) : super(key: key);
  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.branch.toUpperCase()),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
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
    );
  }
}

class BuildExpansionWidget extends StatelessWidget {
  String year;
  int year_int;
  String branch;
  BuildExpansionWidget(
      {@required this.year,
      @required this.branch,
      @required this.year_int,
      Key key})
      : super(key: key);
  // const BuildExpansionWidget({
  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionCard(
      borderRadius: 20,
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
                  fontSize: 30,
                  color: Colors.black,
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
                    color: Colors.black,
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
                    color: Colors.black,
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
