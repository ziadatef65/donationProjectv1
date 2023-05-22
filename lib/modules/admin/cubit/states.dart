abstract class AdminStates{}
class AdminInitialState extends AdminStates{}
class UploadLoadingState extends AdminStates{}

class EventImagePickedSuccessState extends AdminStates{}
class EventImagePickedErrorState extends AdminStates{}


class SocialUploadProfileImageErrorState extends AdminStates{}
class SocialUploadProfileImageSuccessState extends AdminStates{}

//
class CreateEventLoadingState extends AdminStates {
  final String nameOfEvent;
  CreateEventLoadingState(this.nameOfEvent);
}
class CreateEventSuccessState extends AdminStates {
  final String nameOfEvent;
  CreateEventSuccessState(this.nameOfEvent);
}
class CreateEventErrorState extends AdminStates{
  final String error;
  CreateEventErrorState(this.error);
}

//

class UploadImageOfEventErrorState extends AdminStates{}
class UploadImageOfEventSuccessState extends AdminStates{}
class UploadImageOfEventLoadingState extends AdminStates{}
//
class AddPercentageOfEventErrorState extends AdminStates{}
class AddPercentageOfEventSuccessState extends AdminStates{}
class AddPercentageOfEventLoadingState extends AdminStates{}
//
//
class AddDetailsOfEventLoadingState extends AdminStates{}
class AddDetailsOfEventSuccessState extends AdminStates{}
class AddDetailsOfEventErrorState extends AdminStates{}
//
class AddTargetOfEventLoadingState extends AdminStates{}
class AddTargetOfEventSuccessState extends AdminStates{}
class AddTargetOfEventErrorState extends AdminStates{}
//
//
class AddFixedTargetOfEventLoadingState extends AdminStates{}
class AddFixedTargetOfEventSuccessState extends AdminStates{}
class AddFixedTargetOfEventErrorState extends AdminStates{}
//

class UploadProfileImageErrorState extends AdminStates{}
class UploadProfileImageSuccessState extends AdminStates{}

////////
class DoneAddInfoSuccessState extends AdminStates{}
