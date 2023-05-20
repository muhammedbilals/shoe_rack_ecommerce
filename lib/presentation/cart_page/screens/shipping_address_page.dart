import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/AdressRadiobutton.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';

class ShippingAdressPage extends StatelessWidget {
  const ShippingAdressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: 'Shipping Address'),
        ),
        body: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sbox,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      'Choose an Address',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                sbox,
                sbox,
                 AdressRadioButtonWidget(
                  
                 ),
              ],
            ),
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Container(
                child: Center(
                  child: SizedBox(
                    width: size.width * 0.9,
                    height: size.width * 0.15,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(colorgreen),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        CustomIcon.ticksquareiconfluttter,
                        size: 25,
                        color: colorwhite,
                      ),
                      label: Text(
                        'Confirm',
                        style: TextStyle(fontSize: 22, color: colorwhite),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
