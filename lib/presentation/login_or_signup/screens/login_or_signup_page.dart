import 'package:flutter/material.dart';
import '../../../core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/functions/singinfunction.dart';
import 'package:shoe_rack_ecommerce/presentation/login_or_signup/widgets/mainbutton.dart';
import 'package:shoe_rack_ecommerce/presentation/login_page/screens/login_screen.dart';
import 'package:shoe_rack_ecommerce/presentation/sign_in_page/screens/sign_up_screen.dart';

class LoginOrSignUp extends StatelessWidget {
  const LoginOrSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
                width: 200,
                height: 200,
                child: Image.asset('asset/images/shoerackmainlogo.png')),
          ),
          const SizedBox(
            height: 200,
          ),
          // MainButton(
          //     text: 'Continue with Google',
          //     iconurl:
          //         'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png',
          //     color: colorwhite),
          InkWell(
            onTap: () {
              googleSignIn();
            },
            hoverColor: colorgray,
            child: Container(
              width: size.width * 0.9,
              height: size.width * 0.13,
              decoration: BoxDecoration(
                  border: Border.all(color: colorgreen),
                  borderRadius: BorderRadius.circular(20),
                  color: colorwhite),
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network('https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png')),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Contionue with Google',
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
            ),
          ),
          sbox,
          MainButton(
              text: 'Continue with Facebook',
              iconurl:
                  'https://www.edigitalagency.com.au/wp-content/uploads/Facebook-logo-blue-circle-large-transparent-png.png',
              color: colorwhite),
          sbox,
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
                      width: size.width * 0.4,
                      height: 1,
                      color: colorgreen,
                    ),
                    const Text('Or'),
                    Container(
                      width: size.width * 0.4,
                      height: 1,
                      color: colorgreen,
                    )
                  ],
                ),
              ),
            ),
          ),
          sbox,
          MainButton(
            text: 'Continue with Password',
            iconurl:
                'https://icons.veryicon.com/png/o/internet--web/three-body-project-icon/password-22.png',
            color: colorgreen,
            widget: LoginPage(),
          ),
          sbox,
          sbox,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have Account? ",
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
                  "Sign Up",
                ),
              ),
            ],
          )
          // MainButton(),

          // ElevatedButton.icon(
          //   style: ButtonStyle(
          //       backgroundColor: MaterialStateProperty.all(colorwhite)),
          //   onPressed: () {},
          //   icon: Icon(Icons.upload),
          //   label: Text(
          //     'Sign in with Password',
          //     style: TextStyle(color: colorblack),
          //   ),
          // )
        ],
      ),
    ));
  }
}
