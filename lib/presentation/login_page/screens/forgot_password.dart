import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/core/utils/utils.dart';
import 'package:shoe_rack_ecommerce/main.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/sign_in_page/widgets/signupbutton.dart';
import 'package:shoe_rack_ecommerce/presentation/sign_in_page/widgets/textfieldsignup.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final Size size = MediaQuery.of(context).size;
    String? emailaddressValidator(String? email) {
      if (!EmailValidator.validate(emailController.text.trim())) {
        return 'invalid email';
      }

      return null;
    }

    Future<void> verifyEmail() async {
      final isValid = formKey.currentState!.validate();
      if (!isValid) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
      }on FirebaseAuthException catch (e) {
        print(e);
        utils.showSnackbar(e.message);
      }
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    }

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBarWidget(title: 'Forgot Password'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 250,
                  ),
                  const Center(
                    child: Text(
                      'Recive an Email to reset your password',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  sbox,
                  sbox,
                  const SizedBox(
                    height: 100,
                  ),
                  TextFieldSignUp(
                      validator: emailaddressValidator,
                      formKey: formKey,
                      selection: 1,
                      controller: emailController,
                      icon: CustomIcon.sms_2icon,
                      title: 'Email'),
                  sbox,
                  // SignUpButton(
                  //     // ontap: signIn(),
                  //     size: size,
                  //     color: colorgreen,
                  //     text: 'Log In',
                  //     widget: MainPage(),
                  //   ),
                  sbox,
                  sbox,
                  InkWell(
                    onTap: () {
                      verifyEmail();
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
                            'Reset Password',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sbox,

                  sbox,

                  sbox,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
