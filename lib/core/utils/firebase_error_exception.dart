// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:flutter/cupertino.dart';
// import '../configs/request_property/data_model/api_response.dart';
// import '../handlers/app_handler.dart';
//
// /// A universal mapper that converts any Firebase exception (Auth, Firestore,
// /// Storage, or Functions) into an ApiResponse.
// class FirebaseErrorMapper {
//   /// Handle all Firebase-related errors and return a unified ApiResponse.error.
//   static ApiResponse<dynamic> handle(dynamic e) {
//     AppHandler.logPrint(e.toString());
//     if (e is FirebaseAuthException) {
//       return _handleAuthError(e);
//     } else if (e is FirebaseException && e.plugin == 'cloud_firestore') {
//       return _handleFirestoreError(e);
//     } else if (e is FirebaseException && e.plugin == 'firebase_storage') {
//       return _handleStorageError(e);
//     } else if (e is FirebaseFunctionsException) {
//       return _handleFunctionsError(e);
//     } else if (e is FirebaseException) {
//       // Catch-all for other FirebaseException plugins
//       return ApiResponse.error(
//         message: e.message ?? 'Firebase service error (${e.plugin})',
//         data: {'error-code': e.code},
//       );
//     } else {
//       return ApiResponse.error(
//         message: 'An unknown error occurred.',
//         data: {'error-code': 'unknown'},
//       );
//     }
//   }
//
//   // 🔐 Firebase Auth
//   static ApiResponse<dynamic> _handleAuthError(FirebaseAuthException e) {
//     final code = e.code.toLowerCase();
//     String message;
//
//     switch (code) {
//       case 'invalid-email':
//         message = 'Invalid email address.';
//         break;
//       case 'user-disabled':
//         message = 'This user account has been disabled.';
//         break;
//       case 'user-not-found':
//         message = 'No user found with this email.';
//         break;
//       case 'wrong-password':
//         message = 'Incorrect email or password.';
//
//         break;
//       case 'invalid-credential':
//         message = 'Incorrect email or password.';
//         break;
//       case 'email-already-in-use':
//         message = 'This email is already registered.';
//         break;
//       case 'operation-not-allowed':
//         message = 'This authentication method is not enabled.';
//         break;
//       case 'weak-password':
//         message = e.message ?? 'The password is too weak.';
//         break;
//       case 'too-many-requests':
//         message = 'Too many login attempts. Try again later.';
//         break;
//       case 'unavailable':
//         message = 'No internet connection';
//
//         break;
//       case 'network-request_property-failed':
//         message = 'No internet connection';
//         break;
//       case 'requires-recent-login':
//         message = 'Please reauthenticate before performing this action.';
//         break;
//       case 'unknown':
//         message = e.message ?? 'An internal error has occurred';
//         break;
//       default:
//         message = e.message ?? 'Authentication failed.';
//     }
//
//     return ApiResponse.error(message: message, data: {'error-code': e.code});
//   }
//
//   // 🔥 Firestore
//   static ApiResponse<dynamic> _handleFirestoreError(FirebaseException e) {
//     final code = e.code.toLowerCase();
//     String message;
//     switch (code) {
//       case 'cancelled':
//         message = 'The operation was cancelled.';
//         break;
//       case 'invalid-argument':
//         message =
//             e.message ?? 'Invalid argument provided for Firestore operation.';
//         break;
//       case 'deadline-exceeded':
//         message = e.message ?? 'Firestore request_property timed out.';
//         break;
//       case 'not-found':
//         message = e.message ?? 'Requested document not found.';
//         break;
//       case 'already-exists':
//         message = 'Document already exists.';
//         break;
//       case 'permission-denied':
//         message =
//             'You do not have permission to perform this operation.';
//         break;
//       case 'resource-exhausted':
//         message = e.message ?? 'Quota exceeded or too many writes.';
//         break;
//       case 'failed-precondition':
//         message =
//             e.message ?? 'Operation cannot be performed in the current state.';
//         break;
//       case 'aborted':
//         message = e.message ?? 'Operation aborted.';
//         break;
//       case 'unavailable':
//         message = 'No internet connection ';
//         break;
//       case 'unauthenticated':
//         message = 'User not authenticated. Please try to re-login';
//         break;
//       case 'Invalid email':
//         message = 'Invalid email. Email does not exist';
//         break;
//       default:
//         message = e.message ?? 'Error occurred.';
//     }
//
//     return ApiResponse.error(message: message, data: {'error-code': e.code});
//   }
//
//   // ☁️ Firebase Storage
//   static ApiResponse<dynamic> _handleStorageError(FirebaseException e) {
//     final code = e.code.toLowerCase();
//     String message;
//
//     switch (code) {
//       case 'object-not-found':
//         message =  'The requested file does not exist.';
//         break;
//       case 'bucket-not-found':
//         message = e.message ?? 'The storage bucket was not found.';
//         break;
//       case 'project-not-found':
//         message = e.message ?? 'The Firebase project was not found.';
//         break;
//       case 'quota-exceeded':
//         message = e.message ?? 'Storage quota exceeded.';
//         break;
//       case 'unauthenticated':
//         message = 'User not authenticated for this operation. Please try to login again';
//         break;
//
//       case 'unauthorized':
//         message = e.message ?? 'You are not authorized to perform this action.';
//         break;
//       case 'cancelled':
//         message = e.message ?? 'The file operation was cancelled.';
//         break;
//       case 'invalid-checksum':
//         message = e.message ?? 'File checksum mismatch (corrupted file).';
//         break;
//       case 'retry-limit-exceeded':
//         message = e.message ?? 'Retry limit exceeded for upload/download.';
//         break;
//       case 'invalid-url':
//         message = 'Invalid storage reference URL.';
//         break;
//       case 'not-found':
//         message =
//             e.message ?? 'The requested resource was not found in storage.';
//         break;
//       case 'unavailable':
//         message =  'Storage service unavailable.';
//         break;
//       default:
//         message = e.message ?? 'Storage error occurred.';
//     }
//
//     return ApiResponse.error(message: message, data: {'error-code': e.code});
//   }
//
//   // ⚙️ Firebase Functions
//   static ApiResponse<dynamic> _handleFunctionsError(
//     FirebaseFunctionsException e,
//   ) {
//     final code = e.code.toLowerCase();
//     String message;
//
//     switch (code) {
//       case 'cancelled':
//         message = e.message ?? 'The function call was cancelled.';
//         break;
//       case 'unknown':
//         message = e.message ?? 'Unknown error occurred in Cloud Function.';
//         break;
//       case 'invalid-argument':
//         message = e.message ?? 'You passed an invalid value';
//         break;
//       case 'deadline-exceeded':
//         message = e.message ?? 'Cloud Function request_property timed out.';
//         break;
//       case 'not-found':
//         message = e.message ?? 'Requested Cloud Function not found.';
//         break;
//       case 'already-exists':
//         message = e.message ?? 'The resource already exists.';
//         break;
//       case 'permission-denied':
//         message = 'You are not authorized to call this service';
//         break;
//       case 'resource-exhausted':
//         message = e.message ?? 'Cloud Function quota or rate limit exceeded.';
//         break;
//       case 'failed-precondition':
//         message = e.message ?? 'Function cannot run in current state.';
//         break;
//       case 'INSUFFICIENT':
//         message = e.message ?? 'Insufficient balance';
//         break;
//       case 'Invalid email':
//         message =  'Invalid email. Email does not exist';
//         break;
//       case 'aborted':
//         message = 'Cloud Function aborted the request_property.';
//         break;
//       case 'out-of-range':
//         message = 'Received an out-of-range argument.';
//         break;
//       case 'unimplemented':
//         message = 'Unimplemented  yet.';
//         break;
//       case 'internal':
//         message = 'Internal server error.';
//         break;
//       case 'unavailable':
//         message = 'Server service unavailable (please check internet).';
//         break;
//       case 'data-loss':
//         message = e.message ?? 'Data loss or corruption in server.';
//         break;
//       case 'unauthenticated':
//         message = 'User session expired please login again';
//         break;
//       default:
//         message = e.message ?? 'Cloud Function error occurred.';
//     }
//
//     // If the function returns structured details (Map), include them in data
//     return ApiResponse.error(
//       message: message,
//       data: {'error-code': e.code, if (e.details != null) 'details': e.details},
//     );
//   }
// }
