import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewFormulaWidget extends StatefulWidget {
  final String url;
  const WebViewFormulaWidget({Key key, this.url}) : super(key: key);

  @override
  _WebViewFormulaWidgetState createState() => _WebViewFormulaWidgetState();
}

class _WebViewFormulaWidgetState extends State<WebViewFormulaWidget> {


  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      // initialUrl: 'http://192.168.0.106:9090',
    );
  }

}
