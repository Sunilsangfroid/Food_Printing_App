import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:itrm_screen/foodclass.dart';
import 'package:itrm_screen/globals.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ConnectToPrinterScreen extends StatelessWidget {
  final String octoPrintUrl = 'http://octo.local';

  const ConnectToPrinterScreen({super.key});

  void _launchOctoPrintURL() async {
    print(124);
    try {
      await launch(octoPrintUrl);
    } catch (e) {
      print("Unable to open The URL");
    }
  }
  void fetcher(int fid) async {
      if (availFood[fid]!.gcodePath==null||availFood[fid]!.gcodePath==""){
        print('Error: Unable to download file from the provided URL');
        return;
      }
      var ref = FirebaseStorage.instance.ref().child('gcodes/${availFood[fid]!.gcodePath}');
      String fileUrl = await (ref.getDownloadURL());
      final response = await http.get(Uri.parse(fileUrl));
      print(response.statusCode);
      // print(response.bodyBytes);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/${availFood[fid]!.gcodePath}');
      await file.writeAsBytes(response.bodyBytes);
      // return tempFile;
      // final file = File('temp_file.gcode'); // Create a temporary file
      // await file.writeAsBytes(response.bodyBytes);
      if (file == null) {
        print('Error: Unable to download file from the provided URL');
        return;
      }
      // // var url = Uri.parse('$octoPrintUrl/api/files/local');
      // final url = Uri.parse('http://octo.local/api/files/local'); // Update with the correct API endpoint
      print(9876);
      final request = http.MultipartRequest('POST', Uri.parse('http://192.168.79.45/api/files/local'));
      request.headers['X-Api-Key'] = 'B6FA89611CF149A3B08E4E7A6E6DDC72';
      
      // Add the file to the request
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        file.readAsBytesSync(),
        filename: file.path.split('/').last,
        // contentType: 
        // contentType: MediaType('application', 'octet-stream')
      ));
      print(123);
      try {
        print(12);
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      } catch (e) {
        print('Error uploading file to OctoPrint: $e');
      }
    
      // var response = await http.get(Uri.parse(fileUrl));
      // print(response);
      // var fileBytes = response.bodyBytes;
      // final file = File('whistle_v2.gcode');
      // await file.writeAsBytes(response.bodyBytes);

      // // final file=http.MultipartFile.fromBytes('file', fileBytes);
      // // final file = await downloadFile(fileUrl); // Download the file from the provided URL
      // if (file == null) {
      //   print('Error: Unable to download file from the provided URL');
      //   return;
      // }
      
      // final request = http.MultipartRequest('POST', url);
      // request.headers['X-Api-Key'] = 'B6FA89611CF149A3B08E4E7A6E6DDC72';
      // request.headers['Content-Type'] = 'multipart/form-data';
      // // Add the file to the request
      // request.files.add(http.MultipartFile.fromBytes(
      //   'file',
      //   file.readAsBytesSync(),
      //   filename: 'whistle_v2.gcode', // Update with the desired filename
      //   // contentType: MediaType('application', 'octet-stream')
      // ));

      // // Add additional form fields if needed
      // request.fields['select'] = 'true';
      // request.fields['print'] = 'true';
      // print(123);
      // try {
      //   final streamedResponse = await request.send();
      //   final response = await http.Response.fromStream(streamedResponse);
      //   print('Response status: ${response.statusCode}');
      //   print('Response body: ${response.body}');
      // } catch (e) {
      //   print('Error uploading file to OctoPrint: $e');
      // }
      // // final String octoPrintUrll = 'http://octo.local/api/files/sdcard';
      // // var request = http.MultipartRequest('POST', Uri.parse(octoPrintUrll));
      // // request.headers['X-Api-Key'] = 'B6FA89611CF149A3B08E4E7A6E6DDC72';
      // // request.headers['Content-Type'] = 'multipart/form-data';
      // // // Add the file to the request
      // // // var file = await http.MultipartFile.fromPath('file', Furl);
      // //  try {
      // //   var response = await http.get(Uri.parse(Furl));
      // //   var fileBytes = response.bodyBytes;
      // //   request.files.add(http.MultipartFile.fromBytes('file', fileBytes));
      // //   var streamedResponse = await request.send();
      // //   var responsee = await http.Response.fromStream(streamedResponse);
      // //   print('Response status: ${responsee.statusCode}');
      // //   print('Response body: ${responsee.body}');
      // //   // print(fileBytes);
      // //   print(1);
      // // } catch (e) {
      // //   print(2);
      // //   print('Error downloading file from Firebase Storage: $e');
      // //   return;
      // // }
      
  }

  Future<void> downloadGCodeFile() async {
    firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
    firebase_storage.Reference ref = storage.ref('gs://foodprinter-1aa35.appspot.com/files/gcodes');
    File downloadToFile = File('$docPath/pfp.gcode');
    print(downloadToFile);
    print(1324364);
    try {
      await ref.writeToFile(downloadToFile);
      print('Downloaded G-code file to ${downloadToFile.path}');
    } catch (e) {
      print('Error downloading G-code file: $e');
    }
  }

  void getAllFiles() async {
    var url = Uri.parse('$octoPrintUrl/api/files');
    var response = await http.get(url, headers: {'X-Api-Key': 'B6FA89611CF149A3B08E4E7A6E6DDC72'});
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
          onPressed: () {
            // getAllFiles();
            // downloadGCodeFile();
            // for (var fid in cart.keys){
            //   fetcher(fid);
            // }
            Navigator.pushNamed(context, '/opwebview');
          },
          child: Text(
            'Connect to OctoPrint',
            style: TextStyle(color: Colors.black),
          ),
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
