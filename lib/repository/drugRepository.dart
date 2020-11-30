
import 'package:warehouse/response/orderREsponseDetails.dart';
import 'package:warehouse/apiProvider/drugApiProvider.dart';
import 'package:warehouse/response/drugDetailsResponse.dart';
import 'package:warehouse/response/drugResponse.dart';
import 'package:warehouse/response/offerResponse.dart';
import 'package:warehouse/response/orderResponse.dart';
import 'package:warehouse/response/registerResponse.dart';
import 'package:warehouse/response/registerResponse.dart';

class DurgsRepository {
  DurgsApiProvider _apiProvider = DurgsApiProvider();

  Future<DurgsResponse> getDurgsLisy(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.getDurgsList(sessionId,data,lang);

  }

  Future<DurgsResponse> getMyDrugList(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.getMyDurgsList(sessionId,data,lang);

  }

  Future<OfferResponse> getOfferList(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.getOfferList(sessionId,data,lang);

  }
  Future<registerResponse> addDrugToWare(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.addDrugToWare(sessionId,data,lang);

  }



  Future<registerResponse> changeStatus(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.changeStatus(sessionId,data,lang);

  }



  Future<registerResponse> chacnePass(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.chacngePass(sessionId,data,lang);

  }

  Future<registerResponse> setLocation(String sessionId,Map<String, dynamic> data) {
    return _apiProvider.setLocation(sessionId,data);

  }

  Future<registerResponse> addDeleviry(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.addDeleviry(sessionId,data,lang);

  }

  Future<registerResponse> addOffer(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.addOffer(sessionId,data,lang);

  }
  Future<registerResponse> editOffer(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.editOffer(sessionId,data,lang);

  }


  Future<registerResponse> deleteDrugToWare(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.deleteDrug(sessionId,data,lang);

  }



  Future<registerResponse> deleteOffer(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.deleteOffer(sessionId,data,lang);

  }

  Future<OrderResponse> getOrderList(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.getOrderList(sessionId,data,lang);

  }


  Future<durgDetailsResponse> getDurgDetails(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.getDurgDetails(sessionId,data,lang);

  }

  Future<orderDetailsResponse> getOrderDetails(String sessionId,Map<String, dynamic> data,String lang) {
    return _apiProvider.getOrderDetails(sessionId,data,lang);

  }



}