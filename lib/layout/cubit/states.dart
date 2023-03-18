abstract class DonationStates{}
class DonationInitialState extends DonationStates{}

//
class ChangeBottomNavState extends DonationStates{}
//

//
class GetUserLoadingState extends DonationStates{}
class GetUserSuccessState extends DonationStates{}
class GetUserErrorState extends DonationStates{
  final String error;

  GetUserErrorState(this.error);
}
//


//
class ProfileImagePickedSuccessState extends DonationStates{}
class ProfileImagePickedErrorState extends DonationStates{}
//

//
class UploadProfileImageSuccessState extends DonationStates{}
class UploadProfileImageErrorState extends DonationStates{}
//

//
class UserUpdateError extends DonationStates{}
class UserUpdateLoading extends DonationStates{}
class UploadLoadingState extends DonationStates{}
//
//
class UpdateSuccessState extends DonationStates{}
class UpdateErrorState extends DonationStates{}
//