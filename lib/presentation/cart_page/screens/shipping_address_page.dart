import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/screens/payments_screen.dart';
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
          child: AppBarWidget(title: 'Payment Methods'),
        ),
        body: Stack(
          children: [
            ListView(
              physics: BouncingScrollPhysics(),
              // mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                sbox,
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Text(
                      'Choose a Payment Method',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                sbox,
                sbox,
                const AdressRadioButtonWidget(),
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
                    height: 60,
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
