
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:donationproject/models/order_model.dart';
import 'package:donationproject/modules/admin/admin_screen.dart';
import 'package:donationproject/modules/delivery/orders/order_screen.dart';
import 'package:donationproject/modules/delivery/waiting_page/waiting_page.dart';
import 'package:donationproject/modules/donate_screen/donate_screen.dart';
import 'package:donationproject/modules/profile_screen/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import '../../models/user_model.dart';
import '../../modules/home_screen/home_screen.dart';
import '../../shared/components/constants.dart';

class MainCubit extends Cubit<DonationStates> {
  MainCubit() : super(DonationInitialState());

  static MainCubit get(context) => BlocProvider.of(context);


// here the function that make the icon of bottomNavigationBar change
  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    DonateScreen(),
    ProfileScreen(),
  ];
  List<Widget> screens2 = [
    OrderScreen(),
    ProfileScreen(),
    HomeScreen(),
    DonateScreen(),
    AdminPage(),
  ];

  void changeBottomNavBar(dynamic index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }

  //........................this functions for user..................//

  // this function used to get the user data and display it in application
  UserModel? userModel;
  OrderModel? orderModel;

  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((dynamic value) {
      userModel = UserModel.fromJson(value.data());
      emit(GetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserErrorState(error.toString()));
    });
  }

  // void getOrdersData() {
  //   emit(GetUserLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('orders')
  //       .doc(userId)
  //       .get()
  //       .then((dynamic value) {
  //     orderModel = OrderModel.fromJson(value.data());
  //     emit(GetUserSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetUserErrorState(error.toString()));
  //   });
  // }

  //
  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ProfileImagePickedErrorState());
    }
  }

  //
  void uploadProfileImage({
    required String name,
    required String phone,
    required String address,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri
        .file(profileImage!.path)
        .pathSegments
        .last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((dynamic value) {
        // emit(UploadProfileImageSuccessState());
        updateUser(
            name: name,
            phone: phone,
            address: address,
            image: value
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

//
  void updateProfileImage({
    String? image,
  }) {
    UserModel model = UserModel(
      image: image ?? userModel!.image,
    );
    FirebaseFirestore.instance.collection('users').doc(userId).update(
        {'image': image}).then((dynamic value) {
      userModel!.image = value;
      emit(UpdateSuccessState());
    }).catchError((error) {
      emit(UpdateSuccessState());
    });
  }

//
  void updateUser({
    required String name,
    required String phone,
    required String address,
    String? image,
  }) {
    emit(UserUpdateLoading());

    UserModel model = UserModel(
      name: name,
      phone: phone,
      address: address,
      image: image ?? userModel!.image,
      email: userModel!.email,
      userId: userModel!.userId,
      isDelivery: userModel!.isDelivery!,
      nationalId: userModel?.nationalId,
      orderId: userModel?.orderId,
      orderNow: userModel?.orderNow,
      numberOfDonationMoney: userModel?.numberOfDonationMoney,
      numberOfDonationFood: userModel?.numberOfDonationFood,
      superAdmin: userModel?.superAdmin,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.userId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateError());
    });
  }

//
  void createOrder({
    required String phone,
    required String name,
    required String address,
    required String description,


  }) {
    final CollectionReference collectionRef = FirebaseFirestore.instance
        .collection('orders');
    final doc = collectionRef.doc();
    OrderModel model = OrderModel(
      name: name,
      userId: userModel!.userId,
      phone: phone,
      address: address,
      description: description,
      isDone: false,
      orderId: doc.id,
    );
    emit(CreateOrderLoadingState());
    FirebaseFirestore.instance
        .collection('orders')
        .add(model.toMap())
        .then((value) {
      emit(CreateOrderSuccessState());
    }).catchError((error) {
      emit(CreateOrderErrorState());
    });
  }


  //........this functions are specifies to delivery.....................//

  // this function to make you choose a national id from gallery
  File? nationalId;
  var picker1 = ImagePicker();
  Future<void> getNationalId() async {
    final pickedFile = await picker1.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      nationalId = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected');
      emit(ProfileImagePickedErrorState());
    }
  }

  // this function to upload image for delivery
  void uploadProfileDeliveryImage({
    required String name,
    required String phone,
    required String address,
  }) {
    emit(UploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((dynamic value) {
        updateProfileImageDelivery(
          image:  value,
        );
        emit(UploadProfileImageSuccessState());

      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  // this function to update the data of the delivery
  void updateDelivery({
    required String name,
    required String phone,
    required String address,
    required bool isDelivery,
    String? image,
  }) {
    emit(UserUpdateLoading());

    UserModel model = UserModel(
      name: name,
      phone: phone,
      address: address,
      image: image ?? userModel!.image,
      email: userModel!.email,
      userId: userModel!.userId,
      isDelivery: isDelivery,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.userId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UserUpdateError());
    });
  }

  // this function used to update the profile image delivery
  void updateProfileImageDelivery({
    String? image,
  })
  {
    UserModel model = UserModel(
      image:image?? userModel!.image,
    );
    FirebaseFirestore.instance.collection('users').doc(userId).update({'image':image}).then((dynamic value) {
      userModel!.image = value;
      emit(UpdateSuccessState());
    }).catchError((error){
      emit(UpdateSuccessState());
    });
  }

  // this function used to upload the national id of delivery
  void uploadNationalId(
  {
    required String name,
    required String phone,
    required String address,
}

      ) {
    emit(UploadLoadingState());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(nationalId!.path).pathSegments.last}')
        .putFile(nationalId!)
        .then((value) {
      value.ref.getDownloadURL().then((dynamic value) {
        emit(UploadProfileImageSuccessState());
        updateNationalIdImage(
          nationalId: value,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }

  // this function used to update the national id of delivery
  void updateNationalIdImage({
    String? nationalId,
  })
  {
    UserModel model = UserModel(
      image:nationalId?? userModel!.nationalId,
    );
    FirebaseFirestore.instance.collection('users').doc(userId).update({'nationalId':nationalId}).then((dynamic value) {
      userModel!.nationalId = value;
      emit(UpdateSuccessState());
    }).catchError((error){
      emit(UpdateSuccessState());
    });
  }

  // update order state
  void updateOrderState (value,userid){
    FirebaseFirestore.instance.collection('users').doc(userid).update({'orderNow':value}).then((value) {
      emit(UpdateOrderSuccessState());
    }).catchError((error){
      emit(UpdateOrderErrorState());
    });
  }

  // give user delivery id
  void updateDeliveryId (value,userid){
    FirebaseFirestore.instance.collection('users').doc(userid).update({'deliveryId':value}).then((value) {
      emit(UpdateOrderSuccessState());
    }).catchError((error){
      emit(UpdateOrderErrorState());
    });
  }

 // give user order id
  void updateTheOrderId (value,userid){
    FirebaseFirestore.instance.collection('users').doc(userid).update({'orderId':value}).then((value) {
      emit(DoneOrderSuccessState());
    }).catchError((error){
      emit(DoneOrderErrorState());
    });
  }



  // delete order when it finished
  Stream<UserModel> get userModelStream => FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .snapshots()
      .map((event) => UserModel.fromJson(event.data()!));







  ////
  final ordersCollection = FirebaseFirestore.instance.collection('orders');
  final field = 'orderId'; // replace with the name of the field to search
  final value = '123'; // replace with the value to search for

  Future<void> deleteDocsByFieldValue(  dynamic fieldValue) async {
    final collectionRef = FirebaseFirestore.instance.collection('orders');
    final querySnapshot = await collectionRef.where('orderId', isEqualTo: fieldValue).get();
    final batch = FirebaseFirestore.instance.batch();
    querySnapshot.docs.forEach((doc) {
      batch.delete(doc.reference);
    });

    await batch.commit();
  }
  //////////////////
  void updateNumberOfDonationOfFood ( value,userId){
    value++;
    FirebaseFirestore.instance.collection('users').doc(userId).update({'numberOfDonationFood':value}).then((value) {

      emit(IncreaseNumberOfDonationSuccessState());
    }).catchError((error){
      emit(IncreaseNumberOfDonationErrorState());
    });
  }
}


//......................................................................//

