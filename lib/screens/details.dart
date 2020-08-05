import 'package:exam_snap/screens/pdfview.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  Map<String, dynamic> snap;
  String subject;
  Details({Key key, @required this.snap, @required this.subject})
      : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}

var _sortedKeys;

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
    _sortedKeys = widget.snap.keys.toList()..sort();
    //getlink();
  }

  final List<List<Color>> colors = [
    [Color(0x66FFA69E), Color(0x77861657)],
    [Color(0x775F0A87), Color(0x774508B)],
    [Color(0x7720BF55), Color(0x7701BAEF)],
    [Color(0x77A40606), Color(0x77D98324)],
    [Color(0x77380036), Color(0x770CBABA)],
    [Color(0x77EC9F05), Color(0x77FF4E00)],
    [Color(0x779E768F), Color(0x77FFFFFF)],
  ];
  // ignore: non_constant_identifier_names
  int color_value = 0;
  
  Future getlink() async {
    final StorageReference ref =
        FirebaseStorage().ref().child('cse').child('se(u-1p-1).pdf');
    final String url = await ref.getDownloadURL();
    print(url);
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
        appBar: AppBar(
          title: Text(widget.subject),
          backgroundColor: Color(0xFF002222),
        ),
        backgroundColor: Colors.transparent,
        body: ListView.builder(
          itemCount: _sortedKeys.length,
          itemBuilder: (context, index) {
            String key = _sortedKeys[index];

            if (widget.snap[key][0] == null) {
              return SizedBox();
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        key,
                        style: TextStyle(fontSize: 40.0, color: Colors.white),
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.snap[key].length,
                      itemBuilder: (context, value) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Pdfview(
                                    url: widget.snap[key][value]['url'],
                                    location:widget.snap[key][value]['location']),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            margin: EdgeInsets.all(8.0),
                            elevation: 5.0,
                            child: Container(
                              // height: 50.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: colors[
                                          color_value++ % colors.length])),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(widget.snap[key][value]['topic'],
                                      style: TextStyle(
                                          fontSize: 20.0, color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

//  Future getlink() async {
//     final StorageReference ref =
//         FirebaseStorage().ref().child('cse').child('os(u-1).pdf');
//     final String url = await ref.getDownloadURL();
//     print(url);
//   }
