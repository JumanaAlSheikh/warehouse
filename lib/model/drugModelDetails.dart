import 'dart:ffi';

import 'package:flutter/material.dart';



class durgsModelDetails {
  String id;
  String CommerceNameAr,CommerceNameEn,ScientificNameEn,ScientificNameAr,Strengths,Price,Category,Manufacture,Icon;

  // "stores": []
  durgsModelDetails(
      {@required this.id,
        @required this.CommerceNameEn,this.ScientificNameEn,this.ScientificNameAr,this.CommerceNameAr,this.Strengths,this.Price,this.Category,this.Manufacture,this.Icon
      });

  factory durgsModelDetails.fromJson(Map<String, dynamic> json) {
    return durgsModelDetails(
      id: json['Id'].toString(),
      CommerceNameAr: json['CommerceNameAr'],
      CommerceNameEn: json['CommerceNameEn'],
      ScientificNameEn: json['ScientificNameEn'],

      ScientificNameAr: json['ScientificNameAr'],
      Strengths: json['Strengths'].toString(),
      Price: json['Price'].toString(),
      Category: json['Category'],
      Manufacture: json['Manufacture'],
      Icon: json['Icon'],


    );
  }
}