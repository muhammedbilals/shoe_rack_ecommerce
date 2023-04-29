import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/AdressRadiobutton.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';
import 'package:shoe_rack_ecommerce/presentation/login_or_signup/widgets/mainbutton.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: 'Address'),
        ),
        body: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sbox,
                // const Align(
                //   alignment: Alignment.centerLeft,
                //   child: Padding(
                //     padding: EdgeInsets.only(left: 25.0),
                //     child: Text(
                //       'Choose a Payment Method',
                //       style: TextStyle(fontSize: 20),
                //     ),
                //   ),
                // ),
                sbox,
                sbox,
                const AdressRadioButtonWidget(),
                sbox,
                sbox,
                CustomButton(
                  text: 'Add New Address',
                  icon: CustomIcon.locationiconfluttter,
                  buttonandtextcolor: colorblack,
                  color: colorgray,
                )
              ],
            ),
            const Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: CustomButton(
                text: 'Confirm',
                icon: CustomIcon.ticksquareiconfluttter,
              ),
            )
          ],
        ),
      ),
    );
  }
}
