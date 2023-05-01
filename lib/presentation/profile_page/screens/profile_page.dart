import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/login_or_signup/screens/login_or_signup_page.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/screens/adress_page.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/screens/edit_profile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List<IconData> icons = [
    CustomIcon.profile_1iconfluttter,
    CustomIcon.locationiconfluttter,
    CustomIcon.notificationiconfluttter,
    CustomIcon.mooniconfluttter,
    CustomIcon.shieldiconfluttter,
    CustomIcon.document_align_left_5iconfluttter,
    CustomIcon.logouticonfluttter,
  ];
  final List<String> title = [
    'Edit Profile',
    'Address',
    'Notification',
    'Dark Mode',
    'Privacy Policy',
    'Terms & Conditions',
    'Log Out',
  ];
  final List<Widget> widget = [
    EditProfile(),
    AddressScreen(),
    EditProfile(),
    EditProfile(),
    EditProfile(),
    EditProfile(),
    EditProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBarWidget(title: 'Profile'),
        ),
        body: Column(
          children: [
            Center(
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80), color: colorgray),
              ),
            ),
             Center(
              child: Text(
                user!.displayName??
                'Name',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Text(
              user.email ?? 'Email',
              style:
                  TextStyle(fontSize: 20, color: colorblack.withOpacity(0.5)),
            ),
            const Divider(
              indent: 20,
              endIndent: 20,
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: index != 6
                        ? Icon(
                            icons[index],
                            color: colorblack,
                          )
                        : Icon(icons[index], color: Colors.red),
                    title: index != 6
                        ? Text(title[index])
                        : Text(
                            title[index],
                            style: const TextStyle(color: Colors.red),
                          ),
                    trailing: index != 6
                        ? Icon(
                            CustomIcon.righticonfluttter,
                            color: colorblack,
                          )
                        : null,
                    onTap: index != 6
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => widget[index],
                                ));
                          }
                        : () {
                            showModalBottomSheet<void>(
                              // transitionAnimationController: AnimationController(vsync: TickerProvider),
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: BoxDecoration(
                                      color: colorwhite,
                                      borderRadius: BorderRadius.circular(20)),
                                  height: 200,
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      // mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        sbox,
                                        const Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Text(
                                            'Log Out',
                                            style: TextStyle(fontSize: 22),
                                          ),
                                        ),
                                        const Divider(
                                          endIndent: 30,
                                          indent: 30,
                                        ),
                                        sbox,
                                        const Text(
                                          'Are you sure?',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        sbox,
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: size.width * 0.43,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll<
                                                                    Color>(
                                                                colorgray),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                        ))),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: colorblack),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SizedBox(
                                                  width: size.width * 0.43,
                                                  height: 50,
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll<
                                                                    Color>(
                                                                colorgreen),
                                                        shape: MaterialStateProperty.all<
                                                                RoundedRectangleBorder>(
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      18.0),
                                                        ))),
                                                    onPressed: () {
                                                      FirebaseAuth.instance
                                                          .signOut();
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                LoginOrSignUp(),
                                                          ));
                                                    },
                                                    child: Text(
                                                      'Confirm',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: colorwhite),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          });
              },
            )
          ],
        ),
      ),
    );
  }
}
