import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';

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

  @override
  Widget build(BuildContext context) {
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
            const Center(
              child: Text(
                'Muhammed Bilal S',
                style: TextStyle(fontSize: 25),
              ),
            ),
            Text(
              '+91 9497705305',
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
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
