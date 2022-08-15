class LoginModel {
  List<LoginData>? data=[];
  String? message;
  int? statos;

  LoginModel({this.data, this.message, this.statos});

  LoginModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LoginData>[];
      json['data'].forEach((v) {
        data?.add(LoginData.fromJson(v));
      });
    }
    message = json['message'];
    statos = json['statos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['statos'] = this.statos;
    return data;
  }
}

class LoginData {
  int? id;
  String? name;
  var type;
  String? email;
  String? phoneNo;
  var phoneNoVerifiedAt;
  String? isActive;
  String? createdAt;
  String? updatedAt;

  LoginData(
      {this.id,
        this.name,
        this.type,
        this.email,
        this.phoneNo,
        this.phoneNoVerifiedAt,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    email = json['email'];
    phoneNo = json['phone_no'];
    phoneNoVerifiedAt = json['phone_no_verified_at'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['phone_no_verified_at'] = this.phoneNoVerifiedAt;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}