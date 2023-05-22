class OrderModel {
  String? name;
  String? phone;
  String? userId;
  String? orderId;
  String? address;
  String? description;
  bool? isDone;






  OrderModel({this.phone,
    this.address,
    this.name,
    this.userId,
    this.description,
    this.orderId,
    this.isDone,


  });

  OrderModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    description = json['description'];
    phone = json['phone'];
    address = json['address'];
    userId = json['userId'];
    orderId = json['orderId'];
    isDone = json['isDone'];

  }


  Map<String,dynamic> toMap()
  {
    return {
      'address':address,
      'name':name,
      'phone':phone,
      'userId':userId,
      'description':description,
      'orderId':orderId,
      'isDone':isDone,
    };
  }

}
