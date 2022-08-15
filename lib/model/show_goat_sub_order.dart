class ShowGoatSubOrder {
  List<ShowGoatSubOrderData> data=[];
  String? message;
  int? statos;

  ShowGoatSubOrder({required this.data, this.message, this.statos});

  ShowGoatSubOrder.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowGoatSubOrderData>[];
      json['data'].forEach((v) {
        data.add(ShowGoatSubOrderData.fromJson(v));
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

class ShowGoatSubOrderData {
  String? id;
  String? size;
  String? deliveryState;
  String? quantity;
  String? orderId;
  var productId;
  String? descId;
  String? clintId;
  var state;
  String? cutType;
  String? goatId;
  String? total;
  String? price;
  var nameMenu;
  String? infoGoatId;
  String? nots;
  String? createdAt;
  String? updatedAt;
  String? type;
  String? img;
  String? farmId;
  String? age;
  String? heavy;

  ShowGoatSubOrderData(
      {this.id,
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
        this.nots,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.img,
        this.farmId,
        this.age,
        this.heavy});

  ShowGoatSubOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    img = json['img'];
    farmId = json['farm_id'];
    age = json['age'];
    heavy = json['heavy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['img'] = this.img;
    data['farm_id'] = this.farmId;
    data['age'] = this.age;
    data['heavy'] = this.heavy;
    return data;
  }
}
