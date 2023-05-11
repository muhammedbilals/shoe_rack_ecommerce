import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/core/utils/utils.dart';
import 'package:shoe_rack_ecommerce/main.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/functions/singinfunction.dart';
import 'package:shoe_rack_ecommerce/presentation/login_page/screens/login_screen.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/main_pages.dart';
import 'package:shoe_rack_ecommerce/presentation/sign_in_page/widgets/textfieldsignup.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    Future<void> signUp() async {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;
      // if (EmailValidator.validate(emailController.text) &&
      //     passwordController.text.trim().length >= 8) {
      showDialog(
        context: context,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        User currentuser = FirebaseAuth.instance.currentUser!;
        currentuser.updateDisplayName(nameController.text);
     
      } on FirebaseAuthException catch (e) {
        print(e);
        utils.showSnackbar(e.message);
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      // } else {
      //   return false;
      // }
      return;
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                const Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                sbox,
                sbox,
                TextFieldSignUp(
                    controller: nameController,
                    icon: CustomIcon.edit_1icon,
                    title: 'Name'),
                // sbox,
                // TextFieldSignUp(
                //     icon: CustomIcon.callicon,
                //     title: 'Phone Number',
                //     isNumberPad: true),
                sbox,
                TextFieldSignUp(
                    selection: 1,
                    controller: emailController,
                    icon: CustomIcon.sms_2icon,
                    title: 'Email'),
                sbox,
                TextFieldSignUp(
                    // validator: ,
                    passwordVisible: true,
                    controller: passwordController,
                    icon: CustomIcon.password_2icon,
                    title: 'Password',
                    trailing1: CustomIcon.hideiconfluttter,
                    trailing2: CustomIcon.hideiconfluttter),
                sbox,
                sbox,
                // SignUpButton(size: size, color: colorgreen, text: 'SignUp',widget: MainPage()),
                InkWell(
                  onTap: () {
                    signUp();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MainPage(),
                    //     ));
                  },
                  child: Container(
                    width: size.width * 0.9,
                    height: size.width * 0.13,
                    decoration: BoxDecoration(
                        border: Border.all(color: colorgreen),
                        borderRadius: BorderRadius.circular(20),
                        color: colorgreen),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'SignUp',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                sbox,
                Center(
                  child: SizedBox(
                    width: size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width * 0.3,
                            height: 1,
                            color: colorgreen,
                          ),
                          const Text('or Sign up with'),
                          Container(
                            width: size.width * 0.3,
                            height: 1,
                            color: colorgreen,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                sbox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        googleSignIn();
                      },
                      child: SizedBox(
                        width: 40,
                        child: Image.network(
                            'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png'),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: 40,
                      child: Image.network(
                          'https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png'),
                    ),
                  ],
                ),
                sbox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: TextStyle(color: colorblack.withOpacity(0.5)),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                      child: const Text(
                        "Sign In",
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
