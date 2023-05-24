import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoe_rack_ecommerce/core/model/product.dart';

List<String> productId = [];
List<Map<dynamic, dynamic>> list = [];
List<Product> products = [];
List<int> productCount = [];
List<int> totalprice = [];
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
  
 final product = await productRef
        .where('id', whereIn: productId)
        .get();
    List<DocumentSnapshot> documentList = product.docs;

    for (var document in documentList) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      Product product = Product.fromJson(data);
      products.add(product);
    }
    // setState(() {
      products = products;
    // });
  
    getTotalPrice();
    log(products[0].name.toString());
}
getTotalPrice(){}


// void getTotalValue() async {
//   await cartRef.get().then((QuerySnapshot querySnapshot) {
//     for (var doc in querySnapshot.docs) {
//       productId.add(doc.get('productId'));
//       productCount.add(doc.get('productCount'));
//     }
//   }).catchError((error) {
//     log(error);
//   });
//   // GETTING PRICE FROM PRODUCT DATABASE WITH PRODUCT ID
//   var snapshot = await FirebaseFirestore.instance
//       .collection('product')
//       .where('id', whereIn: productId)
//       .get();
//   final templista = snapshot.docs;
//   list = templista.map((DocumentSnapshot documentSnapshot) {
//     return documentSnapshot.data() as Map<String, dynamic>;
//   }).toList();
//   //update total price
//   for (int i = 0; i < productId.length; i++) {
//     cartRef.doc(productId[i]).update(list[i]['totalPrice'] * productCount[i]);
//     print(cartRef);
//   }
// }