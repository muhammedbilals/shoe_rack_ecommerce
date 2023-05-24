class OrderModel {
  String? orderId;
  List<Map<String, dynamic>>? productId;
  int? totalValue;
  String? addressId;
  String? paymentMethode;

  OrderModel(
      { this.orderId,
     required this.productId,
     required this.totalValue,
     required this.addressId,
      this.paymentMethode});

       static OrderModel fromJason(Map<String, dynamic> json) => OrderModel(
      orderId: json['orderId'],
      productId: json['productId'],
      addressId: json['addressId'],
      totalValue: json['totalValue'],
      paymentMethode: json['paymentMethode'],
    );

  Map<String, dynamic> toJason() => {
        'orderId': orderId,
        'productId': productId,
        'addressId': addressId,
        'totalValue': totalValue,
        'paymentMethode': paymentMethode,
      };
}
