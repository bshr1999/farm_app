class GoatBuyDetailsModel {
  List<GoatBuyData> data=[];
  String? message;
  int? statos;

  GoatBuyDetailsModel({required this.data, this.message, this.statos});

  GoatBuyDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GoatBuyData>[];
      json['data'].forEach((v) {
        data.add(GoatBuyData.fromJson(v));
      });
    }
    message = json['message'];
    statos = json['statos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['statos'] = this.statos;
    return data;
  }
}

class GoatBuyData {
  int? id;
  String? name;
  String? price;
  var typeCut;
  String? createdAt;
  String? updatedAt;

  GoatBuyData(
      {this.id,
        this.name,
        this.price,
        this.typeCut,
        this.createdAt,
        this.updatedAt});

  GoatBuyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    typeCut = json['type_cut'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['type_cut'] = this.typeCut;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}