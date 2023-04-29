import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';

class CustomButton extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color? color;
  final Color? buttonandtextcolor;

  const CustomButton(
      {super.key,
      this.icon,
      required this.text,
      this.color,
      this.buttonandtextcolor});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        width: size.width * 0.9,
        height: 60,
        child: ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(
                  color != null ? color! : colorgreen),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            icon,
            size: 25,
            color: buttonandtextcolor != null ? buttonandtextcolor : colorwhite,
          ),
          label: Text(
            text,
            style: TextStyle(fontSize: 22, color: buttonandtextcolor != null ? buttonandtextcolor : colorwhite),
          ),
        ),
      ),
    );
  }
}
