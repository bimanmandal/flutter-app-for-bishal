import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFileData('assets/info.md'),
      initialData: "",
      builder:  (context, snapshot) => MarkdownBody(data: snapshot.data,),
    );
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

}
