import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
        .then((DocumentSnapshot ds) {
      // print(ds.data['semister-2'].keys.elementAt(0));
      if (ds.data.length == 0) {
        setState(() {
          _valid = false;
        });
      } else {
        List sub = [];
        try {
          for (var val in ds.data[widget.sem].keys) {
            sub.add(val);
          }
          setState(() {
            _sub = sub;
          });
        } catch (e) {
          setState(() {
            _valid = false;
          });
        }
      }
    });
  }

  Future getlink() async {
    final StorageReference ref =
        FirebaseStorage().ref().child('pdf').child('ADS(qb).pdf');
    final String url = await ref.getDownloadURL();
    var response = await http.get(url);
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + 'data.pdf');
    await file.writeAsBytes(response.bodyBytes, flush: true);
    return (file.path);
  }

  bool _valid;
  String _localfile;
  @override
  void initState() {
    _sub = [];
    _valid = true;
    super.initState();
    getposts();
    print(widget.branch);
    print(widget.sem);
    print(widget.year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.branch.toUpperCase()),
      ),
      body: _valid == false
          ? Center(
              child: Text('No data Found'),
            )
          : _sub.length == 0
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  child: ListView.builder(
                    itemCount: _sub.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_sub[index]),
                      );
                    },
                  ),
                ),
    );
  }
}

// getlink().then((value) {
//   setState(() {
//     _localfile = value;
//   });
// });

//     _localfile == null
//     ? Center(child: CircularProgressIndicator())
//     : PDFView(
//         filePath: _localfile,
//         autoSpacing: false,
//         pageSnap: false,
//         nightMode: true,
//       )

// Container(
//     child: FutureBuilder(
//   future: getposts(),
//   builder: (context, AsyncSnapshot snapshot) {
//     if (snapshot.connectionState != ConnectionState.done) {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     } else {
//       if (snapshot.hasData) {
//         return ListView.builder(
//             itemCount: snapshot.data['semister-2'].length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title:
//                     snapshot.data['semister-2'].keys.elementAt(index),
//               );
//             });
//       } else {
//         return Center(
//           child: Text("error"),
//         );
//       }
//     }
//   },
// ))
