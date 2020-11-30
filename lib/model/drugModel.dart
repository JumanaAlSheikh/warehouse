import 'dart:ffi';

import 'package:flutter/material.dart';


class durgsList {
  List<durgsAllList> listdurgs;
  durgsList({@required this.listdurgs});

  factory durgsList.fromJson(List<dynamic> json) {
    return durgsList(

        listdurgs: json.map((i) => durgsAllList.fromJson(i)).toList());
  }
}

class durgsAllList {
  String id,form;
  String CommerceNameAr,CommerceNameEn,ScientificNameAr,ScientificNameEn,Strengths,Price,SecondPrice,Category,Manufacture,Icon,avalible,isoffer;

  durgsAllList(
      {@required this.id,
        @required this.CommerceNameAr,this.avalible,this.ScientificNameEn,this.CommerceNameEn,this.isoffer,this.ScientificNameAr
        ,this.Strengths,this.Price,this.Category,this.Manufacture,this.Icon,this.SecondPrice,this.form
      });



  factory durgsAllList.fromJson(Map<String, dynamic> json) {
    return durgsAllList(
      id: json['Id'].toString(),
      CommerceNameEn: json['CommerceNameEn'],
      CommerceNameAr: json['CommerceNameAr'],
      ScientificNameEn: json['ScientificNameEn'],
      avalible: json['AvaiableInWarehouse'].toString(),
      isoffer: json['HasOffer'].toString(),

      ScientificNameAr: json['ScientificNameAr'],
      Strengths: json['Strengths'].toString(),
      Price: json['Price'].toString(),
      SecondPrice:json['SecondPrice'].toString(),
      Category: json['Category'],
      Manufacture: json['Manufacture'],
      Icon: json['Icon'],
      form: json['Form'],


    );
  }
}