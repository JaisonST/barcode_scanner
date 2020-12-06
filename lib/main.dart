import 'package:flutter/material.dart';
import 'package:scan_preview/scan_preview_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _result = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan barcode example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('start scan'),
              onPressed: () async {
                if (await Permission.camera.isGranted) {
                  final result = await Navigator.push(this.context,
                      MaterialPageRoute(builder: (context) => ScanPreviewPage()));
                  setState(() {
                    _result = result;
                  });
                } else {
                  await Permission.camera.request().then((value) {
                    Navigator.push(this.context,
                        MaterialPageRoute(builder: (context) => ScanPreviewPage())).then((value){
                          setState(() {
                            _result = value;
                          });
                    });

                  });
                }


              },
            ),
            Text('scan result: $_result')
          ],
        ),
      ),
    );
  }
}

class ScanPreviewPage extends StatefulWidget {
  @override
  _ScanPreviewPageState createState() => _ScanPreviewPageState();
}

class _ScanPreviewPageState extends State<ScanPreviewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan barcode example'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: SizedBox(
              child: ScanPreviewWidget(
                onScanResult: (result) {
                  debugPrint('scan result: $result');
                  Navigator.pop(context, result);
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.pinkAccent,
              child: MaterialButton(
                onPressed: () {
                  String result = "NoID";
                  Navigator.pop(context, result);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
