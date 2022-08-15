class ShowProductSubOrder {
  List<ShowProductSubData> data=[];
  String? message;
  int? statos;

  ShowProductSubOrder({required this.data, this.message, this.statos});

  ShowProductSubOrder.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowProductSubData>[];
      json['data'].forEach((v) {
        data.add(ShowProductSubData.fromJson(v));
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

class ShowProductSubData {
  String? id;
  String? name;
  String? costBig;
  String? costSmall;
  String? cost;
  String? img;
  String? subDeptId;
  String? meatType;
  String? createdAt;
  String? updatedAt;
  String? size;
  String? deliveryState;
  String? quantity;
  String? orderId;
  String? productId;
  var descId;
  String? clintId;
  var state;
  var cutType;
  var goatId;
  String? total;
  String? price;
  String? nameMenu;
  var infoGoatId;
  String? nots;

  ShowProductSubData(
      {this.id,
        this.name,
        this.costBig,
        this.costSmall,
        this.cost,
        this.img,
        this.subDeptId,
        this.meatType,
        this.createdAt,
        this.updatedAt,
        this.size,
        this.deliveryState,
        this.quantity,
        this.orderId,
        this.productId,
        this.descId,
        this.clintId,
        this.state,
        this.cutType,
        this.goatId,
        this.total,
        this.price,
        this.nameMenu,
        this.infoGoatId,
        this.nots});

  ShowProductSubData.fromJson(Map<String, dynamic> json) {
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
    size = json['size'];
    deliveryState = json['delivery_state'];
    quantity = json['quantity'];
    orderId = json['order_id'];
    productId = json['product_id'];
    descId = json['desc_id'];
    clintId = json['clint_id'];
    state = json['state'];
    cutType = json['cut_type'];
    goatId = json['goat_id'];
    total = json['total'];
    price = json['price'];
    nameMenu = json['name_menu'];
    infoGoatId = json['info_goat_id'];
    nots = json['nots'];
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
    data['size'] = this.size;
    data['delivery_state'] = this.deliveryState;
    data['quantity'] = this.quantity;
    data['order_id'] = this.orderId;
    data['product_id'] = this.productId;
    data['desc_id'] = this.descId;
    data['clint_id'] = this.clintId;
    data['state'] = this.state;
    data['cut_type'] = this.cutType;
    data['goat_id'] = this.goatId;
    data['total'] = this.total;
    data['price'] = this.price;
    data['name_menu'] = this.nameMenu;
    data['info_goat_id'] = this.infoGoatId;
    data['nots'] = this.nots;
    return data;
  }
}