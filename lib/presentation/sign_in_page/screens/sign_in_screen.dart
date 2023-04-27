import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/sign_in_page/widgets/signupbutton.dart';
import 'package:shoe_rack_ecommerce/presentation/sign_in_page/widgets/textfieldsignup.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
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
              TextFieldSignUp(icon: CustomIcon.edit_1icon, title: 'Name'),
              sbox,
              TextFieldSignUp(
                  icon: CustomIcon.callicon,
                  title: 'Phone Number',
                  isNumberPad: true),
              sbox,
              TextFieldSignUp(icon: CustomIcon.sms_2icon, title: 'Email'),
              sbox,
              TextFieldSignUp(
                  icon: CustomIcon.password_2icon,
                  title: 'Password',
                  trailing: CustomIcon.hideiconfluttter),
              sbox,
              sbox,
              SignUpButton(size: size, color: colorgreen, text: 'SignUp')
            ],
          ),
        ),
      ),
    );
  }
}
