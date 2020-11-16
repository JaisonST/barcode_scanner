import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String code = "Not scanned yet";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scan APP'),
        ),
        body: Center(
          child: Text(code),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            scanner.scan().then((value) {
              setState(() {
                code = value;
              });
            });
          },
          child: Icon(Icons.scanner),
        ),
      ),
    );
  }
}
