// import 'dart:io';
//
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// Future<void> requestNotificationPermission() async {
//   final messaging = FirebaseMessaging.instance;
//   if ((Platform.isAndroid && await _isAndroid13OrAbove()) || Platform.isIOS) {
//     NotificationSettings settings = await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     debugPrint("🔔 Permission: ${settings.authorizationStatus}");
//   }
// }
//
// Future<bool> _isAndroid13OrAbove() async {
//   if (Platform.isAndroid) {
//     final info = await DeviceInfoPlugin().androidInfo;
//     final version = int.tryParse(info.version.release.split(".")[0]) ?? 0;
//     return version >= 13;
//   }
//   return false;
// }
//
// // ✅ Create notification channel with default sound
// Future<void> setupNotificationChannel() async {
//   const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel',
//     'High Importance Notifications',
//     description: 'Used for important notifications',
//     importance: Importance.max,
//     playSound: true, // default sound
//   );
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   const InitializationSettings initSettings = InitializationSettings(
//     android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//     iOS: DarwinInitializationSettings(),
//   );
//
//   await flutterLocalNotificationsPlugin.initialize(initSettings);
// }
//
// // ✅ Listen for messages with full debug
// void initPushNotifications() {
//   // Foreground messages
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     debugPrint("📩 Foreground message received!");
//     debugPrint("📩 Title: ${message.notification?.title}");
//     debugPrint("📩 Body: ${message.notification?.body}");
//     debugPrint("📩 Data: ${message.data}");
//
//     flutterLocalNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title ?? '',
//       message.notification?.body ?? '',
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'high_importance_channel',
//           'High Importance Notifications',
//           importance: Importance.max,
//           priority: Priority.high,
//           playSound: true, // default sound
//         ),
//         iOS: DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true, // default sound
//         ),
//       ),
//     );
//   });
//
//   // App opened from notification
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     debugPrint("📲 Notification clicked!");
//     debugPrint("📲 Title: ${message.notification?.title}");
//     debugPrint("📲 Body: ${message.notification?.body}");
//     debugPrint("📲 Data: ${message.data}");
//   });
// }