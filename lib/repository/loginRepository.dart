

import 'package:dio/dio.dart';
import 'package:warehouse/apiProvider/logApiProvider.dart';
import 'package:warehouse/response/loginResponse.dart';


class LoginRepository {
  LogApiProvider _apiProvider = LogApiProvider();

 /* Future<CityResponse> getCity() {
    return _apiProvider.getCity();

  }*/

 /* Future<registerResponse> register(Map<String, dynamic> data) {
    return _apiProvider.Register(data);

  }*/
  Future<loginResponse> login(Map<String, dynamic> data,String lang) {
    return _apiProvider.login(data,lang);

  }


  /*Future<loginResponse> getMyProfile(String sessionId) {
    return _apiProvider.getMyProfile(sessionId);

  }

  Future<registerResponse> verfyAccount(Map<String, dynamic> data) {
    return _apiProvider.VerfyAccount(data);

  }
  Future<registerResponse> getCodeForget(Map<String, dynamic> data) {
    return _apiProvider.VerfyAccount(data);

  }*/
/*
  Future<registerResponse> changePass(String sessionId,Map<String, dynamic> data) {
    return _apiProvider.changePas(sessionId,data);

  }

  Future<registerResponse> ForgetPass(Map<String, dynamic> data) {
    return _apiProvider.ForgetPass(data);

  }
*/

}