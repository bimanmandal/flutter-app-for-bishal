import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:line_icons/line_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  final String _phoneNumber = "+918910047668";
  final String _message = "Hi";
  final String _fbName = "vishalsubhneel";

  @override
  Widget build(BuildContext context) {
    final String _phoneUrl = "tel:$_phoneNumber";
    final String _whatsAppUrl = "whatsapp://send?phone=$_phoneNumber&text=${Uri.parse(_message)}";
    final String _faceBookUrl = "fb.me/$_fbName";
    final String _messengerUrl = "m.me/$_fbName";
    final String _messageUrl = "sms:$_phoneNumber";

    return FutureBuilder(
      future: getFileData('assets/info.md'),
      initialData: "",
      builder:  (context, snapshot) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            MarkdownBody(data: snapshot.data,),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                        onPressed:() =>  _launchUrl(_phoneUrl),
                        icon: Icon(LineIcons.phone, size: 40.0, color: Theme.of(context).accentColor,)),
                    IconButton(
                        onPressed: () => _launchUrl(_messageUrl),
                        icon: Icon(Icons.message, size: 40,color: Theme.of(context).accentColor,)),
                    IconButton(
                        onPressed: () => _launchUrl(_whatsAppUrl),
                        icon: Icon(LineIcons.whatSApp, size: 40,color: Theme.of(context).accentColor,)),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }


  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}
