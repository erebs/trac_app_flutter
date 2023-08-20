import 'package:flutter/material.dart';
import 'package:get_upi/get_upi.dart';
import 'package:remixicon/remixicon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trac_app/contants/app_colors.dart';
import 'package:trac_app/views/pages/mainscreen/main_screen.dart';
import 'package:trac_app/views/pages/splashscreen/splash_screen.dart';
import 'package:trac_app/views/widgets/shimmers/search_shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../utils/snackbar.dart';
import '../loginscreen/login_screen.dart';
// #enddocregion platform_imports
class WebScreen extends StatefulWidget {
   WebScreen({
    super.key,
    required this.url,

  });

   String url;

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {

  late final WebViewController _controller;
  String titleJS = '...';
  bool isInstamojo = false;
  RxBool isLoading = RxBool(true);
  List<UpiObject> upiAppsList = [];


  @override
  void initState() {
    getUpi();
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..enableZoom(false)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
            isLoading.value = true;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
            if (url.contains('instamojo')) {
              isInstamojo = true;
            }
            getHtmlPageTitle();
            // hideScrollBars();
            setMobileAndSendOtp();
            FocusManager.instance.primaryFocus?.unfocus();

          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {

            //  Snack.show("Launched", request.url);

            if (request.url.contains('instamojo')) {
              isInstamojo = true;
            }

            if (request.url.startsWith('intent://')) {
              debugPrint('blocking navigation to ${request.url}');
              String upiUrl = request.url.replaceAll("intent://", "upi://");
              launchURL(Uri.parse(upiUrl));
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');

            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'AppInterface',
        onMessageReceived: (JavaScriptMessage message) {
          // Snack.show("AppInterface", message.message);
          if(message.message == "JSC_kill_n_goHome")
            {Get.offAll(MainScreen());}

          if(message.message == "JSC_kill_n_goLogin")
          {Get.offAll(const LoginScreen());}

          if(message.message == "JSC_kill_n_goSplash")
          {Get.offAll(const SplashScreen());}

          if(message.message == "JSC_kill_n_goBack")
          {
            //Snack.show("JSC_kill_n_goBack", "");
            Get.back();}

        },


      )
      ..loadRequest(Uri.parse(widget.url));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(titleJS, style: const TextStyle(fontSize: 14),),
      ),
      body: SafeArea(
        child: Obx( ()=> isLoading.value?SearchShimmer():WebViewWidget(controller: _controller)),
      ),
    );
  }

  Future<void>  getHtmlPageTitle() async {
    if (_controller != null) {
      Object pageTitle = await _controller.runJavaScriptReturningResult('document.title');
      setState(() {
        titleJS = isInstamojo?"Instamojo":pageTitle.toString().replaceAll('"', '');
      });
    }
  }

  setMobileAndSendOtp() async {
    if (_controller != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userMobile = prefs.getString("user_mobile").toString();
      if(userMobile.length == 10) {
        _controller.runJavaScript(
            "document.getElementById('mobile').value = '$userMobile';"
                "SendOtp();"
                "document.getElementById('otpbtn').disabled = false;"
                "document.getElementById( 'otpbtn' ).style.backgroundColor = 'rgb(37, 38, 115)';"

        );
      }
    }
  }


  launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);

    } else {
      throw 'Could not launch $url';

    }
  }

  void getUpi() async {
    var value = await GetUPI.apps();
    upiAppsList = value.data;
    setState(() {});
  }

}
