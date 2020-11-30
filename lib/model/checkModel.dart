import 'package:flutter/material.dart';



class Check {
  String url;
  String storeUrl,versionCeode,version,isActive;

  Check(
      {@required this.url,
        @required this.isActive,
        this.storeUrl,this.version,this.versionCeode
      });


  factory Check.fromJson(Map<String, dynamic> json) {
    return Check(
      url: json['Url'],
      storeUrl: json['StoreUrl'],
      versionCeode: json['VersionCode'].toString(),
      version: json['Version'].toString(),
      isActive: json['IsActive'].toString(),


    );
  }
}
