class ApiContest{
  // https://accept.paymob.com/api/auth/tokens
  static  String baseUrl ='https://accept.paymob.com/api';
  static  String getAuthToken ='/auth/tokens';
  static  String paymentApiKey ='ZXlKaGJHY2lPaUpJVXpVeE1pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SmpiR0Z6Y3lJNklrMWxjbU5vWVc1MElpd2ljSEp2Wm1sc1pWOXdheUk2TnpneU5Ua3pMQ0p1WVcxbElqb2lhVzVwZEdsaGJDSjkuYjZTNHJWWTJ4TDJhMGpkXzUtRlFkQzVLTm5IZm1BZ21LSW5FZzdzMXFnbXRoVnBrbldZcC1QTUdSSnBueWFyQmZERzRSRTVBRGo0bUpNd1hVX2ZKUHc=';
  static  String getOrderId ='/ecommerce/orders';
  static  String getPaymentId ='/acceptance/payment_keys';
  static  String paymentFirstToken ='';
  static  String paymentOrderId ='';
  static  String integrationIdCart ='3797054';
  static  String finalToken ='';
  static  String visaUrl ='$baseUrl/acceptance/iframes/758879?payment_token=$finalToken';
}