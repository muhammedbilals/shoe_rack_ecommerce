import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shoe_rack_ecommerce/core/utils/utils.dart';
import 'package:shoe_rack_ecommerce/main.dart';

Future<void> googleSignIn() async {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount _user;

  final googleUser = await googleSignIn.signIn().catchError((onError) {
    print('Error----------------$onError');
  });
  if (googleUser == null) return;
  _user = googleUser;

  final googleAuth = await googleUser.authentication;
  final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  await FirebaseAuth.instance.signInWithCredential(credential);
  print("user signed iN ${credential.idToken}");
  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}
