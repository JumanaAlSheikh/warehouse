


import 'package:warehouse/model/checkModel.dart';

class checkResponse {
  final String code;
  final Check results;
  final String msg;

  checkResponse(this.results, this.code, this.msg );

  checkResponse.fromJson(Map<String, dynamic> json)
      : results = Check.fromJson(json["data"]),

        code = json["code"],
        msg = json['message'];

  checkResponse.withError(String errorValue)
      : results = null,
        code = "-1",
        msg = "";
}
