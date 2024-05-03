// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OctoWebView extends StatefulWidget {
  const OctoWebView({super.key});

  @override
  State<OctoWebView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OctoWebView> {
  final webViewController = WebViewController()
    ..loadRequest(Uri.parse('http://octo.local/?temp'))
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  Widget build(BuildContext context) {
    // return WebViewWidget(controller: webViewController);
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 10.0),
        child: BackButton(
          color: Colors.black,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                "OctoPrint",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20), // Added space below the centered text
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  SizedBox(
                    height: 640,
                    width: double.infinity,
                    child: WebViewWidget(controller: webViewController),
                  ),
                  Container(
                    height: 20,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/feedback');
                        },
                        child: const Text(
                          'FeedBack',
                          style: TextStyle(color: Colors.black),
                        )),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
