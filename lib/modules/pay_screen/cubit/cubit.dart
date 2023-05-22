import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationproject/models/user_model.dart';
import 'package:donationproject/modules/pay_screen/cubit/states.dart';
import 'package:donationproject/shared/network/const.dart';
import 'package:donationproject/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCubit extends Cubit<PaymentStates>
{
  PaymentCubit():super(PaymentInitialState());
  static PaymentCubit get(context) => BlocProvider.of(context);
UserModel? model;

  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingState());
    DioHelper.postDataDio(url: ApiContest.getAuthToken,data: {
      "api_key" : ApiContest.paymentApiKey,
    }).then((value) {
      ApiContest.paymentFirstToken = value.data['token'];
      print('${ApiContest.paymentFirstToken}');
      emit(PaymentAuthSuccessState());
    }).catchError((error){
      emit(PaymentAuthErrorState());
    });
      }
/////////////////////////////////////////
  Future getOrder({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required dynamic price,
})async{
emit(GetOrderLoadingState());
DioHelper.postDataDio(url: ApiContest.getOrderId,data: {
  'auth_token': ApiContest.paymentFirstToken,
  "delivery_needed": "false",
  "amount_cents": price+"00",
  "currency": "EGP",
  "items": [],

},).then((value) {
  ApiContest.paymentOrderId = value.data['id'].toString();
  getPaymentRequest( price: price,firstName: firstName,lastName: lastName,phone: phone,email: email);
  emit(GetOrderSuccessState());
}).catchError((error){
  print(error.toString());
  emit(PaymentAuthErrorState());

});
}
/////////////////////////////////////////
Future<void>getPaymentRequest({
  String? firstName,
  String? lastName,
  String? email,
  String? phone,
  required String price,
})async{
emit(PaymentRequestLoadingState());
DioHelper.postDataDio(url: ApiContest.getPaymentId,data: {
"auth_token": ApiContest.paymentFirstToken,
"amount_cents": price,
"expiration": 3500,
"order_id": ApiContest.paymentOrderId,
"billing_data": {
"apartment": "NA",
"email": email,
"floor": "NA",
"first_name": firstName,
"street": "NA",
"building": "NA",
"phone_number": phone,
"shipping_method": "NA",
"postal_code": "NA",
"city": "NA",
"country": "NA",
"last_name": lastName,
"state": "NA"
},
"currency": "EGP",
"integration_id": ApiContest.integrationIdCart,
"lock_order_when_paid": "false"
},
).then((value) {
  ApiContest.finalToken =value.data['token'];
  print(ApiContest.finalToken);
  emit(PaymentRequestSuccessState());
}).catchError((error){
  print(error.toString());
  emit(PaymentRequestErrorState());
});
}
////////////////////////////////////////////////////

}