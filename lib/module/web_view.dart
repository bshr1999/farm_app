import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:man/shared/local/shared_components.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webs extends StatefulWidget {
  String id;
  String total;
  String phone_no;
  Webs({required this.id,required this.total,required this.phone_no,Key? key}) : super(key: key);

  @override
  State<Webs> createState() => _WebsState();
}

class _WebsState extends State<Webs> {
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
  @override
  Widget build(BuildContext context) {
    log('lklklklk');
    log(widget.id.toString());
    log(widget.total.toString());
    log(widget.phone_no.toString());
    return  Scaffold(
      appBar: appBar(context: context, text: 'ذبيحتك وليمتك'),
      body: WebView(
        initialUrl: 'https://walematk.com/api/for_app?clint_id=${widget.id}&total=${widget.total}&phone_no=${widget.phone_no}',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
