class ProductSubModel {
  List<ProductSubData> data=[];
  String? message;
  int? statos;

  ProductSubModel({required this.data, this.message, this.statos});

  ProductSubModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductSubData>[];
      json['data'].forEach((v) {
        data.add(ProductSubData.fromJson(v));
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

class ProductSubData {
  int? id;
  String? name;
  String? desc;
  String? address;
  String? phoneNo;
  String? img;
  String? deptId;
  String? type;
  String? createdAt;
  String? updatedAt;

  ProductSubData(
      {this.id,
        this.name,
        this.desc,
        this.address,
        this.phoneNo,
        this.img,
        this.deptId,
        this.type,
        this.createdAt,
        this.updatedAt});

  ProductSubData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    address = json['address'];
    phoneNo = json['phone_no'];
    img = json['img'];
    deptId = json['dept_id'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['address'] = address;
    data['phone_no'] = phoneNo;
    data['img'] = img;
    data['dept_id'] = deptId;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

}