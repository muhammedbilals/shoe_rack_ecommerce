import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/model/address_functions.dart';
import 'package:shoe_rack_ecommerce/model/address_model.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/screens/add_new_adress_page.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

ValueNotifier<int> selectedAddressNotifier = ValueNotifier(0);

class _AddressScreenState extends State<AddressScreen> {
  List<Address> adress = [];
  final addressRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('address');
  void getAddress() async {
    adress = await displayAddress();
    setState(
      () {
        adress = adress;
      },
    );
  }

  getRadioIndex() {
    addressRef.get().then(
      (QuerySnapshot querysnapshot) {
        final docs = querysnapshot.docs;
        for (int i = 0; i < docs.length; i++) {
          final boolvalue = docs[i]['isDefault'];
          if (boolvalue) {
            selectedAddressNotifier.value = i;
          } else {
            break;
          }
        }
      },
    );
  }

  @override
  void initState() {
    getAddress();
    getRadioIndex();
    super.initState();
  }

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
                Column(
                  children: List.generate(
                    adress.length,
                    (index) => adress.isNotEmpty
                        ? Column(
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
                                          color: colorgreen,
                                          shape: BoxShape.circle),
                                      child: const Icon(
                                          CustomIcon.locationiconfluttter),
                                    ),
                                    title: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          sbox,
                                          sbox,
                                          Text(
                                            adress[index].addressType,
                                            style:
                                                const TextStyle(fontSize: 19),
                                          ),
                                          Text(
                                            "${adress[index].houseName},${adress[index].pinCode.toString()},${adress[index].city}",
                                            // 'Rose avenue,695600,Kerala',
                                            style: TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                                fontSize: 15,
                                                color: colorblack
                                                    .withOpacity(0.5)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: ValueListenableBuilder(
                                      valueListenable: selectedAddressNotifier,
                                      builder: (context, selectedAddressIndex,
                                              child) =>
                                          Radio(
                                        fillColor:
                                            MaterialStatePropertyAll<Color>(
                                                colorgreen),
                                        value: selectedAddressIndex == index,
                                        groupValue: true,
                                        onChanged: (value) {
                                          setState(() {
                                            selectedAddressIndex = index;
                                            selectedAddressNotifier.value =
                                                index;
                                          });
                                          updateDefaultValue(
                                              adress[index].id.toString());
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              sbox,
                            ],
                          )
                        : SizedBox(
                            height: size.height * 0.7,
                            child: const Center(
                              child: Text('No adress found'),
                            ),
                          ),
                  ),
                ),
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
                    // function:(),
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
