import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/model/address_functions.dart';
import 'package:shoe_rack_ecommerce/model/address_model.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/AdressRadiobutton.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/screens/add_new_adress_page.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});
  List<Address> adress = [];
  // void getAddress() async {
  //   adress = await displayAddress();

  //   adress = adress;
  // }

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
              children: [
                sbox,
                 AdressRadioButtonWidget(selectedAddressIndex: 1),
                sbox,
                CustomButton(
                  text: 'Add New Address',
                  icon: CustomIcon.locationiconfluttter,
                  buttonandtextcolor: colorblack,
                  color: colorgray,
                  widget: AddNewAddressPage(),
                ),
              ],
            ),
            ValueListenableBuilder(
              valueListenable: selectedAddressNotifier,
              builder: (BuildContext context, int adressIndex, Widget? child) {
                return Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: CustomButton(
                    // function: defaultAddress(adressIndex),
                    text: 'Confirm',
                    icon: CustomIcon.ticksquareiconfluttter,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
