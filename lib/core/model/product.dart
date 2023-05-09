class Product {
  final String name;
  final String subtitle;
  final String descrption;
  String? id;
  final String? price;
  final String? color;
  final int? size;
  final String? imgurl;

  Product(
      {required this.name,
      required this.subtitle,
      this.id,
      this.imgurl, 
      this.price,
      this.color,
      this.size,
      this.descrption = ''});

  static Product fromJason(Map<String, dynamic> json) => Product(
      imgurl : json['imgUrl'],
      name: json['name'],
      subtitle: json['subtitle'],
      descrption: json['discrption'],
      id: json['id'],
      color: json['color'],
      size: json['size']);

  Map<String, dynamic> toJason() => {
        'name': name,
        'subtitle': subtitle,
        'discription': descrption,
        'id': id,
        'color': color,
        'size': size,
        'imgurl':imgurl
      };
}
