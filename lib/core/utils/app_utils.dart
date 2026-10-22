
import 'dart:io';
import 'dart:math';

   import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils{
  static Size deviceScreenSize(BuildContext context){
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return queryData.size;
  }

  static final _numberFormatter = NumberFormat.compact();
  static String formatNumber(double number)=> _numberFormatter.format(number);

  static String formatPrice(
      dynamic price, {
        bool withDecimal = false,
      }) {
    double amount =
    price is String ? double.parse(price) : price.floorToDouble();
    final currencyFormat =
    NumberFormat(withDecimal ? "#,##0.00" : "#,##0", "en_US");
    return '₦${currencyFormat.format(amount)}';
  }

  static final dateTimeFormat = DateFormat('dd MMM yyyy, hh:mm a');
  static final dateFormat = DateFormat('dd MMM, yyyy');
  static final timeFormat = DateFormat('hh:mm a');
  static final apiDateFormat = DateFormat('dd-MM-yyyy');
  static final apiDateFormat2 = DateFormat('yyyy-MM-dd');

  static final utcTimeFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
  static final dayOfWeekFormat = DateFormat('EEEEE', 'en_US');


  static Future<void> launchCaller(String phoneNumber) async {
    if (kIsWeb) {
       return;
    }

    final cleanNumber =
    phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');

    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: cleanNumber,
    );

    final launched = await launchUrl(
      phoneUri,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
     }
  }

  static Future<void> launchURL(String url,) async {
    var encoded = Uri.encodeFull(url);
    if (await canLaunchUrl(Uri.parse(encoded))) {
      await launchUrl(
        Uri.parse(encoded),
        mode: LaunchMode.externalApplication,
      );

    } else {
      throw 'Could not launch $url';
    }
  }
  static Future<void> launchEmail({
    required String toEmail,
    String subject = '',
    String body = '',
  }) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      throw 'Could not launch email client for $toEmail';
    }
  }

  static Future<void> launchWhatsApp(String phoneNumber, {String message = ''}) async {
    String formattedNumber = phoneNumber.startsWith('0')
        ? phoneNumber.substring(1)
        : phoneNumber;
    final url = Uri.parse("https://wa.me/+234$formattedNumber?text=${Uri.encodeComponent(message)}");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch WhatsApp';
    }
  }


 static double _deg2rad(double deg) => deg * (pi / 180);

 static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const earthRadius = 6371; // km
    final dLat = _deg2rad(lat2 - lat1);
    final dLon = _deg2rad(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) *
            sin(dLon / 2) * sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  static DateTime? parseDate(dynamic value) {
    if (value == null) return null;

    // if (value is Timestamp) {
    //   return value.toDate();
    // }

    if (value is String) {
      if (value.isEmpty) return null;
      return DateTime.tryParse(value);
    }
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);


    // Firestore timestamp object (map)
    if (value is Map && value.containsKey("_seconds")) {
      return DateTime.fromMillisecondsSinceEpoch(value["_seconds"] * 1000);
    }

    return null;
  }


  static int? toInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }



  static double toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value)??0.0;
    return 0.0;
  }
  // static bool alreadyCommented(String type, String productId) {
  //   final orders = injector.get<AccountViewModel>().activeOrdersById ;
  //
  //   for (var order in orders) {
  //     for (var item in order.items) {
  //       if (type == 'product' && item.productId == productId) {
  //         return true;
  //       } else if (type == 'vendor' && item.vendorId == productId) {
  //         return true;
  //       }
  //     }
  //   }
  //
  //   return false; // Return false if no match is found
  // }
 static DateTime addMonths(DateTime date, int monthsToAdd) {
    int newYear = date.year + ((date.month + monthsToAdd - 1) ~/ 12);
    int newMonth = ((date.month + monthsToAdd - 1) % 12) + 1;
    int newDay = date.day;
    // Handle end-of-month edge cases
    int lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;
    if (newDay > lastDayOfNewMonth) newDay = lastDayOfNewMonth;
    return DateTime(newYear, newMonth, newDay, date.hour, date.minute, date.second);
  }

  // static Map<String, dynamic> normalizeData(Map<String, dynamic> data) {
  //   final normalized = <String, dynamic>{};
  //
  //   data.forEach((key, value) {
  //     normalized[key] = _normalizeValue(value);
  //   });
  //
  //   return normalized;
  // }

  // static dynamic _normalizeValue(dynamic value) {
  //   if (value == null) return null;
  //
  //   // Firestore Timestamp
  //   if (value is Timestamp) {
  //     return value.toDate().millisecondsSinceEpoch;
  //   }
  //
  //   // DateTime object
  //   if (value is DateTime) {
  //     return value.millisecondsSinceEpoch;
  //   }
  //
  //   // String date → try parse
  //   if (value is String) {
  //     final parsed = DateTime.tryParse(value);
  //     if (parsed != null) {
  //       return parsed.millisecondsSinceEpoch;
  //     }
  //     return value; // return original string if not a date
  //   }
  //
  //   // Lists → recursively normalize
  //   if (value is List) {
  //     return value.map(_normalizeValue).toList();
  //   }
  //
  //   // Maps → recursively normalize
  //   if (value is Map) {
  //     return value.map((k, v) => MapEntry(k, _normalizeValue(v)));
  //   }
  //
  //   return value;
  // }

 static double addNewRating({
    required double currentAvg,
    required int currentCount,
    required double newRating,
  }) {
    final total = currentAvg * currentCount;
    final newTotal = total + newRating;
    return (newTotal / (currentCount + 1));
  }


 static Future<bool> isLower( String v2) async {
   final info = await PackageInfo.fromPlatform();
   final currentVersion = info.version;
    List<int> a = currentVersion.split('.').map(int.parse).toList();
    List<int> b = v2.split('.').map(int.parse).toList();

    for (int i = 0; i < a.length; i++) {
      if (a[i] < b[i]) return true;
      if (a[i] > b[i]) return false;
    }
    return false;
  }



  static Future<void> openStore({
    required String androidUrl,
    required String iosUrl,
  }) async {
    final url = Platform.isIOS ? iosUrl : androidUrl;

    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch store';
    }
  }
}



