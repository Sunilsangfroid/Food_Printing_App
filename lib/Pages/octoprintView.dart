// ignore_for_file: file_names, unused_import

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OctoWebView extends StatefulWidget {
  const OctoWebView({super.key});

  @override
  State<OctoWebView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<OctoWebView> {
  //  final webViewController = WebViewController()
  //   ..loadRequest(Uri.parse('https://www.youtube.com/'));

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
            Container(height: 30),
            const Center(
              child: Text(
                "Flutter WebView",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 20), // Added space below the centered text
            Expanded(child: Container())
          ],
        ),
      ),
    );
    // body: WebViewWidget(controller: webViewController));
  }
}
