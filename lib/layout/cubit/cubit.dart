import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:donationproject/modules/delivery/orders/order_screen.dart';
import 'package:donationproject/modules/donate_screen/donate_screen.dart';
import 'package:donationproject/modules/profile_screen/profile_screen.dart';
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
    OrderScreen(),
  ];
  void changeBottomNavBar(dynamic index) {
    currentIndex = index;
    emit(ChangeBottomNavState());
  }
// this function used to call the data of uer and display it in application
  UserModel? userModel;
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

//
void uploadProfileImage(
    {
      required String name,
      required String phone,
      required String address,
    }
    ) {
  firebase_storage.FirebaseStorage.instance
      .ref()
      .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
      .putFile(profileImage!)
      .then((value) {
    value.ref.getDownloadURL().then((dynamic value) {
      // emit(UploadProfileImageSuccessState());
updateUser(name: name, phone: phone, address: address,image: value);

    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }).catchError((error) {
    emit(UploadProfileImageErrorState());
  });
}

void uploadNationalId() {
  firebase_storage.FirebaseStorage.instance
      .ref()
      .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
      .putFile(profileImage!)
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



//
  void updateProfileImage({
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

  void updateNationalIdImage({
    String? nationalId,
  })
  {
    UserModel model = UserModel(
      image:nationalId?? userModel!.nationalId,
    );
    FirebaseFirestore.instance.collection('users').doc(userId).update({'image':nationalId}).then((dynamic value) {
      userModel!.nationalId = value;
      emit(UpdateSuccessState());
    }).catchError((error){
      emit(UpdateSuccessState());
    });
  }
  //////////////////////////////////////////
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
      isAdmin: userModel!.isAdmin!,
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
  //////////////////////////////////////
  void uploadProfileUserImage({
    required String name,
    required String phone,
    required String address,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((dynamic value) {
        emit(UploadProfileImageSuccessState());
        updateUser(
          name: name,
          phone: phone,
          address: address,
          image: value,
        );
      }).catchError((error) {
        emit(UploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState());
    });
  }
  ////////////////////////////////////
}