class MenuSubModel {
  List<MenuSubData> data=[];
  String? message;
  int? statos;

  MenuSubModel({required this.data, this.message, this.statos});

  MenuSubModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MenuSubData>[];
      json['data'].forEach((v) {
        data.add(MenuSubData.fromJson(v));
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

class MenuSubData {
  int? id;
  String? value;
  String? menueId;
  String? createdAt;
  String? updatedAt;

  MenuSubData({this.id, this.value, this.menueId, this.createdAt, this.updatedAt});

  MenuSubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    menueId = json['menue_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['menue_id'] = this.menueId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}