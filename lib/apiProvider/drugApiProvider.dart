import 'package:dio/dio.dart';
import 'package:warehouse/response/drugDetailsResponse.dart';
import 'package:warehouse/response/drugResponse.dart';
import 'package:warehouse/response/offerResponse.dart';
import 'package:warehouse/response/orderResponse.dart';
import 'package:warehouse/response/orderREsponseDetails.dart';

import 'package:warehouse/response/registerResponse.dart';

class DurgsApiProvider {
  Dio _dio = Dio();

  DurgsApiProvider() {
    _dio.interceptors.clear();
    _dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // Do something before request is sent
      options.headers["Content-Type"] = "application/json";
      return options;
    }, onResponse: (Response response) {
      // Do something with response data
      return response; // continue
    }, onError: (DioError error) async {
      // Do something with response error
      if (error.response?.statusCode == 403) {
        _dio.interceptors.requestLock.lock();
        _dio.interceptors.responseLock.lock();
        RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
        options.headers["Content-Type"] = "application/json";

        _dio.interceptors.requestLock.unlock();
        _dio.interceptors.responseLock.unlock();
        return _dio.request(options.path, options: options);
      } else {
        return error;
      }
    }));
  }

  String _handleError(DioError error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
          "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.RESPONSE:
          "${error.response.data['message']}";
          break;
//        case DioErrorType.SEND_TIMEOUT:
//          errorDescription =
//              "Send Request to Server Timeout: ${error.response.statusCode}";
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  Future<DurgsResponse> getDurgsList(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;


        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/DrugsAdmin/LoadDrugsList",data: data);
      return DurgsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DurgsResponse.withError(_handleError(error));
    }
  }
  Future<DurgsResponse> getMyDurgsList(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    print(lang);
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/DrugsAdmin/LoadWarehouseDrugsList",data: data);
      print(response);
      return DurgsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return DurgsResponse.withError(_handleError(error));
    }
  }
  Future<OfferResponse> getOfferList(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/OffersAdmin/LoadOffersList",data: data);
      print(response);
      return OfferResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return OfferResponse.withError(_handleError(error));
    }
  }
  Future<registerResponse> addDrugToWare(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/WarehousesAdmin/LinkDrugToWarehouse",data: data);
      return registerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return registerResponse.withError(_handleError(error));
    }
  }
  Future<registerResponse> changeStatus(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;

          options.headers["Accept-Language"] = lang;
          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/OrdersAdmin/ChangeOrderStatus",data: data);
      return registerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return registerResponse.withError(_handleError(error));
    }
  }


  Future<registerResponse> addDeleviry(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/WarehousesAdmin/EditMyWarehouse",data: data);
      return registerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return registerResponse.withError(_handleError(error));
    }
  }





  Future<registerResponse> chacngePass(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/WarehousesAdmin/ChangeMyWarehousePassword",data: data);
      return registerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return registerResponse.withError(_handleError(error));
    }
  }


  Future<registerResponse> setLocation(String sessionId,Map<String, dynamic> data) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = 'en';

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = 'en';

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/WarehousesAdmin/EditMyWarehouseLocation",data: data);
      print(response);
      return registerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return registerResponse.withError(_handleError(error));
    }
  }


  Future<registerResponse> addOffer(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/OffersAdmin/AddOffer",data: data);
      return registerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return registerResponse.withError(_handleError(error));
    }
  }
  Future<registerResponse> editOffer(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/OffersAdmin/EditOffer",data: data);
      return registerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return registerResponse.withError(_handleError(error));
    }
  }

  Future<registerResponse> deleteDrug(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/WarehousesAdmin/UnLinkDrugFromWarehouse",data: data);
      return registerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return registerResponse.withError(_handleError(error));
    }
  }

  Future<registerResponse> deleteOffer(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/OffersAdmin/ChangeOfferStatus",data: data);
      return registerResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return registerResponse.withError(_handleError(error));
    }
  }


  Future<OrderResponse> getOrderList(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/OrdersAdmin/LoadOrderList",data: data);
      print(response);
      return OrderResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return OrderResponse.withError(_handleError(error));
    }
  }


  Future<durgDetailsResponse> getDurgDetails(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/DrugsAdmin/DrugDetails",data: data);
      return durgDetailsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return durgDetailsResponse.withError(_handleError(error));
    }
  }
  Future<orderDetailsResponse> getOrderDetails(String sessionId,Map<String, dynamic> data,String lang) async {
    Response response;
    try {
      _dio.interceptors.clear();
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
        // Do something before request is sent
        options.headers["Content-Type"] = "application/json";
        options.headers["Session-ID"] = sessionId;
        options.headers["Accept-Language"] = lang;

        return options;
      }, onResponse: (Response response) {
        // Do something with response data
        return response; // continue
      }, onError: (DioError error) async {
        // Do something with response error
        if (error.response?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();
          RequestOptions options = error.response.request;
//          FirebaseUser user = await FirebaseAuth.instance.currentUser();
//          token = await user.getIdToken(refresh: true);
//          await writeAuthKey(token);
          options.headers["Content-Type"] = "application/json";
          options.headers["Session-ID"] = sessionId;
          options.headers["Accept-Language"] = lang;

          _dio.interceptors.requestLock.unlock();
          _dio.interceptors.responseLock.unlock();
          return _dio.request(options.path, options: options);
        } else {
          return error;
        }
      }));
      response = await _dio.post(
          "http://api.mypharma-order.com:8080/APIS/api/OrdersAdmin/GetOrderDetails",data: data);
      print(response);
      return orderDetailsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return orderDetailsResponse.withError(_handleError(error));
    }
  }


}



