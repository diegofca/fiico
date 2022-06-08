import 'package:control/helpers/extension/colors.dart';
import 'package:control/helpers/fonts_params.dart';
import 'package:control/helpers/genericViews/gray_app_bard.dart';
import 'package:control/helpers/manager/localizable_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebviewPage extends StatefulWidget {
  final String url;

  const WebviewPage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  WebviewPageState createState() => WebviewPageState();
}

class WebviewPageState extends State<WebviewPage> {
  double progress = 0;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      javaScriptEnabled: true,
      javaScriptCanOpenWindowsAutomatically: true,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FiicoColors.grayBackground,
      appBar: GenericAppBar(
        text: FiicoLocale().termsAndConditionsOfUse,
      ),
      body: _bodyContainer(context),
    );
  }

  Widget _bodyContainer(BuildContext context) {
    return Container(
      height: double.maxFinite,
      width: double.maxFinite,
      padding: const EdgeInsets.only(
        top: FiicoPaddings.thirtyTwo,
      ),
      child: Column(
        children: [
          Container(
            child: progress < 1.0
                ? Container(
                    padding: const EdgeInsets.all(
                      FiicoPaddings.eight,
                    ),
                    child: LinearProgressIndicator(
                      value: progress,
                      color: FiicoColors.purpleDark,
                      backgroundColor: FiicoColors.purpleLite,
                    ),
                  )
                : Container(),
          ),
          Expanded(child: _webView()),
        ],
      ),
    );
  }

  Widget _webView() {
    URLRequest urlRequest = URLRequest(url: Uri.parse(widget.url));
    return InAppWebView(
      initialUrlRequest: urlRequest,
      initialOptions: options,
      onReceivedServerTrustAuthRequest: (InAppWebViewController controller,
          URLAuthenticationChallenge challenge) async {
        return ServerTrustAuthResponse(
          action: ServerTrustAuthResponseAction.PROCEED,
        );
      },
      onProgressChanged: (InAppWebViewController controller, int progress) {
        setState(() {
          this.progress = progress / 100;
        });
      },
    );
  }
}
