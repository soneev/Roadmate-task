class CartListModel {
  bool? error;
  List<CartItems> cart;
  String? message;

  CartListModel({
    this.error,
    required this.cart,
    this.message,
  });

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
        error: json["error"],
        cart: List<CartItems>.from(
            json["cart"].map((x) => CartItems.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "cart": List<dynamic>.from(cart!.map((x) => x.toJson())),
        "message": message,
      };
}

class CartItems {
  int? id;
  int? shopId;
  int? productId;
  int? qty;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? tax;
  int? offerPrice;
  int? price;
  String? productName;
  String? description;
  String? images;

  CartItems({
    this.id,
    this.shopId,
    this.productId,
    this.qty,
    this.createdAt,
    this.updatedAt,
    this.tax,
    this.offerPrice,
    this.price,
    this.productName,
    this.description,
    this.images,
  });

  factory CartItems.fromJson(Map<String, dynamic> json) => CartItems(
        id: json["id"],
        shopId: json["shop_id"],
        productId: json["product_id"],
        qty: json["qty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        tax: json["tax"],
        offerPrice: json["offer_price"],
        price: json["price"],
        productName: json["product_name"],
        description: json["description"],
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "product_id": productId,
        "qty": qty,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "tax": tax,
        "offer_price": offerPrice,
        "price": price,
        "product_name": productName,
        "description": description,
        "images": images,
      };
}
