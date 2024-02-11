class SubCategoryListModel {
  bool? error;
  List<Subcategorylist> subcategorylist;
  String? message;

  SubCategoryListModel({
    this.error,
    required this.subcategorylist,
    this.message,
  });

  factory SubCategoryListModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryListModel(
        error: json["error"],
        subcategorylist: List<Subcategorylist>.from(
            json["subcategorylist"].map((x) => Subcategorylist.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "subcategorylist":
            List<dynamic>.from(subcategorylist.map((x) => x.toJson())),
        "message": message,
      };
}

class Subcategorylist {
  int? id;
  String? categoryName;
  int? catId;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;

  Subcategorylist({
    this.id,
    this.categoryName,
    this.catId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory Subcategorylist.fromJson(Map<String, dynamic> json) =>
      Subcategorylist(
        id: json["id"],
        categoryName: json["category_name"],
        catId: json["cat_id"],
        image: json["image"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "cat_id": catId,
        "image": image ?? "",
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "status": status,
      };
}
