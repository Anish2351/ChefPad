import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecipeView extends StatefulWidget {
  final String postUrl;
  RecipeView({@required this.postUrl});

  @override
  _RecipeViewState createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  String finalUrl;

  @override
  void initState() {
    super.initState();
    if (widget.postUrl.contains('http://')) {
      finalUrl = widget.postUrl.replaceAll("http://", "https://");
    } else {
      finalUrl = widget.postUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: Platform.isIOS ? 60 : 30,
                  right: 24,
                  left: 24,
                  bottom: 13),
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Row(
                mainAxisAlignment:
                    kIsWeb ? MainAxisAlignment.start : MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Chef",
                    style: TextStyle(
                        fontSize: 25,
                        letterSpacing: 1.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Overpass'),
                  ),
                  Text(
                    "Pad",
                    style: TextStyle(
                      fontSize: 25,
                      letterSpacing: 1.5,
                      color: Colors.blue,
                      fontFamily: 'Overpass',
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  (Platform.isIOS ? 104 : 95),
              width: MediaQuery.of(context).size.width,
              child: WebView(
                onPageFinished: (val) {
                  print(val);
                },
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: finalUrl,
                onWebViewCreated: (WebViewController webViewController) {
                  setState(() {
                    _controller.complete(webViewController);
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
