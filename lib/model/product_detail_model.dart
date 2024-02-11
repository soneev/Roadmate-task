class ProductDetailModel {
  bool? error;
  List<Productdetail> productdetails;
  String? message;

  ProductDetailModel({
    this.error,
    required this.productdetails,
    this.message,
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) =>
      ProductDetailModel(
        error: json["error"],
        productdetails: List<Productdetail>.from(
            json["productdetails"].map((x) => Productdetail.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "productdetails":
            List<dynamic>.from(productdetails.map((x) => x.toJson())),
        "message": message,
      };
}

class Productdetail {
  int? id;
  int? brandId;
  String? productName;
  int? offerPrice;
  int? price;
  String? description;
  int? status;
  int? hsncode;
  int? priority;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? catId;
  List<String>? images;

  Productdetail({
    this.id,
    this.brandId,
    this.productName,
    this.offerPrice,
    this.price,
    this.description,
    this.status,
    this.hsncode,
    this.priority,
    this.createdAt,
    this.updatedAt,
    this.catId,
    this.images,
  });

  factory Productdetail.fromJson(Map<String, dynamic> json) => Productdetail(
        id: json["id"],
        brandId: json["brand_id"],
        productName: json["product_name"],
        offerPrice: json["offer_price"],
        price: json["price"],
        description: json["description"],
        status: json["status"],
        hsncode: json["hsncode"],
        priority: json["priority"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        catId: json["cat_id"],
        images: List<String>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand_id": brandId,
        "product_name": productName,
        "offer_price": offerPrice,
        "price": price,
        "description": description,
        "status": status,
        "hsncode": hsncode,
        "priority": priority,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "cat_id": catId,
        "images": List<dynamic>.from(images!.map((x) => x)),
      };
}
