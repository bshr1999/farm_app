class SmsModel {
  var data;
  int? message;
  int? statos;

  SmsModel({this.data, required this.message, this.statos});

  SmsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
    statos = json['statos'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = this.message;
    data['statos'] = this.statos;
    return data;
  }
}