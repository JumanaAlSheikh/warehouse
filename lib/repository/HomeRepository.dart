




import 'package:warehouse/apiProvider/homeApiProvider.dart';
import 'package:warehouse/response/checkResponse.dart';

class HomeRepository {
  HomeApiProvider _apiProvider = HomeApiProvider();





  Future<checkResponse> checkForUpdate(String sessionId,String versionC,String lang) {
    return _apiProvider.checkForUpdate(sessionId,versionC,lang);

  }




}