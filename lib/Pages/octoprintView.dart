import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text("Flutter WebView"),
      ),
      // body: Container());
      body: Column(
        children: [
          Container(
            height:700,
            width: double.infinity,
            child: WebViewWidget(controller: webViewController)
          ,),
          Container(height: 50,),
          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, '/feedback');
          },
           child: Text('FeedBack'  ,
            style: TextStyle(color: Colors.black),)
          )
      ],)
      ,
    );
  }
}
