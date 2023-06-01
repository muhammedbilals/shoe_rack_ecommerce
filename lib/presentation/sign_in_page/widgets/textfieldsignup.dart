import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';

// ignore: must_be_immutable
class TextFieldSignUp extends StatefulWidget {
  final IconData icon;
  final String title;
  final Key? formKey;
  final String? Function(String?)? validator;
  final int? selection;
  final IconData? trailing1;
  final IconData? trailing2;
  bool? isNumberPad = false;
  final TextEditingController? controller;
  bool passwordVisible = false;

  TextFieldSignUp(
      {super.key,
      this.selection,
      this.validator,
      this.formKey,
      required this.icon,
      this.controller,
      required this.title,
      this.isNumberPad,
      this.passwordVisible = false,
      this.trailing1,
      this.trailing2});

  @override
  State<TextFieldSignUp> createState() => _TextFieldSignUpState();
}



class _TextFieldSignUpState extends State<TextFieldSignUp> {
late ValueNotifier<bool> visibileNotifier = ValueNotifier(widget.passwordVisible);
  @override
  Widget build(BuildContext context) {
    // final myController = TextEditingController();
    // print(myController.text);
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
              widget.icon,
              color: colorblack.withOpacity(0.5),
            ),
          ),
          SizedBox(
            height: 40,
            width: size.width * 0.65,
            child: Center(
              child: ValueListenableBuilder(
                valueListenable: visibileNotifier,
                builder: (BuildContext context, dynamic visblebool, Widget? child) {
                  return TextFormField(
                    obscureText: visblebool,
                    focusNode: FocusNode(canRequestFocus: true),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: widget.validator,
                    controller: widget.controller,
                    keyboardType: widget.isNumberPad == true
                        ? TextInputType.number
                        : null,
                    cursorColor: colorgreen,
                    // cursorHeight: 20,
                    decoration: InputDecoration.collapsed(
                        hintText: widget.title,
                        hintStyle: const TextStyle(fontSize: 20)),
                  );
                },
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 00.0, right: 0.0),
              child: widget.trailing1 != null
                  ? ValueListenableBuilder(
                      valueListenable: visibileNotifier,
                      builder: (context, visibleBool, child) => IconButton(
                        onPressed: () {
                          visibileNotifier.value = !visibileNotifier.value;
                        },
                        icon: visibleBool
                            ? Icon(widget.trailing1)
                            : Icon(widget.trailing2),
                        color: colorblack.withOpacity(0.5),
                      ),
                    )
                  : null),
        ],
      ),
    );
  }
}
