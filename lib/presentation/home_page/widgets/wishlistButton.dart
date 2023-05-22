import 'dart:developer';

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

bool isAddedtoWishlist = false;

class _FavouriteButtonState extends State<FavouriteButton> {
  // checkIfAlreadyAdded() async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc('$userID')
  //       .collection('wishlist')
  //       .where('product', isEqualTo: widget.productId)
  //       .get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     if (mounted) {
  //       setState(
  //         () {
  //           isliked = true;
  //         },
  //       );
  //     }
  //   }
  // }
  checkWishlistStatus(String id) async {
    final userCollection = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('wishlist')
        .doc(id);

    final wishlistDocSnapshot = await userCollection.get();

    if (wishlistDocSnapshot.exists) {
      if (mounted) {
        setState(() {
          isAddedtoWishlist = true;
        });
      }

      log('product in wishlist');
    } else {
      log('not in wishlist');
    }
  }

  @override
  void initState() {
    checkWishlistStatus(widget.productId);
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
        icon: isAddedtoWishlist
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
            await userCollection
                .doc(widget.productId)
                .set({'product': widget.productId});
            debugPrint('produt added to $userID');
            setState(() {
              isAddedtoWishlist = true;
            });
          } else {
            setState(() {
              isAddedtoWishlist = false;
            });
            await userCollection.doc(widget.productId).delete();
            debugPrint('produt deleteto $userID');
          }

          // setState(() {
          //   isAddedtoWishlist = !isAddedtoWishlist;
          // });
        },
      ),
    );
  }
}
