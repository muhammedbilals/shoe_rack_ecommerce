import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';

class EditScreenTextField extends StatelessWidget {
  final IconData? icon;
  final String hinttext;
  final TextEditingController? controller;

  const EditScreenTextField(
      {super.key, this.icon, required this.hinttext, this.controller});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 50,
        width: size.width * 0.7,
        decoration: BoxDecoration(
            // border: Border(
            //   bottom: BorderSide(width: 3, color: colorgreen),
            // ),
            // boxShadow: [
            //   BoxShadow(blurRadius: 25),
            // ],
            color: colorgray,
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            // Padding(
            //   padding: EdgeInsets.all(9.0),
            //   child: Icon(
            //     icon,
            //     size: 20,
            //   ),
            // ),
            SizedBox(
              height: 50,
              width: 350,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration.collapsed(
                        hintText: hinttext,
                        hintStyle: const TextStyle(fontSize: 19)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
