class ProductModel {
  final String? productID;
  final String? name;
  final String? desc;
  final int? amount;
  final int? price;
  final String? image;

  ProductModel({
    this.productID,
    this.name,
    this.desc,
    this.amount,
    this.price,
    this.image,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        productID: json["id"],
        name: json["name"],
        desc: json["desc"],
        amount: json["amount"],
        price: json["price"],
        image: json["image"],
      );
  Map<String, dynamic> toJson() => {
        "productID": productID,
        "name": name,
        "desc": desc,
        "amount": amount,
        "price": price,
        "image": image,
      };
}
