class SubCategoryProductListModel {
  bool? error;
  List<SubProductlist> productlist;
  String? message;

  SubCategoryProductListModel({
    this.error,
    required this.productlist,
    this.message,
  });

  factory SubCategoryProductListModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryProductListModel(
        error: json["error"],
        productlist: List<SubProductlist>.from(
            json["productlist"].map((x) => SubProductlist.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "productlist": List<dynamic>.from(productlist.map((x) => x.toJson())),
        "message": message,
      };
}

class SubProductlist {
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
  int? tax;
  String? images;

  SubProductlist({
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
    this.tax,
    this.images,
  });

  factory SubProductlist.fromJson(Map<String, dynamic> json) => SubProductlist(
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
        tax: json["tax"],
        images: json["images"],
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
        "tax": tax,
        "images": images,
      };
}
