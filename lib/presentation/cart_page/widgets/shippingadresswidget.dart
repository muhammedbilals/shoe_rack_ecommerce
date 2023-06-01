import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/model/order_functions.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/screens/shipping_address_page.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/screens/add_new_adress_page.dart';

class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<QuerySnapshot>(
      future: getAddressId(),
      builder: (context, addressSnapshot) {
        // Address? addressname;
        if (addressSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (addressSnapshot.hasError) {
          return Text('Error: ${addressSnapshot.error}');
        }
        // if (!addressSnapshot.hasData) {
        //   return CustomButton(
        //       text: 'Add New Address',
        //       icon: CustomIcon.locationiconfluttter,
        //       buttonandtextcolor: colorblack,
        //       color: colorgray,
        //       widget: AddNewAddressPage());
        // }
        if (addressSnapshot.hasData && addressSnapshot.data!.docs.isNotEmpty) {
          final addressData =
              addressSnapshot.data!.docs.first.data() as Map<String, dynamic>;
          return Center(
            child: Container(
              width: size.width * 0.9,
              height: size.width * 0.2,
              decoration: BoxDecoration(
                color: colorgray,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: size.width * 0.15,
                      height: size.width * 0.2,
                      decoration: BoxDecoration(
                          color: colorgreen, shape: BoxShape.circle),
                      child: const Icon(CustomIcon.locationiconfluttter),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          addressData['addressType'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${addressData['houseName']},${addressData['city']}',
                          style: TextStyle(
                            fontSize: 15,
                            color: colorblack.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: IconButton(
                      icon: const Icon(CustomIcon.edit_squareiconfluttter),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShippingAdressPage(),
                            ));
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return CustomButton(
            text: 'Add New Address',
            icon: CustomIcon.locationiconfluttter,
            buttonandtextcolor: colorblack,
            color: colorgray,
            widget: AddNewAddressPage());
      },
    );
  }
}
