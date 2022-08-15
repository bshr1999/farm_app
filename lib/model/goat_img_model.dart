class GoatImgModel {
  List<GoatImgData> data=[];
  String? message;
  int? statos;

  GoatImgModel({required this.data, this.message, this.statos});

  GoatImgModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GoatImgData>[];
      json['data'].forEach((v) {
        data.add(GoatImgData.fromJson(v));
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

class GoatImgData {
  int? id;
  String? img;
  String? goatsId;
  var proId;
  String? createdAt;
  String? updatedAt;

  GoatImgData(
      {this.id,
        this.img,
        this.goatsId,
        this.proId,
        this.createdAt,
        this.updatedAt});

  GoatImgData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['img'];
    goatsId = json['goats_id'];
    proId = json['pro_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img'] = this.img;
    data['goats_id'] = this.goatsId;
    data['pro_id'] = this.proId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}