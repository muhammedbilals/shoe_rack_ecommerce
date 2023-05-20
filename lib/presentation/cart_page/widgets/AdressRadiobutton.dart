import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/model/address_functions.dart';
import 'package:shoe_rack_ecommerce/model/address_model.dart';

class AdressRadioButtonWidget extends StatefulWidget {
  const AdressRadioButtonWidget({super.key});

  @override
  State<AdressRadioButtonWidget> createState() =>
      _AdressRadioButtonWidgetState();
}

class _AdressRadioButtonWidgetState extends State<AdressRadioButtonWidget> {
  int selectedAddressIndex = 0;
  List<Address> adress = [];

  void getAddress() async {
    adress = await DisplayAddress();
    setState(() {
      adress = adress;
    });
  }

  @override
  void initState() {
    getAddress();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
        children: List.generate(
      adress.length,
      (index) => Column(
        children: [
          Container(
            width: size.width * 0.9,
            height: size.width * 0.25,
            decoration: BoxDecoration(
                color: colorgray, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: ListTile(
                leading: Container(
                  width: size.width * 0.15,
                  height: size.width * 0.25,
                  decoration:
                      BoxDecoration(color: colorgreen, shape: BoxShape.circle),
                  child: const Icon(CustomIcon.locationiconfluttter),
                ),
                title: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sbox,
                      sbox,
                      Text(
                        adress[index].addressType,
                        style: TextStyle(fontSize: 19),
                      ),
                      Text(
                        "${adress[index].houseName},${adress[index].pinCode.toString()},${adress[index].city}",
                        // 'Rose avenue,695600,Kerala',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                            color: colorblack.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
                trailing: Radio(
                  fillColor: MaterialStatePropertyAll<Color>(colorgreen),
                  value: selectedAddressIndex == index,
                  groupValue: true,
                  onChanged: (value) {
                    setState(() {
                      selectedAddressIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
          sbox,
        ],
      ),
    ));
  }
}
