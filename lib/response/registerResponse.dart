class registerResponse {
  final String code;
  final String msg;
  final String data;
  final int totalCount;

  registerResponse(this.code, this.msg, this.data, this.totalCount);

  registerResponse.fromJson(Map<String, dynamic> json)
      : data = json["data"],
        code = json["code"],
        msg = json['message'],
        totalCount = json['totalCount'];

  registerResponse.withError(String errorValue)
      : data = "",
        code = "-1",
        totalCount = 0,
        msg = "";
}
