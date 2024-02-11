// To parse this JSON data, do
//
//     final categoryListModel = categoryListModelFromJson(jsonString);

class CategoryListModel {
  bool? error;
  List<Categorylist> categorylist;
  String? message;

  CategoryListModel({
    this.error,
    required this.categorylist,
    this.message,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) =>
      CategoryListModel(
        error: json["error"],
        categorylist: List<Categorylist>.from(
            json["categorylist"].map((x) => Categorylist.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "categorylist": List<dynamic>.from(categorylist.map((x) => x.toJson())),
        "message": message,
      };
}

class Categorylist {
  int? id;
  String? categoryName;
  int? catId;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;

  Categorylist({
    this.id,
    this.categoryName,
    this.catId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  factory Categorylist.fromJson(Map<String, dynamic> json) => Categorylist(
        id: json["id"],
        categoryName: json["category_name"],
        catId: json["cat_id"],
        image: json["image"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "cat_id": catId,
        "image": image,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "status": status,
      };
}
