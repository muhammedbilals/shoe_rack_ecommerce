import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoe_rack_ecommerce/core/model/product.dart';

List<String> productId = [];
List<Map<dynamic, dynamic>> list = [];
List<Product> products = [];
List<int> productCount = [];
// List<int> totalprice = [];
final userID = FirebaseAuth.instance.currentUser!.email;
final cartRef = FirebaseFirestore.instance
    .collection('users')
    .doc(userID)
    .collection('cart');

final productRef = FirebaseFirestore.instance.collection('product');

void updateRadioButtonValue(String selectedDocumentId) {
  final String email = FirebaseAuth.instance.currentUser!.email!;
  FirebaseFirestore.instance
      .collection('user')
      .doc(email)
      .collection('address')
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      if (doc.id == selectedDocumentId) {
        doc.reference.update({'isDefault': true});
      } else {
        doc.reference.update({'isDefault': false});
      }
    }
  });
}

laodCartData() async {
  //GETTING THE COLLECTION ID FROM CART
  await cartRef.get().then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      // var orderData = doc.data();
      productId.add(doc.get('productId'));
    }
    log('${productId.toString()}----from getdocId');
  }).catchError((error) {
    log('Error getting subcollection documents: $error');
  });

  final product = await productRef.where('id', whereIn: productId).get();
  List<DocumentSnapshot> documentList = product.docs;

  for (var document in documentList) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Product product = Product.fromJson(data);
    products.add(product);
  }
  // setState(() {
  products = products;
  // });

  log(products[0].name.toString());
}

// getTotalProductValue(String id, int productPrice, int productCount) async {
//   final FirebaseAuth auth = FirebaseAuth.instance;
//   final User? user = auth.currentUser;
//   final userID = user!.email;
//   final cartRef = FirebaseFirestore.instance
//       .collection('users')
//       .doc(userID)
//       .collection('cart')
//       .doc(id);
//   // final doc = cartRef.get();
//   await cartRef.update({'totalPrice': productPrice * productCount});
// }

addOrRemoveFromcart(String id, bool? incriment, int price) async {
  //to update cart product count
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final collectionReference = FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('cart')
      .doc(id);

  //to get product count
  final DocumentSnapshot docSnapshot = await collectionReference.get();
  final dynamic productCount = docSnapshot['productCount'];
  if (incriment == true) {
    if (productCount < 5) {
      collectionReference.update({
        'productCount': productCount + 1,
        'totalPrice': docSnapshot['totalPrice'] + price,
      });

      log('added again cart');
    } else {
      return;
    }
  } else {
    if (productCount > 1) {
      collectionReference.update({
        'productCount': productCount - 1,
        'totalPrice': docSnapshot['totalPrice'] - price,
      });

      log('removed again cart');
    } else if (productCount <= 1) {
      collectionReference.delete();
    }
  }
}

Future<QuerySnapshot> getProductIdfromCart() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('cart')
      .get();
  return querySnapshot;
}

Stream<QuerySnapshot> getTotalValue() {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('cart')
      .snapshots();
  return querySnapshot;
}
