// // import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../features/rider/bloc/data_model/rider_model.dart';
// // import your RiderModel path
//
// // class AuthService {
// //   final FirebaseAuth _auth = FirebaseAuth.instance;
// //   final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
// //
// //   // Use the singleton instance
// //   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
// //
// //   Future<UserCredential?> signInWithGoogle() async {
// //     try {
// //       // 1. Initialize the GoogleSignIn instance
// //       await _googleSignIn.initialize(
// //         // optionally: clientId: ..., serverClientId: ..., scopes: [...]
// //       );
// //
// //       // 2. Start the authentication flow
// //       final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();
// //       if (googleUser == null) {
// //         // User cancelled or no account selected
// //         return null;
// //       }
// //
// //       // 3. Get authentication details
// //       final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
// //
// //       // 4. Create Firebase credential
// //       final credential = GoogleAuthProvider.credential(
// //         idToken:     googleAuth.idToken,
// //       );
// //
// //       // 5. Firebase sign‑in
// //       final userCredential = await _auth.signInWithCredential(credential);
// //       final user = userCredential.user;
// //
// //       if (user != null) {
// //         // 6. Firestore user doc logic (you already implemented)
// //         final userDoc = _fireStore.collection('riders').doc(user.uid);
// //         final docSnapshot = await userDoc.get();
// //
// //         if (!docSnapshot.exists) {
// //           // First‑time sign‑in → create profile
// //           final rider = RiderModel(
// //             riderId:       user.uid,
// //             company:       null,
// //             riderFullName: user.displayName,
// //             email:         user.email?.toLowerCase(),
// //             riderPhone:    user.phoneNumber,
// //             riderAddress:  null,
// //             riderDob:      null,
// //             riderStatus:   "Active",
// //             password:      null,
// //             isActive:      true,
// //             riderImage:    user.photoURL,
// //             createdDate:   DateTime.now(),
// //             emailVerified: user.emailVerified,
// //             riderSubscribed:false,
// //             latitude:      null,
// //             longitude:     null,
// //           );
// //
// //           await userDoc.set(rider.toJson());
// //         } else {
// //           // Existing user — update last login
// //           await userDoc.update({
// //             'lastLogin': FieldValue.serverTimestamp(),
// //           });
// //         }
// //       }
// //
// //       return userCredential;
// //     } catch (e) {
// //       print('Google sign‑in error: $e');
// //       rethrow;
// //     }
// //   }
// // }
