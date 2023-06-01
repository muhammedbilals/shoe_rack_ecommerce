import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';

// ignore: must_be_immutable
class ProductsTextField extends StatelessWidget {
  ProductsTextField({
    super.key,
    required this.title,
    required this.controller,
    this.isNumberPad,
  });

  final String title;
  final TextEditingController? controller;

  bool? isNumberPad = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width * 0.9,
              height: size.width * 0.13,
              decoration: BoxDecoration(
                  border: Border.all(color: colorgreen),
                  borderRadius: BorderRadius.circular(20),
                  color: colorgray),
              child: Row(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  //   child: Icon(
                  //     icon,
                  //     color: colorblack.withOpacity(0.5),
                  //   ),
                  // ),
                  SizedBox(
                    height: 30,
                    width: 280,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: controller,
                          focusNode: FocusNode(canRequestFocus: true),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: validator,
                          // controller: controller,
                          keyboardType:
                              isNumberPad == true ? TextInputType.number : null,
                          cursorColor: colorgreen,
                          // cursorHeight: 20,
                          decoration: InputDecoration.collapsed(
                              hintText: title,
                              hintStyle: TextStyle(fontSize: 20)),
                        ),
                      ),
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  //   child: trailing != null
                  //       ? Icon(
                  //           trailing,
                  //           color: colorblack.withOpacity(0.5),
                  //         )
                  //       : null,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
