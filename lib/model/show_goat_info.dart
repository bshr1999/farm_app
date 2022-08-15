class ShowGoatInfoModel {
  List<ShowGoatInfoData> data=[];
  String? message;
  int? statos;

  ShowGoatInfoModel({required this.data, this.message, this.statos});

  ShowGoatInfoModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowGoatInfoData>[];
      json['data'].forEach((v) {
        data.add(ShowGoatInfoData.fromJson(v));
      });
    }
    message = json['message'];
    statos = json['statos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data.map((v) => v.toJson()).toList();
    data['message'] = message;
    data['statos'] = statos;
    return data;
  }
}

class ShowGoatInfoData {
  int? id;
  String? size;
  String? age;
  String? price;
  String? goatId;
  String? heavy;
  String? createdAt;
  String? updatedAt;

  ShowGoatInfoData(
      {this.id,
        this.size,
        this.age,
        this.price,
        this.goatId,
        this.heavy,
        this.createdAt,
        this.updatedAt});

  ShowGoatInfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    age = json['age'];
    price = json['price'];
    goatId = json['goat_id'];
    heavy = json['heavy'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['age'] = this.age;
    data['price'] = this.price;
    data['goat_id'] = this.goatId;
    data['heavy'] = this.heavy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}