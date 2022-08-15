class ShowGoatModel {
  List<ShowGoatData> data=[];
  String? message;
  int? statos;

  ShowGoatModel({required this.data, this.message, this.statos});

  ShowGoatModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowGoatData>[];
      json['data'].forEach((v) {
        data.add(ShowGoatData.fromJson(v));
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

class ShowGoatData {
  int? id;
  String? type;
  String? img;
  String? farmId;
  String? updatedAt;
  String? createdAt;

  ShowGoatData(
      {this.id,
        this.type,
        this.img,
        this.farmId,
        this.updatedAt,
        this.createdAt});

  ShowGoatData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    img = json['img'];
    farmId = json['farm_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['img'] = this.img;
    data['farm_id'] = this.farmId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
