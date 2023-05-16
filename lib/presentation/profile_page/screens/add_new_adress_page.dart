import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/widgets/productsTextfield.dart';

class AddNewAddressPage extends StatelessWidget {
  AddNewAddressPage({super.key});
  final namecontroller = TextEditingController();
  final phoneNumbercontroller = TextEditingController();
  final pincodecontroller = TextEditingController();
  final citycontroller = TextEditingController();
  final statecontroller = TextEditingController();
  final housenamecontroller = TextEditingController();
  final roadnamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;


    return SafeArea(
      child: Stack(children: [
        Scaffold(
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBarWidget(
                leadingIcon: Icon(CustomIcon.lefticonfluttter),
                title: 'New Address'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                
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
