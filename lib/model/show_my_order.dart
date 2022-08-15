class ShowMyOrder {
  List<ShowMyOrderData> data=[];
  String? message;
  int? statos;

  ShowMyOrder({required this.data, this.message, this.statos});

  ShowMyOrder.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowMyOrderData>[];
      json['data'].forEach((v) {
        data.add(ShowMyOrderData.fromJson(v));
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

class ShowMyOrderData {
  int? id;
  String? phoneNo;
  String? city;
  String? street;
  String? apartment;
  String? date;
  String? time;
  String? total;
  var state;
  var payState;
  String? userId;
  String? createdAt;
  String? updatedAt;

  ShowMyOrderData(
      {this.id,
        this.phoneNo,
        this.city,
        this.street,
        this.apartment,
        this.date,
        this.time,
        this.total,
        this.state,
        this.payState,
        this.userId,
        this.createdAt,
        this.updatedAt});

  ShowMyOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNo = json['phone_no'];
    city = json['city'];
    street = json['street'];
    apartment = json['apartment'];
    date = json['date'];
    time = json['time'];
    total = json['total'];
    state = json['state'];
    payState = json['pay_state'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone_no'] = this.phoneNo;
    data['city'] = this.city;
    data['street'] = this.street;
    data['apartment'] = this.apartment;
    data['date'] = this.date;
    data['time'] = this.time;
    data['total'] = this.total;
    data['state'] = this.state;
    data['pay_state'] = this.payState;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}