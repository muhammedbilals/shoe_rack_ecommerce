import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

class ShippingAddressWidget extends StatelessWidget {
  const ShippingAddressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * 0.9,
        height: size.width * 0.2,
        decoration: BoxDecoration(
            color: colorgray, borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width * 0.15,
                height: size.width * 0.2,
                decoration:
                    BoxDecoration(color: colorgreen, shape: BoxShape.circle),
                child: const Icon(CustomIcon.locationiconfluttter),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Home',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Rose avenue,695600,Kerala',
                      style: TextStyle(
                          fontSize: 15, color: colorblack.withOpacity(0.5))),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                icon: const Icon(CustomIcon.edit_squareiconfluttter),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
