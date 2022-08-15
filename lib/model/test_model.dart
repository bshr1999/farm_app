class TestModel {
  String? name;
  bool? type;
  int? log;

  TestModel({this.log,this.name, this.type});

  TestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    type = json['type'];
    log=json['log'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['log']=this.log;
    return data;
  }
}