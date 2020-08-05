import 'package:exam_snap/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Subjects extends StatefulWidget {
  final String branch;
  final String sem;
  final int year;

  Subjects(
      {Key key, @required this.branch, @required this.sem, @required this.year})
      : super(key: key);
  @override
  _SubjectsState createState() => _SubjectsState();
}

class _SubjectsState extends State<Subjects> {
  DocumentSnapshot snap;
  List _sub = [];
  Future getposts() async {
    var firestore = Firestore.instance;
    firestore
        .collection(widget.branch)
        .document(widget.year.toString())
        .get()
        .then(
      (DocumentSnapshot ds) {
        //  print(ds.data['semister-2'].keys.elementAt(0));
        setState(
          () {
            snap = ds;
          },
        );
        if (ds.data.length == 0) {
          setState(
            () {
              _valid = false;
            },
          );
        } else {
          List sub = [];
          try {
            for (var val in ds.data[widget.sem].keys) {
              sub.add(val);
            }
            setState(
              () {
                _sub = sub;
              },
            );
          } catch (e) {
            setState(
              () {
                _valid = false;
              },
            );
          }
        }
      },
    );
  }

  bool _valid;
  @override
  void initState() {
    _sub = [];
    _valid = true;
    super.initState();
    getposts();
  }

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
        backgroundColor: Colors.transparent,
        // appBar: AppBar(
        //   title: Text(widget.branch.toUpperCase()),
        // ),
        body: _valid == false
            ? Center(
                child: Text('No data Found',
                    style: TextStyle(color: Colors.white)),
              )
            : _sub.length == 0
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: SafeArea(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Select Subject",
                                style: TextStyle(
                                    fontSize: 30.0, color: Colors.white),
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          Flexible(
                            child: ListView.builder(
                              itemCount: _sub.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Details(
                                                      subject: _sub[index],
                                                      snap: snap
                                                              .data[widget.sem][
                                                          snap.data[widget.sem]
                                                              .keys
                                                              .elementAt(
                                                                  index)],
                                                    )));
                                      },
                                      title: Text(
                                        _sub[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Divider(
                                        height: 10.0,
                                        thickness: 1.0,
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
