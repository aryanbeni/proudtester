import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:proudtester/userdata_page.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Generate random light colors for card backgrounds
  // final Random _random = Random();
  //
  // Color get _randomLightColor => Color.fromARGB(
  //   255,
  //   200 + _random.nextInt(56),
  //   200 + _random.nextInt(56),
  //   200 + _random.nextInt(56),
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: Center(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Icon(Icons.emoji_emotions_outlined,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Welcome to the Field of Automation!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      _buildFeatureCard(
                        context,
                        icon: Icons.notifications_active,
                        title: "Notification\nPermission",
                        color: Colors.amber.shade300,
                        onTap: _requestNotificationPermission,
                      ),
                      const SizedBox(width: 20),
                      _buildFeatureCard(
                        context,
                        icon: Icons.public,
                        title: "Open\nWebPage",
                        color: Colors.redAccent.shade200,
                        onTap: () => _openWebView(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      _buildFeatureCard(
                        context,
                        icon: Icons.waving_hand,
                        title: "Show\nGreeting",
                        color: Colors.greenAccent.shade200,
                        onTap: () => _showGreetingDialog(context),
                      ),
                      const SizedBox(width: 20),
                      _buildFeatureCard(
                        context,
                        icon: Icons.people,
                        title: "User\nData",
                        color: Colors.purpleAccent.shade200,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserDataPage(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, {
        required IconData icon,
        required String title,
        required Color color,
        required VoidCallback onTap,
      }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: 250,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  Color.lerp(color, Colors.black, 0.1)!,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to request notification permission
  Future<void> _requestNotificationPermission() async {
    try {
      final status = await Permission.notification.status;

      if (status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Notifications already enabled')),
        );
      } else if (status.isDenied) {
        final result = await Permission.notification.request();
        if (result.isGranted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notification permission granted')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notification permission denied')),
          );
        }
      } else if (status.isPermanentlyDenied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enable notifications in app settings'),
            action: SnackBarAction(
              label: 'Open Settings',
              onPressed: openAppSettings,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  // Function to open WebView
  void _openWebView(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const WebViewPage(),
      ),
    );
  }

  // Function to show greeting dialog
  void _showGreetingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Greeting'),
          content: const Text('Hello! Happy learning'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// WebView Page
class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
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
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
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
        ),
      )
      ..loadRequest(Uri.parse('https://stocks.univest.in'));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    this.controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web View'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
