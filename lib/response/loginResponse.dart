
import 'package:warehouse/model/userModel.dart';

class loginResponse {
  final String code;
  final String msg;
  final int totalCount;
  final User data;

  loginResponse(this.code, this.msg, this.data, this.totalCount);

  loginResponse.fromJson(Map<String, dynamic> json)
      :
        data = User.fromJson(json["data"]),
        code = json["code"],
        msg = json['message'],
        totalCount = json['totalCount'];

  loginResponse.withError(String errorValue)
      : data = null,
        code = "-1",
        totalCount = 0,
        msg = "";
}
