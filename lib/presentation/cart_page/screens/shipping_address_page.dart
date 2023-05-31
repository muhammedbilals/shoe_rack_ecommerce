import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/model/address_functions.dart';
import 'package:shoe_rack_ecommerce/model/address_model.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/screens/add_new_adress_page.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/screens/adress_page.dart';

class ShippingAdressPage extends StatefulWidget {
   const ShippingAdressPage({super.key});

  @override
  State<ShippingAdressPage> createState() => _ShippingAdressPageState();
}

class _ShippingAdressPageState extends State<ShippingAdressPage> {
  List<Address> adress = [];

  void getAddress() async {
    adress = await displayAddress();
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
              children: [
                sbox,
                Column(
                    children: List.generate(
                  adress.length,
                  (index) => Column(
                    children: [
                      Container(
                        width: size.width * 0.9,
                        height: size.width * 0.25,
                        decoration: BoxDecoration(
                            color: colorgray,
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: ListTile(
                              leading: Container(
                                width: size.width * 0.15,
                                height: size.width * 0.25,
                                decoration: BoxDecoration(
                                    color: colorgreen, shape: BoxShape.circle),
                                child:
                                    const Icon(CustomIcon.locationiconfluttter),
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
                                      style: const TextStyle(fontSize: 19),
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
                              trailing: ValueListenableBuilder(
                                valueListenable: selectedAddressNotifier,
                                builder:
                                    (context, selectedAddressIndex, child) =>
                                        Radio(
                                  fillColor: MaterialStatePropertyAll<Color>(
                                      colorgreen),
                                  value: selectedAddressIndex == index,
                                  groupValue: true,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedAddressIndex = index;
                                      selectedAddressNotifier.value = index;
                                    });
                                    updateDefaultValue(
                                        adress[index].id.toString());
                                  },
                                ),
                              )),
                        ),
                      ),
                      sbox,
                    ],
                  ),
                )),
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
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
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
            )
          ],
        ),
      ),
    );
  }
}
