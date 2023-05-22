import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationproject/modules/registe_page/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/user_model.dart';
import '../../../shared/components/constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

// this method used to make user register and store the user information to database
  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        name: name,
        email: email,
        phone: phone,
        address: address,
        userId: value.user!.uid,
      );
      userId = value.user!.uid;
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  // this method used to create regular user
  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String userId,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      address: address,
      userId: userId,
      email: email,
      image: 'https://cdn-icons-png.flaticon.com/512/453/453497.png?w=996&t=st=1684488294~exp=1684488894~hmac=9b33c967ced87a7313135b14f577416b4a527e5b4362fdecfcb0ce00f607fc40',
      isDelivery: false,
        numberOfDonationFood:0,
        numberOfDonationMoney: 0,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState(userId));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }

  // this method used to create delivery user
  void userDeliveryRegister({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String password,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userDeliveryCreate(
        name: name,
        email: email,
        phone: phone,
        address: address,
        userId: value.user!.uid,
      );
      userId = value.user!.uid;
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userDeliveryCreate({
    required String name,
    required String email,
    required String phone,
    required String address,
    required String userId,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      address: address,
      userId: userId,
      email: email,
      nationalId: 'https://img.freepik.com/free-vector/id-card-illustration_23-2147833318.jpg',
      image: 'https://cdn-icons-png.flaticon.com/512/453/453497.png?w=996&t=st=1684488294~exp=1684488894~hmac=9b33c967ced87a7313135b14f577416b4a527e5b4362fdecfcb0ce00f607fc40',
      isDelivery: true,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .set(model.toMap())
        .then((value) {
      emit(CreateUserSuccessState(userId));
    }).catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }
}
