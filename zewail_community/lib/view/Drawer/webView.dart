import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Core/Function/AlertExit.dart';

import '../../main.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  _MyWebViewState createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            // Show loading indicator when the page starts loading
            if (mounted) {
              setState(() {
                isLoading = true;
              });
            }
          },
          onPageFinished: (String url) {
            // Hide loading indicator when the page finishes loading
            if (mounted) {
              setState(() {
                isLoading = false;
              });
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          'https://rozewail.com/student/loginFromApp?stid=${prefs!.getInt("stid")}&hash=${prefs!.getString("pass")}'));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (await controller.canGoBack()) {
          controller.goBack();
          return false;
        } else {
          return showExitConfirmationDialog(context);
        }
        // return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('روزويل')),
        ),
        body: Stack(
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
