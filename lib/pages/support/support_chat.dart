import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:winly/globals/configs/nsurl_errors.dart';
import 'package:winly/helpers/snack.dart';
import 'package:winly/services/api/url.dart';

import 'widget/web_error_widget.dart';

class SupportChatWebView extends StatefulWidget {
  final String url;
  const SupportChatWebView({Key? key, this.url = supportChatBaseUrl})
      : super(key: key);

  @override
  _SupportChatWebViewState createState() => _SupportChatWebViewState();
}

class _SupportChatWebViewState extends State<SupportChatWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController? _webViewController;

  bool _isLoading = true;
  bool _isError = false;
  Widget _errorWidget = const SizedBox();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!_isError) _webViewWidget(),
        if (_isLoading) const Center(child: CircularProgressIndicator()),
        if (_isError) _errorWidget,
      ],
    );
  }

  Widget _webViewWidget() => WebView(
        initialUrl: widget.url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) async {
          if (!_controller.isCompleted) {
            _controller.complete(webViewController);
          }
          _webViewController = webViewController;
        },
        onProgress: (int progress) {
          debugPrint("WebView is loading (progress : $progress%)");
        },
        javascriptChannels: <JavascriptChannel>{
          _toasterJavascriptChannel(context),
        },
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          debugPrint('Page started loading: $url');
        },
        onPageFinished: (String url) {
          setState(() {
            _isLoading = false;
          });
          debugPrint('Page finished loading: $url');
        },
        gestureNavigationEnabled: true,
        onWebResourceError: _onWebResourceError,
      );

  Future<void> _onWebResourceError(WebResourceError error) async {
    final Connectivity _connectivity = Connectivity();
    ConnectivityResult? result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint("Reloading..." + e.toString());
    } on MissingPluginException catch (e) {
      debugPrint("Reloading..." + e.toString());
    }

    debugPrint("Reloading..." + result.toString());
    String? _errorMessage = isInternetConnected(result)
        ? getNSURLErrorMessage(error.errorCode)
        : "No internet connectivity found";

    if (_errorMessage != null) {
      _errorWidget = WebErrorWidget(
        errorMessage: _errorMessage,
        onButtonPressed: () async {
          debugPrint("Reloading...");
          setState(() {
            _isLoading = true;
            _isError = false;
          });
          _webViewController?.reload();
        },
      );

      setState(() {
        _isLoading = false;
        _isError = true;
      });
    }
  }

  bool isInternetConnected(ConnectivityResult? result) {
    if (result == null) return true;

    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        return true;
      default:
        return false;
    }
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          snack(
            title: 'Message',
            desc: message.message,
            icon: const Icon(Icons.info),
          );
        });
  }
}
