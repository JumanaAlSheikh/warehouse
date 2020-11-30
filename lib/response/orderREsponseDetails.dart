


import 'package:warehouse/model/drugModelDetails.dart';
import 'package:warehouse/response/respharma.dart';

class orderDetailsResponse {
  final String code;
  final respharm results;
  final String msg;
  final int totalCount;

  orderDetailsResponse(this.results, this.code, this.msg,this.totalCount );

  orderDetailsResponse.fromJson(Map<String, dynamic> json)
      : results = respharm.fromJson(json["data"]),

        code = json["code"],
        totalCount = json['totalCount'],

        msg = json['message'];

  orderDetailsResponse.withError(String errorValue)
      : results = null,
        code = "-1",
        totalCount =0,

        msg = "";
}
