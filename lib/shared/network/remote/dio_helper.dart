import 'package:dio/dio.dart';
import 'package:donationproject/shared/network/const.dart';

class DioHelper{
  static late Dio dio;
  static initDio(){
    dio = Dio(
      BaseOptions(
        baseUrl: ApiContest.baseUrl,
        headers: {
          'content-Type':'application/json',
        },
        receiveDataWhenStatusError: true,
      )
    );
  }
  static Future<Response> postDataDio({Map<String,dynamic>? data,required String url})async{
    return await dio.post(url,data: data);
  }
}