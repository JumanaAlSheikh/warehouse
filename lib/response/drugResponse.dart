


import 'package:warehouse/model/drugModel.dart';

class DurgsResponse {
 // final String code;
  final durgsList results;
  //final String msg;
  //final int totalCount;

  DurgsResponse(this.results);

  DurgsResponse.fromJson(Map<String, dynamic> json)
      : results = durgsList.fromJson(json["data"]);

        /*code = json["code"],
        totalCount = json['totalCount'],

        msg = json['message'];*/

  DurgsResponse.withError(String errorValue)
      : results = null;
      /*  code = "-1",
        totalCount =0,

        msg = "";*/
}
