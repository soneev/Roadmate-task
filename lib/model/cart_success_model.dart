class CartSuccessModel {
  bool? error;
  int? data;
  String? message;

  CartSuccessModel({
    this.error,
    this.data,
    this.message,
  });

  factory CartSuccessModel.fromJson(Map<String, dynamic> json) =>
      CartSuccessModel(
        error: json["error"],
        data: json["data"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data,
        "message": message,
      };
}
