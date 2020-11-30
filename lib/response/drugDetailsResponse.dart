


import 'package:warehouse/model/drugModelDetails.dart';

class durgDetailsResponse {
  final String code;
  final durgsModelDetails results;
  final String msg;
  final int totalCount;

  durgDetailsResponse(this.results, this.code, this.msg,this.totalCount );

  durgDetailsResponse.fromJson(Map<String, dynamic> json)
      : results = durgsModelDetails.fromJson(json["data"]),

        code = json["code"],
        totalCount = json['totalCount'],

        msg = json['message'];

  durgDetailsResponse.withError(String errorValue)
      : results = null,
        code = "-1",
        totalCount =0,

        msg = "";
}
