import 'dart:io';

import 'package:Bishal/common/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewFormulaWidget extends StatefulWidget {
  final String url;
  const WebViewFormulaWidget({Key key, this.url}) : super(key: key);

  @override
  _WebViewFormulaWidgetState createState() => _WebViewFormulaWidgetState();
}

class _WebViewFormulaWidgetState extends State<WebViewFormulaWidget> {
  num position = 1 ;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BishalAppBar(),
      body: IndexedStack(
        index: position,
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (value){
              setState(() {
                position = 1;
              });
            },
            onPageFinished: (finish) {
              print("Print finished");
              setState(() {
                position = 0;
              });
            },
          ),
          Center(child: CircularProgressIndicator(),)
        ],
      ),
    );
  }

}


