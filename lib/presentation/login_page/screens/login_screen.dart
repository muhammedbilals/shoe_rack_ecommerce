import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/main_pages.dart';
import 'package:shoe_rack_ecommerce/presentation/sign_in_page/screens/sign_up_screen.dart';
import 'package:shoe_rack_ecommerce/presentation/sign_in_page/widgets/signupbutton.dart';
import 'package:shoe_rack_ecommerce/presentation/sign_in_page/widgets/textfieldsignup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              const Center(
                child: Text(
                  'Login to Account',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              sbox,
              sbox,
              SizedBox(
                height: 100,
              ),
              TextFieldSignUp(icon: CustomIcon.sms_2icon, title: 'Email'),
              sbox,
              TextFieldSignUp(
                  icon: CustomIcon.password_2icon,
                  title: 'Password',
                  trailing: CustomIcon.hideiconfluttter),
              sbox,
              sbox,
              SignUpButton(
                size: size,
                color: colorgreen,
                text: 'Log In',
                widget: MainPage(),
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
                        const Text('or Continue with'),
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
                  SizedBox(
                    width: 40,
                    child: Image.network(
                        'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png'),
                  ),
                  SizedBox(
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
                            builder: (context) => SignUpScreen(),
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
    );
  }
}
