import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoe_rack_ecommerce/model/address_model.dart';

final userID = FirebaseAuth.instance.currentUser!.email;
final addressRef = FirebaseFirestore.instance
    .collection('users')
    .doc(userID)
    .collection('address');

void addNewAddress(Address address) {

  addressRef.doc().set(address.toJason());
  
}
