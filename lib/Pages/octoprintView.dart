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
        appBar: AppBar(
          title: const Text("Flutter WebView"),
        ),
        body: Container());
        // body: WebViewWidget(controller: webViewController));
  }
}
