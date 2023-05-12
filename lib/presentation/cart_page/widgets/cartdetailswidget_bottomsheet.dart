import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';

class CartDetailsWidgetBottomSheet extends StatelessWidget {
  CartDetailsWidgetBottomSheet({
    super.key,
    required this.count,
    required this.docId,
  });
  final String docId;
  final int count;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('product').where('id' ,isEqualTo: docId).get(),
      builder: (context, snapshot) {
           if (snapshot.hasError) return Text('Error = ${snapshot.error}');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
             width: size.width * 0.95,
              height: size.width * 0.4,
              child: Center(child: const CircularProgressIndicator()));
          }
        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            
            return  Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Container(
              width: size.width * 0.95,
              height: size.width * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: colorgray),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 80,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(data['imgurl'])),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: size.width * 0.64,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 12.0, top: 0, bottom: 0),
                          child: Text(
                            data['name'],
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.6,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, bottom: 0, top: 0),
                          child: Text(
                            data['subtitle'],
                            style: TextStyle(
                                // overflow: TextOverflow.clip,
                                fontSize: 15,
                                color: colorblack.withOpacity(0.5)),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 5),
                        child: Row(
                          children: [
                            Text(
                              data['color'],
                              style: TextStyle(fontSize: 15),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                '|',
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Size : ${data['size']}',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 12.0, top: 0, bottom: 0),
                              child: Text(
                                '₹${data['price']}',
                                style: TextStyle(fontSize: 25),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.25),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colorgreen),
                                width: size.width * 0.15,
                                height: size.width * 0.09,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Text('1'),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
            }).toList()
        );

        
      },
    );
  }
}
