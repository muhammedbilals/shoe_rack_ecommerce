import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/widgets/edit_screen_textfield.dart';

class EditProfile extends StatelessWidget {
   EditProfile({super.key});
  final namecontroller = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: 'Edit Profile'),
        ),
        body: Stack(
          children: [
            ListView(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                        color: colorgray),
                  ),
                ),
                sbox,
                sbox,
                EditScreenTextField(hinttext: 'Name',controller:namecontroller),
                sbox,
                EditScreenTextField(hinttext: 'Phone Number'),
                sbox,
                EditScreenTextField(hinttext: 'Email'),
                sbox,
              ],
            ),
            Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: CustomButton(
                  
                  text: 'Update',
                  icon: CustomIcon.tickcircleiconfluttter,
               
                ))
          ],
        ),
      ),
    );
  }
}
