class OrderModel {
  String? orderId;
  List<String>? productId;
  int? totalValue;
  String? addressId;
  String? paymentMethode;
  String? orderStatus;
  String? orderDate;

  OrderModel(
      {this.orderId,
      required this.productId,
      required this.totalValue,
      required this.addressId,
      this.paymentMethode,
      this.orderStatus,
      this.orderDate});

  static OrderModel fromJason(Map<String, dynamic> json) => OrderModel(
        orderId: json['orderId'],
        productId: json['productId'],
        addressId: json['addressId'],
        totalValue: json['totalValue'],
        paymentMethode: json['paymentMethode'],
        orderStatus: json['orderStatus'],
        orderDate: json['orderDate'],

      );

  Map<String, dynamic> toJason() => {
        'orderId': orderId,
        'productId': productId,
        'addressId': addressId,
        'totalValue': totalValue,
        'paymentMethode': paymentMethode,
        'orderStatus': orderStatus,
        'orderDate': orderDate,

      };
}
