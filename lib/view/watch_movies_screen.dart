import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WatchMoviesNow extends StatefulWidget {
  final int id; // Add id parameter

  const WatchMoviesNow({super.key, required this.id}); // Accept id in constructor

  @override
  State<WatchMoviesNow> createState() => _WatchMoviesNowState();
}

class _WatchMoviesNowState extends State<WatchMoviesNow> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Set orientation to landscape
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  }

  @override
  void dispose() {
    // Reset orientation to portrait when disposing
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(
                    'https://vidsrc.net/embed/movie/${widget.id}',
                  ),
                ),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    javaScriptCanOpenWindowsAutomatically: false,
                    mediaPlaybackRequiresUserGesture: false, // يسمح بتشغيل الوسائط تلقائياً
                  ),
                  android: AndroidInAppWebViewOptions(),
                  ios: IOSInAppWebViewOptions(
                    allowsInlineMediaPlayback: false,
                    disallowOverScroll: false,
                  ),
                ),
                onLoadStop: (controller, url) {
                  setState(() {
                    isLoading = false;
                  });
                },
                shouldInterceptRequest: (controller, request) async {
                  // حظر روابط الإعلانات بناءً على الدومين أو المسار
                  if (request.url.toString().contains("ads") ||
                      request.url.toString().contains("doubleclick.net") ||
                      request.url.toString().contains("googlesyndication.com")) {
                    // تجاهل طلبات الإعلانات
                    return WebResourceResponse(
                      contentType: 'text/plain',
                      data: Uint8List.fromList([]),
                    );
                  }
                  return null; // السماح بالطلب إذا لم يكن إعلانيًا
                },
                shouldOverrideUrlLoading: (controller, navigationAction) async {
                  final requestedUrl = navigationAction.request.url;
                  final mainUrl = Uri.parse('https://vidsrc.net/embed/movie/${widget.id}');

                  if (requestedUrl != null && requestedUrl.host != mainUrl.host) {
                    return NavigationActionPolicy.CANCEL;
                  }
                  return NavigationActionPolicy.ALLOW;
                },
              ),
            ),
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
