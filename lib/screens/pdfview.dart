import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

// ignore: must_be_immutable
class Pdfview extends StatefulWidget {
  String url;
  Pdfview({Key key, @required this.url}) : super(key: key);
  @override
  _PdfviewState createState() => _PdfviewState();
}

class _PdfviewState extends State<Pdfview> {
  Future getdata() async {
    var response = await http.get(widget.url);
    var dir = await getTemporaryDirectory();
    File file = File(dir.path + 'data.pdf');
    await file.writeAsBytes(response.bodyBytes, flush: true);
    return (file.path);
  }

  String _localfile;
  @override
  void initState() {
    super.initState();
    getdata().then((value) {
      setState(() {
        _localfile = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('PDF')),
      body: _localfile == null
          ? Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: _localfile,
              autoSpacing: false,
              pageSnap: false,
            ),
    );
  }
}
