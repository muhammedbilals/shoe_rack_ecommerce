import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final Icon? icons;
  final bool? leadingIcon;
  const AppBarWidget({super.key, required this.title, this.icons, this.leadingIcon});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon:leadingIcon==true? const Icon(
              CustomIcon.lefticonfluttter,
              size: 30,
            ):SizedBox(
              width: size.width*0.1,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const Spacer(),
          Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const Spacer(),
          icons != null
              ? IconButton(
                  icon: icons!,
                  onPressed: () {},
                )
              : SizedBox(
                  width: size.width * 0.1,
                )
        ],
      ),
    );
  }
}
