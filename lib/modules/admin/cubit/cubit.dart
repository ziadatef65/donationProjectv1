import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationproject/modules/admin/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../models/events_model.dart';

class AdminCubit extends Cubit<AdminStates>{
  AdminCubit(): super(AdminInitialState());
  static AdminCubit get(context) => BlocProvider.of(context);
  EventModel? eventModel;

  File? profileImage;
  final picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      profileImage = File(pickedFile.path);
      emit(EventImagePickedSuccessState());
    }else{
      print('No image selected.');
      emit(EventImagePickedErrorState());
    }
  }
  //////////////////////////////////////////////////////////////////
  void uploadProfileImage(
      String? nameOfEvent,
      )
  {
    emit(UploadImageOfEventLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('events/${Uri.file(profileImage!.path).pathSegments.last}').putFile(profileImage!).then((value){
      value.ref.getDownloadURL().then((dynamic value) {
        emit(UploadImageOfEventLoadingState());
        updateEventImage(
          nameOfEvent: nameOfEvent,
          imageOfEvent:value,
        );
      }).then((value){
        emit(UploadProfileImageSuccessState());

      });
    }).catchError((error){
      emit(UploadProfileImageSuccessState());
    });
  }
  //////////////////////////////////////
  void eventCreate({
    required String nameOfEvent,
    String? image,
  }){

    EventModel model = EventModel(
      nameOfEvent: nameOfEvent,
      imageOfEvent:'https://img.freepik.com/free-vector/error-404-concept-landing-page_52683-21190.jpg',
    );
    emit(CreateEventLoadingState(nameOfEvent));
    FirebaseFirestore.instance
        .collection('events')
        .doc(nameOfEvent).set(model.toMap()).then((value) {
      emit(CreateEventSuccessState(nameOfEvent));
    }).catchError((error){
      emit(CreateEventErrorState(error));
    });
  }
  /////////////////////////
  void updateEventImage({
    String? nameOfEvent,
    String? imageOfEvent,
  })
  {
    emit(UploadImageOfEventLoadingState());
    EventModel model = EventModel(
      nameOfEvent: nameOfEvent,
      imageOfEvent:imageOfEvent?? eventModel!.imageOfEvent,
    );

    FirebaseFirestore.instance.collection('events').doc(nameOfEvent).update(model.toMap()).then((dynamic value) {
      eventModel!.imageOfEvent = value;
      emit(UploadImageOfEventSuccessState());
    }).catchError((error){
      emit(UploadImageOfEventSuccessState());
    });
  }

  ////////////////////////////

  final CollectionReference percentageRef =
  FirebaseFirestore.instance.collection('events');
  void addPercentageOfEvent(String nameOfEvent,dynamic value,) async {
    emit(AddPercentageOfEventLoadingState());
    await percentageRef
        .doc(nameOfEvent)
        .update({'percentage': value}).then((value){
      emit(AddPercentageOfEventSuccessState());
    }).catchError((error){
      emit(AddPercentageOfEventErrorState());
    });
  }

////////////////////////////////////
  final CollectionReference detailRef =
  FirebaseFirestore.instance.collection('events');
  void addDetailsOfEvent(String nameOfEvent,String detail,) async {
    emit(AddDetailsOfEventLoadingState());
    await detailRef
        .doc(nameOfEvent)
        .update({'details': detail}).then((value){
      emit(AddDetailsOfEventSuccessState());
    }).catchError((error){
      emit(AddDetailsOfEventErrorState());
    });
  }

  ///////////////////////////////////////
  final CollectionReference targetRef =
  FirebaseFirestore.instance.collection('events');
  void addTargetOfEvent(String nameOfEvent,dynamic target,) async {
    emit(AddTargetOfEventLoadingState());
    await targetRef
        .doc(nameOfEvent)
        .update({'target': target}).then((value){
      emit(AddTargetOfEventSuccessState());
    }).catchError((error){
      emit(AddTargetOfEventErrorState());
    });
  }
  ///////////////////////////////////////
  final CollectionReference fixedTargetRef =
  FirebaseFirestore.instance.collection('events');
  void addFixedTargetRef(String nameOfEvent,dynamic target,) async {
    emit(AddFixedTargetOfEventLoadingState());
    await fixedTargetRef
        .doc(nameOfEvent)
        .update({'fixedTarget': target}).then((value){
      emit(AddFixedTargetOfEventSuccessState());
    }).catchError((error){
      emit(AddFixedTargetOfEventErrorState());
    });
  }
//////////////////////////////////////////
addInformation(nameOfEvent,value,detail,target,fixedTarget){
  addPercentageOfEvent(nameOfEvent,value);
  addTargetOfEvent(nameOfEvent, target);
  addDetailsOfEvent(nameOfEvent, detail);
  addFixedTargetRef(nameOfEvent, fixedTarget);
  emit(DoneAddInfoSuccessState());
}
///////////////////
  Stream<EventModel> get eventModelStream => FirebaseFirestore.instance
      .collection('events')
      .doc(eventModel?.nameOfEvent)
      .snapshots()
      .map((event) => EventModel.fromJson(event.data()!));
  ///////////////////////////////////////
  int sum = 0;
  Stream<int> calculateSum() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((querySnapshot) {

      querySnapshot.docs.forEach((doc) {
        int numberOfDonationFood = doc['numberOfDonationFood'] ?? 0;
        sum += numberOfDonationFood;
      });
      return sum;
    });
  }


}