class UserModel {
  String? name;
  String? email;
  String? phone;
  String? userId;
  String? address;
  String? image;
  String? nationalId;
  bool? isDelivery;
  bool? superAdmin;
  bool? orderNow;
  String? orderId;
  String? deliveryId;
  int? numberOfDonationFood;
  int? numberOfDonationMoney;



  UserModel({
    this.image,
    this.phone,
    this.email,
    this.address,
    this.name,
    this.userId,
    this.isDelivery,
    this.nationalId,
    this.orderId,
    this.orderNow,
    this.deliveryId,
    this.superAdmin,
    this.numberOfDonationFood,
    this.numberOfDonationMoney,

  });

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    userId = json['userId'];
    image = json['image'];
    isDelivery = json['isDelivery'];
    nationalId = json['nationalId'];
    orderId= json['orderId'];
    orderNow= json['orderNow'];
    deliveryId= json['deliveryId'];
    numberOfDonationFood= json['numberOfDonationFood'];
    numberOfDonationMoney= json['numberOfDonationMoney'];
    superAdmin= json['superAdmin'];

  }


  Map<String,dynamic> toMap()
  {
    return {
      'address':address,
      'email':email,
      'name':name,
      'phone':phone,
      'userId':userId,
      'image':image,
      'isDelivery':isDelivery,
      'nationalId':nationalId,
      'orderId':orderId,
      'orderNow':orderNow,
      'deliveryId':deliveryId,
      'numberOfDonationFood':numberOfDonationFood,
      'numberOfDonationMoney':numberOfDonationMoney,
      'superAdmin':superAdmin,
    };
  }

}
