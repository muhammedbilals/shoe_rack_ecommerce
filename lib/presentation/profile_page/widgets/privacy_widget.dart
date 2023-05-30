import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';


class SettingsMenuPop extends StatelessWidget {
  SettingsMenuPop({Key? key, this.radius = 8, required this.mdFileName})
      : assert(
            mdFileName.contains('.md'), 'The file must contain .md extention'),
        super(key: key);
  final double radius;
  final String mdFileName;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color.fromARGB(255, 35, 35, 35),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                  future: Future.delayed(const Duration(microseconds: 200))
                      .then((value) =>
                          rootBundle.loadString('asset/$mdFileName')),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Markdown(
                          styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                              textTheme:  TextTheme(
                                  // ignore: deprecated_member_use
                                  bodyText2: TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 15.0,
                                      color: colorwhite)))),
                          data: snapshot.data.toString());
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  })),
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child:  Text(
                  'OK',
                  style: TextStyle(color: colorwhite),
                ),
              ))
        ],
    ),
);
}
}