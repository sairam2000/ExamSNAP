import 'package:flutter/material.dart';
class Years extends StatefulWidget {
  final String title;
  Years({Key key, @required this.title}): super(key:key);
  @override
  _YearsState createState() => _YearsState();
}

class _YearsState extends State<Years> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title.toUpperCase()),
      ),
      );
  }
}






https://github.com/sairam2000/ExamSNAP.git