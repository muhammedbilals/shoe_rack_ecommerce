import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';

class MainButton extends StatelessWidget {
  final String text;
  final String iconurl;
  final Color color;
  final bool networkOrAsset = true;
  final Color? fontcolor;
  final Widget? widget;

  const MainButton(
      {super.key,
      required this.text,
      this.fontcolor,
      required this.iconurl,
      this.widget,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: widget!=null? () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget!,
            ));
      }:null,
      hoverColor: colorgray,
      child: Container(
        width: size.width * 0.9,
        height: size.width * 0.13,
        decoration: BoxDecoration(
            border: Border.all(color: colorgreen),
            borderRadius: BorderRadius.circular(20),
            color: color),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 30,
                  child: networkOrAsset
                      ? Image.network(iconurl)
                      : Image.asset(iconurl)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
