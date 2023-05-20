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

Future<List<Address>> DisplayAddress() async {
  List<Address> addres = [];
  final address = await addressRef.get();
  List<DocumentSnapshot> doclist = address.docs;

  for (var document in doclist) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    Address address = Address.fromJason(data);
    addres.add(address);
  }
  return addres;
}
