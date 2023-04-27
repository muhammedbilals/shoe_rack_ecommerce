import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
    required this.size,
    required this.color,
    required this.text,
  });

  final Size size;
  final Color color;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.9,
      height: size.width * 0.13,
      decoration: BoxDecoration(
          border: Border.all(color: colorgreen),
          borderRadius: BorderRadius.circular(20),
          color: color),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
