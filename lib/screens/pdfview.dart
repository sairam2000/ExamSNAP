// import 'dart:html';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class Pdfview extends StatefulWidget {
  String location;
  String url;
  Pdfview({Key key, @required this.url, @required this.location})
      : super(key: key);
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

  bool _isdownloadDirectory = true;
  Directory _downloadsDirectory;
  Future<void> initDownloadsDirectoryState() async {
    Directory downloadsDirectory;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      downloadsDirectory = await DownloadsPathProvider.downloadsDirectory;
    } on PlatformException {
      Toast.show('Could not get the downloads directory', context);
      _isdownloadDirectory = false;
    }
    if (!mounted) return;

    setState(() {
      _downloadsDirectory = downloadsDirectory;
    });
  }

  Map<PermissionGroup, PermissionStatus> permissions;
  void getPermission() async {
    permissions = await PermissionHandler().requestPermissions([
      PermissionGroup.storage,
    ]);
  }

  Future download(String path) async {
    print(permissions);
    print(_downloadsDirectory);
    int index = widget.location.indexOf('/');
    String filename = widget.location.substring(index, widget.location.length);
    File file = File(_downloadsDirectory.path + filename);
    File tmpfile = File(path);
    await tmpfile.copy(file.path);
    Toast.show('Downloaded to Downloads folder as $filename', context, duration: Toast.LENGTH_LONG);
  }

  String _localfile;
  @override
  void initState() {
    super.initState();
    getPermission();
    initDownloadsDirectoryState();
    getdata().then((value) {
      setState(() {
        _localfile = value;
      });
    });
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
        appBar: AppBar(
          title: Text('Preview'),
          backgroundColor: Color(0xFF002222),
        ),
        floatingActionButton: _localfile != null
            ? FloatingActionButton(
                backgroundColor: Color(0xFF002222),
                child: Icon(Icons.file_download),
                onPressed: () {
                  if (_isdownloadDirectory &&
                      permissions[PermissionGroup.storage] !=
                          PermissionStatus.denied) {
                    download(_localfile);
                  } else {
                    Toast.show('allow access to storage', context,duration: Toast.LENGTH_LONG);
                  }
                })
            : null,
        body: _localfile == null
            ? Center(child: CircularProgressIndicator())
            : PDFView(
                filePath: _localfile,
                autoSpacing: false,
                pageSnap: false,
              ),
      ),
    );
  }
}
