// ignore_for_file: body_might_complete_normally_catch_error

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ignore: unused_import
import 'package:shoe_rack_ecommerce/core/utils/utils.dart';
import 'package:shoe_rack_ecommerce/main.dart';

Future<void> googleSignIn() async {
  final googleSignIn = GoogleSignIn();

  final googleUser = await googleSignIn.signIn().catchError((onError) {
  });
  if (googleUser == null) return;

  final googleAuth = await googleUser.authentication;
  final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  await FirebaseAuth.instance.signInWithCredential(credential);
  navigatorKey.currentState!.popUntil((route) => route.isFirst);

  //there might be platform execption thrown when cancelling the flow ,it fixes itself when running in production
}
