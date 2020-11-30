


import 'package:warehouse/model/offerHomeModel.dart';

class OfferResponse {
  // final String code;
  final offersList results;
  //final String msg;
  //final int totalCount;

  OfferResponse(this.results);

  OfferResponse.fromJson(Map<String, dynamic> json)
      : results = offersList.fromJson(json["data"]);

  /*code = json["code"],
        totalCount = json['totalCount'],

        msg = json['message'];*/

  OfferResponse.withError(String errorValue)
      : results = null;
/*  code = "-1",
        totalCount =0,

        msg = "";*/
}
