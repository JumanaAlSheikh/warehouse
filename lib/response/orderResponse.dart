


import 'package:warehouse/model/orderHomeModel.dart';

class OrderResponse {
  // final String code;
  final ordersList results;
  //final String msg;
  //final int totalCount;

  OrderResponse(this.results);

  OrderResponse.fromJson(Map<String, dynamic> json)
      : results = ordersList.fromJson(json["data"]);

  /*code = json["code"],
        totalCount = json['totalCount'],

        msg = json['message'];*/

  OrderResponse.withError(String errorValue)
      : results = null;
/*  code = "-1",
        totalCount =0,

        msg = "";*/
}
