import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoe_rack_ecommerce/model/address_model.dart';

final userID = FirebaseAuth.instance.currentUser!.email;
final addressRef = FirebaseFirestore.instance
    .collection('users')
    .doc(userID)
    .collection('address');

void addNewAddress(Address address) {
  final id = addressRef.doc();
  address.id = id.id;
  log('adress added${address.id.toString()}');
  addressRef.doc(address.id).set(address.toJason());
}

Future<List<Address>> displayAddress() async {
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

// defaultAddress(int defaultValue) async {
//   List<Address> addres = await displayAddress();
//   if (addres.isEmpty) return;
//   String? id = addres[defaultValue].id;
//   log(defaultValue.toString());
//   log(id.toString());
//   addressRef.doc(id).update({'isDefault': true});

//   }

// Future<int> getDefaultIndex() async {
//   List<Address> addres = await displayAddress();
//   for (int i = 0; i < addres.length; i++) {
//     if (addres[i].isDefault == true) {
//       return i;
//     }
//   }

// }
updateDefaultValue(String adressId) async {
  addressRef.get().then((QuerySnapshot querysnapshot) {
    for (var doc in querysnapshot.docs) {
      if (doc.id == adressId) {
        doc.reference.update({'isDefault': true});
      }else{
        doc.reference.update({'isDefault': false});
      }
    }
  });
}
