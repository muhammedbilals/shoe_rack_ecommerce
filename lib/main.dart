import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_rack_ecommerce/core/utils/utils.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/sudo_page.dart';
import 'package:shoe_rack_ecommerce/presentation/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: utils.messengerKey,
      navigatorKey: navigatorKey,
      title: 'ShoeRack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily:
            GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
