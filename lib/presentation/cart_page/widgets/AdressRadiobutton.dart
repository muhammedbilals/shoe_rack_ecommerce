import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

class AdressRadioButtonWidget extends StatefulWidget {
  const AdressRadioButtonWidget({super.key});

  @override
  State<AdressRadioButtonWidget> createState() =>
      _AdressRadioButtonWidgetState();
}

// enum SingingCharacter {  home, office ,apartment}
enum SingingCharacter { lafayette, jefferson, apartment }

class _AdressRadioButtonWidgetState extends State<AdressRadioButtonWidget> {
  SingingCharacter? _character = SingingCharacter.lafayette;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          width: size.width * 0.9,
          height: size.width * 0.25,
          decoration: BoxDecoration(
              color: colorgray, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: ListTile(
              leading: Container(
                width: size.width * 0.15,
                height: size.width * 0.25,
                decoration:
                    BoxDecoration(color: colorgreen, shape: BoxShape.circle),
                child: const Icon(CustomIcon.locationiconfluttter),
              ),
              title: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sbox,
                    const Text(
                      'Home',
                      style: TextStyle(fontSize: 19),
                    ),
                    Text(
                      'Rose avenue,695600,Kerala',
                      style: TextStyle(
                          fontSize: 15, color: colorblack.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              trailing: Radio<SingingCharacter>(
                fillColor: MaterialStatePropertyAll<Color>(colorgreen),
                value: SingingCharacter.lafayette,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ),
        ),
        sbox,
        Container(
          width: size.width * 0.9,
          height: size.width * 0.25,
          decoration: BoxDecoration(
              color: colorgray, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: ListTile(
              leading: Container(
                width: size.width * 0.15,
                height: size.width * 0.2,
                decoration:
                    BoxDecoration(color: colorgreen, shape: BoxShape.circle),
                child: const Icon(CustomIcon.locationiconfluttter),
              ),
              title: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sbox,
                    const Text(
                      'Office',
                      style: TextStyle(fontSize: 19),
                    ),
                    Text(
                      'Rose avenue,695600,Kerala',
                      style: TextStyle(
                          fontSize: 15, color: colorblack.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              trailing: Radio<SingingCharacter>(
                fillColor: MaterialStatePropertyAll<Color>(colorgreen),
                value: SingingCharacter.jefferson,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ),
        ),
        sbox,
        Container(
          width: size.width * 0.9,
          height: size.width * 0.25,
          decoration: BoxDecoration(
              color: colorgray, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: ListTile(
              leading: Container(
                width: size.width * 0.15,
                height: size.width * 0.2,
                decoration:
                    BoxDecoration(color: colorgreen, shape: BoxShape.circle),
                child: const Icon(CustomIcon.locationiconfluttter),
              ),
              title: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    sbox,
                    const Text(
                      'Apartment',
                      style: TextStyle(fontSize: 19),
                    ),
                    Text(
                      'Rose avenue,695600,Kerala',
                      style: TextStyle(
                          fontSize: 15, color: colorblack.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              trailing: Radio<SingingCharacter>(
                fillColor: MaterialStatePropertyAll<Color>(colorgreen),
                value: SingingCharacter.apartment,
                groupValue: _character,
                onChanged: (SingingCharacter? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ),
        ),
        // ListTile(
        //   title: const Text('Thomas Jefferson'),
        //   trailing: Radio<SingingCharacter>(
        //     value: SingingCharacter.jefferson,
        //     groupValue: _character,
        //     onChanged: (SingingCharacter? value) {
        //       setState(() {
        //         _character = value;
        //       });
        //     },
        //   ),
        // ),
      ],
    );
    // return Column(
    //   children: <Widget>[
    //     ListTile(
    //       title: const Text('Lafayette'),
    //       trailing: Radio<SingingCharacter>(
    //         value: SingingCharacter.lafayette,
    //         groupValue: _character,
    //         onChanged: (SingingCharacter? value) {
    //           setState(() {
    //             _character = value;
    //           });
    //         },
    //       ),
    //     ),
    //     ListTile(
    //       title: const Text('Thomas Jefferson'),
    //       trailing: Radio<SingingCharacter>(
    //         value: SingingCharacter.jefferson,
    //         groupValue: _character,
    //         onChanged: (SingingCharacter? value) {
    //           setState(() {
    //             _character = value;
    //           });
    //         },
    //       ),
    //     ),
    //     ListTile(
    //       title: const Text('Apartment'),
    //       trailing: Radio<SingingCharacter>(
    //         value: SingingCharacter.apartment,
    //         groupValue: _character,
    //         onChanged: (SingingCharacter? value) {
    //           setState(() {
    //             _character = value;
    //           });
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }
}
