import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/core/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar:   Icon(Icons.notifications),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: colorgray,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.search),
                ),
                SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration.collapsed(hintText: 'Search'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
