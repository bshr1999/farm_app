class ProductDetailsModel {
  List<ProductDetailsData> data=[];
  String? message;
  int? statos;

  ProductDetailsModel({required this.data, this.message, this.statos});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductDetailsData>[];
      json['data'].forEach((v) {
        data.add(ProductDetailsData.fromJson(v));
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

class ProductDetailsData {
  int? id;
  String? name;
  String? costBig;
  String? costSmall;
  String? cost;
  String? img;
  String? subDeptId;
  String? meatType;
  String? createdAt;
  String? updatedAt;

  ProductDetailsData(
      {this.id,
        this.name,
        this.costBig,
        this.costSmall,
        this.cost,
        this.img,
        this.subDeptId,
        this.meatType,
        this.createdAt,
        this.updatedAt});

  ProductDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    costBig = json['cost_big'];
    costSmall = json['cost_small'];
    cost = json['cost'];
    img = json['img'];
    subDeptId = json['sub_dept_id'];
    meatType = json['meat_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['cost_big'] = this.costBig;
    data['cost_small'] = this.costSmall;
    data['cost'] = this.cost;
    data['img'] = this.img;
    data['sub_dept_id'] = this.subDeptId;
    data['meat_type'] = this.meatType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}