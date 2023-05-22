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
class GetOrdersLoadingState extends DonationStates{}
class GetOrdersSuccessState extends DonationStates{}
class GetOrdersErrorState extends DonationStates{
  final String error;

  GetOrdersErrorState(this.error);
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
//
class CreateOrderSuccessState extends DonationStates{}
class CreateOrderLoadingState extends DonationStates{}
class CreateOrderErrorState extends DonationStates{}
//
//
class UpdateOrderSuccessState extends DonationStates{}
class UpdateOrderErrorState extends DonationStates{}

//
//
class DoneOrderSuccessState extends DonationStates{}
class DoneOrderErrorState extends DonationStates{}
//
//
class DeleteOrderSuccessState extends DonationStates{}
class DeleteOrderErrorState extends DonationStates{}
//
//
class IncreaseNumberOfDonationSuccessState extends DonationStates{}
class IncreaseNumberOfDonationErrorState extends DonationStates{}
//