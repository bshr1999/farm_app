class MenuModel {
  List<MenuData> data=[];
  String? message;
  int? statos;

  MenuModel({required this.data, this.message, this.statos});

  MenuModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <MenuData>[];
      json['data'].forEach((v) {
        data.add(MenuData.fromJson(v));
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

class MenuData {
  int? id;
  String? name;
  var drink;
  var head;
  var plate;
  var salad;
  String? createdAt;
  String? updatedAt;

  MenuData(
      {this.id,
        this.name,
        this.drink,
        this.head,
        this.plate,
        this.salad,
        this.createdAt,
        this.updatedAt});

  MenuData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    drink = json['drink'];
    head = json['head'];
    plate = json['plate'];
    salad = json['salad'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['drink'] = this.drink;
    data['head'] = this.head;
    data['plate'] = this.plate;
    data['salad'] = this.salad;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}