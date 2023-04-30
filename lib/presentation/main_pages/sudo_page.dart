import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/screens/home_page.dart';
import 'package:shoe_rack_ecommerce/presentation/login_or_signup/screens/login_or_signup_page.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/main_pages.dart';

class SudoPage extends StatelessWidget {
  const SudoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
           return SnackBar(content: Text('something went wrong'));
          } else if (snapshot.hasData) {
            return MainPage();
          } else {
            return LoginOrSignUp();
          }
        },
      ),
    );
  }
}
