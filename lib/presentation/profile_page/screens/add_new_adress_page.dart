import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/model/address_functions.dart';
import 'package:shoe_rack_ecommerce/model/address_model.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/widgets/productsTextfield.dart';

// ignore: must_be_immutable
class AddNewAddressPage extends StatelessWidget {
  AddNewAddressPage({super.key});
  final namecontroller = TextEditingController();
  final phoneNumbercontroller = TextEditingController();
  final pincodecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final housenamecontroller = TextEditingController();
  final roadnamecontroller = TextEditingController();
  List<String> nameList = <String>['Home', 'Work', 'Apartment'];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String dropdownNameValue = nameList.first;

    return SafeArea(
      child: Stack(children: [
        Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBarWidget(leadingIcon: true, title: 'New Address'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                StatefulBuilder(
                  builder: (context, setState) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: size.width * 0.9,
                        height: size.width * 0.13,
                        decoration: BoxDecoration(
                            border: Border.all(color: colorgreen),
                            borderRadius: BorderRadius.circular(20),
                            color: colorwhite),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownNameValue,
                              icon: const Icon(Icons.arrow_downward_sharp),
                              elevation: 8,
                              style: const TextStyle(color: Colors.black),
                              disabledHint: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                              onChanged: (String? value) {
                                // This is called when the user selects an item.
                                setState(() {
                                  dropdownNameValue = value!;
                                });
                              },
                              items: nameList.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ProductsTextField(
                  title: 'Name',
                  controller: namecontroller,
                ),
                ProductsTextField(
                  isNumberPad: true,
                  title: 'Phone Number',
                  controller: phoneNumbercontroller,
                ),
                ProductsTextField(
                  title: 'House No. , Building Name',
                  controller: housenamecontroller,
                ),
                ProductsTextField(
                  title: 'Road Name,Area,Colony',
                  controller: roadnamecontroller,
                ),
                ProductsTextField(
                  isNumberPad: true,
                  title: 'Pincode',
                  controller: pincodecontroller,
                ),
                ProductsTextField(
                  title: 'City',
                  controller: citycontroller,
                ),
                ProductsTextField(
                  title: 'State',
                  controller: statecontroller,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: size.width * 0.9,
                  height: 60,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(colorgreen),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ))),
                    onPressed: () async {
                      final addressRef = FirebaseFirestore.instance
                          .collection('users')
                          .doc(userID)
                          .collection('address');
                      final id = addressRef.doc();

                      addNewAddress(Address(
                          id: id.id,
                          addressType: dropdownNameValue,
                          name: namecontroller.text,
                          phoneNumber: int.parse(phoneNumbercontroller.text),
                          houseName: housenamecontroller.text,
                          roadName: roadnamecontroller.text,
                          pinCode: int.parse(pincodecontroller.text),
                          city: citycontroller.text,
                          state: statecontroller.text));
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Add new Address',
                      style: TextStyle(fontSize: 18, color: colorwhite),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
