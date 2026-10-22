// import 'dart:io';
//    import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../../../data_structure/bloc/account_cubit.dart';
// import '../../../data_structure/view_models/account_view_model.dart';
// import '../../../di/injection.dart';
//
// class FCMService {
//   static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   static Future<void> initFCM({bool updateNow=false}) async {
//     final user = injector.get<AccountViewModel>().user;
// print('object');
//     // 1️⃣ Request permission
//     await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     // debugPrint(' ..........................${'token'}');
//     // await injector.get<AccountCubit>().getPhoneDetails('token'??'');
//     // 2️⃣ iOS: wait until APNs token is ready
//     if (Platform.isIOS) {
//       String? apnsToken;
//       int retry = 0;
//
//       while (apnsToken == null && retry < 10) {
//         apnsToken = await _messaging.getAPNSToken();
//         retry++;
//         await Future.delayed(const Duration(milliseconds: 100));
//       }
//
//       if (apnsToken == null) {
//         // APNs still not ready — avoid crashing
//         return;
//       }
//     }
//
//     // 3️⃣ Now it is SAFE to get FCM token
//     final token = await _messaging.getToken();
//     debugPrint(' .........................token.${token}');
//     // await injector.get<AccountCubit>().getPhoneDetails(token??'');
// if(updateNow) {
//   if (token != null && user != null) {
//     final x = user.copyWith(
//         fcmToken: token
//     );
//
//     await injector.get<AccountCubit>().getPhoneDetails(token);
//   }
// }
//     // 4️⃣ Listen for token refresh
//     _messaging.onTokenRefresh.listen((newToken) async {
//       debugPrint('..........................$token ');
//
//       if(user!=null &&updateNow ){
//
//         // debugPrint(' ..........................${x.fcmToken}');
//
//
//         await injector.get<AccountCubit>().getPhoneDetails(newToken);
//
//
//       }
//
//     });
//   }
//
//
// }
