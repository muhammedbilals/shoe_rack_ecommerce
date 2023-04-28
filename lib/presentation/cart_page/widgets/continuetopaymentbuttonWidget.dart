
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

class ContinueToPaymentButtonWidget extends StatelessWidget {
  const ContinueToPaymentButtonWidget({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Center(
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
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => CheckoutScreen(),
            //     ));
          },
          icon: Icon(
            CustomIcon.walleticonfluttter,
            size: 25,
            color: colorwhite,
          ),
          label: Text(
            'Continue to Payment',
            style: TextStyle(fontSize: 22, color: colorwhite),
          ),
        ),
      ),
    );
  }
}
