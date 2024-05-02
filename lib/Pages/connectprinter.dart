// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ConnectToPrinterScreen extends StatelessWidget {
  final String octoPrintUrl = 'octo.local';

  const ConnectToPrinterScreen({super.key});

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
  void getAllFiles() async{
    var url=Uri.http(octoPrintUrl,'api/files');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
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
          // onPressed: _launchOctoPrintURL,
          onPressed: getAllFiles,
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
