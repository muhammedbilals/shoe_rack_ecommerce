import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/screens/home_page.dart';

class FavouriteButton extends StatefulWidget {
  const FavouriteButton({
    super.key,
    required this.productId,
  });
  final String productId;

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}
  bool isliked = false;
class _FavouriteButtonState extends State<FavouriteButton> {

  checkIfAlreadyAdded() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc('$userID')
        .collection('wishlist')
        .where('product', isEqualTo: widget.productId)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      setState(
        () {
          isliked = true;
        },
      );
    }
  }

  @override
  void initState() {
    checkIfAlreadyAdded();
    super.initState();
  }

  @override
  void dispose() {
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 5,
        right: 5,
        child: IconButton(
          icon: isliked
              ? Icon(
                  CustomIcon.hearticonfluttter,
                  color: colorgreen,
                )
              : const Icon(CustomIcon.hearticonfluttter),
          onPressed: () async {
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                .collection('users')
                .doc('$userID')
                .collection('wishlist')
                .where('product', isEqualTo: widget.productId)
                .get();
            if (querySnapshot.docs.isEmpty) {
              await userCollection.doc().set({'product': widget.productId});
              debugPrint('produt added to $userID');
            } else {
              await userCollection.doc(querySnapshot.docs.first.id).delete();
              debugPrint('produt deleteto $userID');
            }

            setState(() {
              isliked = !isliked;
            });
          },
        ));
  }
}
