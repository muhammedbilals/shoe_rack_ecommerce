class CartModel {
  String? productId;
  String? productCount;
  String? color;
  int? size;
  int? totalPrice;

  CartModel(
      {this.productId,
      this.productCount,
      this.color,
      this.size,
      this.totalPrice});

  static CartModel fromJason(Map<String, dynamic> json) => CartModel(
        productId: json['productId'],
        productCount: json['productCount'],
        color: json['color'],
        size: json['size'],
        totalPrice: json['totalPrice'],
      );

  Map<String, dynamic> toJason() => {
        'productId': productId,
        'productCount': productCount,
        'color': color,
        'size': size,
        'totalPrice': totalPrice,
      };
}
