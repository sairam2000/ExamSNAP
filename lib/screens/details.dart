import 'package:exam_snap/screens/pdfview.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  Map<String, dynamic> snap;
  Details({Key key, @required this.snap}) : super(key: key);
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: ListView.builder(
        itemCount: widget.snap.length,
        itemBuilder: (context, index) {
          String key = widget.snap.keys.elementAt(index);

          if (widget.snap[key][0] == null) {
            return SizedBox();
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    key,
                    style: TextStyle(
                        fontSize: 50.0, decoration: TextDecoration.underline),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.snap[key].length,
                    itemBuilder: (context, value) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Pdfview(
                                      url: widget.snap[key][value]['url'])));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(widget.snap[key][value]['topic'],
                                style: TextStyle(
                                  fontSize: 30.0,
                                )),
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
    );
  }
}


//  Future getlink() async {
//     final StorageReference ref =
//         FirebaseStorage().ref().child('cse').child('os(u-1).pdf');
//     final String url = await ref.getDownloadURL();
//     print(url);
//     var response = await http.get(url);
//     var dir = await getTemporaryDirectory();
//     File file = File(dir.path + 'data.pdf');
//     await file.writeAsBytes(response.bodyBytes, flush: true);
//     return (file.path);
//   }