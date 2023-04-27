import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/sign_in_page/sign_in_screen.dart';

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
          SizedBox(
            height: 200,
          ),
          MainButton(
              text: 'Continue with Google',
              iconurl:
                  'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png',
              color: colorwhite),
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
                  "Sign In",
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

class MainButton extends StatelessWidget {
  final String text;
  final String iconurl;
  final Color color;
  final bool networkOrAsset = true;
  final Color? fontcolor;

  const MainButton(
      {super.key,
      required this.text,
      this.fontcolor,
      required this.iconurl,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      hoverColor: colorgray,
      child: Container(
        width: size.width * 0.9,
        height: size.width * 0.13,
        decoration: BoxDecoration(
            border: Border.all(color: colorgreen),
            borderRadius: BorderRadius.circular(20),
            color: color),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 30,
                  child: networkOrAsset
                      ? Image.network(iconurl)
                      : Image.asset(iconurl)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
