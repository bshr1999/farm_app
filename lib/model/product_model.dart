class ProductModel {
  List<ProductData> data=[];
  String? message;
  int? statos;

  ProductModel({required this.data, required this.message, required this.statos});

  ProductModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data.add(ProductData.fromJson(v));
      });
    }
    message = json['message'];
    statos = json['statos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data.map((v) => v.toJson()).toList();
    data['message'] = message;
    data['statos'] = statos;
    return data;
  }
}

class ProductData {
  int? id;
  String? name;
  String? img;
  // ignore: prefer_typing_uninitialized_variables
  var createdAt;
  // ignore: prefer_typing_uninitialized_variables
  var updatedAt;

  ProductData({required this.id, required this.name, required this.img, this.createdAt, this.updatedAt});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}