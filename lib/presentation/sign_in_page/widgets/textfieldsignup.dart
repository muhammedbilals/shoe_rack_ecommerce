import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

class TextFieldSignUp extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData? trailing;
   bool? isNumberPad = false;

   TextFieldSignUp(
      {super.key, required this.icon, required this.title, this.trailing,this.isNumberPad});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.9,
      height: size.width * 0.13,
      decoration: BoxDecoration(
          border: Border.all(color: colorgreen),
          borderRadius: BorderRadius.circular(20),
          color: colorwhite),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Icon(
              icon,
              color: colorblack.withOpacity(0.5),
            ),
          ),
          SizedBox(
            height: 40,
            width: 280,
            child: Center(
              child: TextField(
                
                keyboardType:isNumberPad ==true? TextInputType.number:null,
                cursorColor: colorgreen,
                // cursorHeight: 20,
                decoration: InputDecoration.collapsed(
                    hintText: title, hintStyle: TextStyle(fontSize: 20)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: trailing != null
                ? Icon(
                    trailing,
                    color: colorblack.withOpacity(0.5),
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
