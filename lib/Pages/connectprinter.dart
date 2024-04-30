// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectToPrinterScreen extends StatelessWidget {
  final String octoPrintUrl = 'http://octo.local';

  void _launchOctoPrintURL()  async{
    print(124);
    // if (await canLaunch(octoPrintUrl)) {
      try {
        await launch(octoPrintUrl);
      } catch (e) {
        print("Unable to open The URL");
      }
    // } else {
      // throw 'Could not launch OctoPrint URL';
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Connect to Printer'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _launchOctoPrintURL,
          child: Text('Connect to OctoPrint',style: TextStyle(color: Colors.black),),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ConnectToPrinterScreen(),
  ));
}
