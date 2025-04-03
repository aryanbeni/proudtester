# Automation Dashboard App

A feature-rich Flutter application with notification controls, web browsing, user data display, and interactive elements.

[//]: # (![App Screenshot]&#40;screenshot.png&#41; <!-- Replace with your actual screenshot -->)

## Features

- **Notification Management**: Request and handle notification permissions
- **Integrated Web Browser**: In-app web browsing with WebView
- **User Data Display**: Fetch and display JSON API data
- **Interactive UI**: Animated cards with gradient backgrounds
- **Responsive Design**: Works on mobile and tablet devices

## Technical Stack

- Flutter 3.x
- Dart 3.x
- Stateful Widgets
- WebView (webview_flutter)
- HTTP Requests (http)
- Permission Handling (permission_handler)

## Installation

```bash
git clone https://github.com/aryanbeni/proudtester.git
cd automation-app
flutter pub get
flutter run
```

## Configuration

### Android
- Add to AndroidManifest.xml:
```xml
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
<uses-permission android:name="android.permission.INTERNET"/>
```
### IOS
- Add to Info.plist:
```xml
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
<key>NSUserNotificationAlertStyle</key>
<string>alert</string>
```
## Package Used
-webview_flutter: ^4.4.0
-http: ^0.13.5
-permission_handler: ^10.4.0
-url_launcher: ^6.1.11

## Folder Structure
```xml
lib/
├── main.dart          # App entry point
├── home_page.dart     # Main dashboard UI
├── webview_page.dart  # Web browser implementation
└── user_data.dart     # API data display
```

