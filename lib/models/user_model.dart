class UserModel {
  String? name;
  String? email;
  String? phone;
  String? userId;
  String? address;
  String? image;
  String? nationalId;
  bool? isAdmin;



  UserModel({
    this.image,
    this.phone,
    this.email,
    this.address,
    this.name,
    this.userId,
    this.isAdmin,
    this.nationalId,


  });

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    userId = json['userId'];
    image = json['image'];
    isAdmin = json['isAdmin'];
    nationalId = json['nationalId'];

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
      'isAdmin':isAdmin,
      'nationalId':nationalId,
    };
  }

}
