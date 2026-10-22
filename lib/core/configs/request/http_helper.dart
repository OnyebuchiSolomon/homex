// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/retry.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:retry/retry.dart';
// import '../../handlers/app_handler.dart';
// import '../../handlers/request_handler.dart';
// import '../../res/app_strings.dart';
// import '../../utils/exceptions.dart';
// import 'data_model/api_response.dart';
// import 'headers.dart';
//
// class HttpHelper {
//   HttpHelper._();
//
//   static final _instance = HttpHelper._();
//   static HttpHelper get instance => _instance;
//
//   Future<dynamic> get(
//     String route, {
//     Map<String, String>? headers,
//     dynamic body,
//   }) async {
//     late dynamic map;
//    // AppHandler.logPrint(route, name: 'Route');
//     final client = RetryClient(http.Client());
//     try {
//       if (body != null) {
//         final request_property = http.StreamedRequest('GET', Uri.parse(route));
//         request_property.headers.addAll(headers ?? await rawDataHeader());
//         request_property.sink
//           ..add(utf8.encode(json.encode(body)))
//           ..close();
//         final streamedResponse = await retry(
//           () => request_property.send(),
//           retryIf: (e) => e is SocketException || e is TimeoutException,
//         );
//         map = json.decode(
//           RequestHandler.handleServerError(
//             await http.Response.fromStream(streamedResponse),
//           ),
//         );
//       } else {
//         await client
//             .get(Uri.parse(route), headers: headers ?? await rawDataHeader())
//             .then((response) {
//           map = json.decode(RequestHandler.handleServerError(response));
//         });
//       }
//       // if (map is Map &&
//       //     map.containsKey('status') &&
//       //     map['status'] is bool &&
//       //     map['status'] == false) {
//       //   throw ApiException(RequestHandler.handleApiError(map));
//       // }
//       // if (map["status"] != null && !map["status"]) {
//       //   throw ApiException(RequestHandler.handleApiError(map));
//       // }
//     } on SocketException {
//       throw NetworkException(AppStrings.networkErrorMessage);
//     } on HandshakeException {
//       throw NetworkException(AppStrings.networkErrorMessage);
//     } on FormatException catch (e) {
//       throw NetworkException(e.toString());
//     } finally {
//       client.close();
//     }
//     return map;
//   }
//
//   Future<dynamic> post(String route,
//       {Map<String, String>? headers,
//       dynamic body,
//       Map<String, dynamic>? files,
//       Encoding? encoding,
//       RetryOptions? retryOption}) async {
//     late dynamic map;
//     AppHandler.logPrint(route, name: 'Route');
//     try {
//       if (files != null) {
//         final request_property = http.MultipartRequest('POST', Uri.parse(route));
//         request_property.headers.addAll(headers ?? await formDataHeader());
//         if (body != null) {
//           request_property.fields.addAll(body as Map<String, String>);
//         }
//         await Future.forEach(files.entries,
//             (MapEntry<String, dynamic> entry) async {
//           final key = entry.key;
//           final value = entry.value;
//
//           if (value is List<File>) {
//             for (File file in value) {
//               final stream = http.ByteStream(file.openRead());
//               final length = await file.length();
//
//               final multipartFile = http.MultipartFile(key, stream, length,
//                   filename: file.path.split('/').last,
//                   contentType:
//                       MediaType('application', file.path.split('.').last));
//               // Add the multipart file to the request_property
//               request_property.files.add(multipartFile);
//             }
//             return;
//           }
//
//           request_property.files.add(await http.MultipartFile.fromPath(key, value.path,
//               filename: value.path.split('/').last,
//               contentType:
//                   MediaType('application', value.path.split('.').last)));
//         });
//
//         final response = retryOption != null
//             ? await retryOption.retry(() => request_property.send())
//             : await retry(
//                 () => request_property.send(),
//                 retryIf: (e) => e is SocketException || e is TimeoutException,
//               );
//         map = json
//             .decode(await RequestHandler.handleStreamedServerError(response));
//       } else {
//         final client = RetryClient(http.Client());
//         await client
//             .post(Uri.parse(route),
//                 body: json.encode(body),
//                 headers: headers ?? await rawDataHeader(),
//                 encoding: encoding)
//             .then((response) {
//           map = json.decode(RequestHandler.handleServerError(response));
//           client.close();
//         });
//       }
//
//       if (map["status"] != null && !map["status"]) {
//         throw ApiException(RequestHandler.handleApiError(map));
//       }
//     } on SocketException {
//       throw NetworkException(AppStrings.networkErrorMessage);
//     } on HandshakeException {
//       throw NetworkException(AppStrings.networkErrorMessage);
//     } on FormatException catch (e) {
//       throw NetworkException(e.toString());
//     }
//
//     return map;
//   }
//
//   Future<dynamic> put(String route,
//       {Map<String, String>? headers,
//       dynamic body,
//       Map<String, File>? files,
//       Encoding? encoding,
//       RetryOptions? retryOption}) async {
//     AppHandler.logPrint(route, name: 'Route');
//     late dynamic map;
//     try {
//       if (files != null) {
//         var request_property = http.MultipartRequest('PUT', Uri.parse(route));
//         request_property.headers.addAll(headers ?? await formDataHeader());
//         if (body != null) {
//           request_property.fields.addAll(body as Map<String, String>);
//         }
//         files.forEach((key, value) async {
//           request_property.files.add(await http.MultipartFile.fromPath(key, value.path,
//               filename: value.path.split('/').last));
//         });
//
//         final response = retryOption != null
//             ? await retryOption.retry(() => request_property.send())
//             : await retry(
//                 () => request_property.send(),
//                 retryIf: (e) => e is SocketException || e is TimeoutException,
//               );
//         map = json
//             .decode(await RequestHandler.handleStreamedServerError(response));
//       } else {
//         final client = RetryClient(http.Client());
//         await client
//             .put(Uri.parse(route),
//                 body: json.encode(body),
//                 headers: headers ?? await rawDataHeader(),
//                 encoding: encoding)
//             .then((response) {
//           map = json.decode(RequestHandler.handleServerError(response));
//           client.close();
//         });
//       }
//
//       if (map["status"] != null && !map["status"]) {
//         throw ApiException(RequestHandler.handleApiError(map));
//       }
//     } on SocketException {
//       throw NetworkException(AppStrings.networkErrorMessage);
//     } on HandshakeException {
//       throw NetworkException(AppStrings.networkErrorMessage);
//     } on FormatException catch (e) {
//       throw NetworkException(e.toString());
//     }
//
//     return map;
//   }
//
//   Future<dynamic> delete(String route, {Map<String, String>? headers}) async {
//     late dynamic map;
//     AppHandler.logPrint(route, name: 'Route');
//     final client = RetryClient(http.Client());
//     try {
//       await client
//           .delete(Uri.parse(route), headers: headers ?? await rawDataHeader())
//           .then((response) {
//         map = json.decode(RequestHandler.handleServerError(response));
//
//         if (map["status"] != null && !map["status"]) {
//           throw ApiException(RequestHandler.handleApiError(map));
//         }
//       });
//     } on SocketException {
//       throw NetworkException(AppStrings.networkErrorMessage);
//     } on HandshakeException {
//       throw NetworkException(AppStrings.networkErrorMessage);
//     } on FormatException catch (e) {
//       throw NetworkException(e.toString());
//     } finally {
//       client.close();
//     }
//
//     return map;
//   }
//
//   Future<ApiResponse> makeRequest(Future<dynamic> Function() request_property,
//       {required SuccessResponse Function(dynamic) onSuccess,
//       ErrorResponse? Function(String)? onError}) async {
//     try {
//       final map = await request_property();
//       return onSuccess.call(map);
//     } on ApiException catch (e) {
//       return onError?.call(e.message) ?? ErrorResponse(message: e.message);
//     } catch (e) {
//       if (e is NetworkException ||
//           e is BadRequestException ||
//           e is UnauthorisedException ||
//           e is FileNotFoundException ||
//           e is AlreadyRegisteredException) {
//         if (e.toString() == "Unauthenticated.") {
//           // injector.get<AccountCubit>().logout(
//           //       showToast: false,
//           //       serverLogout: false,
//           //     );
//         }
//         return onError?.call(e.toString()) ??
//             ErrorResponse(message: e.toString());
//       } else {
//         rethrow;
//       }
//     }
//   }
// }
