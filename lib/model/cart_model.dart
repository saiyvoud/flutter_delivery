class CartModel {
  final String cartID;
  final String productID;
  final String name;
  final String desc;
  final int amount;
  final int price;
  final String img;
  final String userID;
  CartModel(
      {required this.cartID,
      required this.productID,
      required this.name,
      required this.desc,
      required this.amount,
      required this.price,
      required this.img,
      required this.userID});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        cartID: json["cartID"],
        productID: json['productID'],
        name: json['name'],
        desc: json['desc'],
        amount: json['amount'],
        price: json['price'],
        img: json['img'],
        userID: json['userID'],
      );
  Map<String, dynamic> toJson() => {
        'cartID': cartID,
        'productID': productID,
        'name': name,
        'desc': desc,
        'amount': amount,
        'price': price,
        'img': img,
        'userID': userID
      };
}
