class ShowFarmModel {
  List<ShowFarmData> data=[];
  String? message;
  int? statos;

  ShowFarmModel({required this.data, this.message, this.statos});

  ShowFarmModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowFarmData>[];
      json['data'].forEach((v) {
        data.add(ShowFarmData.fromJson(v));
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

class ShowFarmData {
  int? id;
  String? name;
  String? img;
  String? deptId;
  String? createdAt;
  String? updatedAt;

  ShowFarmData(
      {this.id,
        this.name,
        this.img,
        this.deptId,
        this.createdAt,
        this.updatedAt});

  ShowFarmData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['img'];
    deptId = json['dept_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['img'] = img;
    data['dept_id'] = deptId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}