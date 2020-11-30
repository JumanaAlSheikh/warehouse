import 'dart:ffi';

import 'package:flutter/material.dart';


class offersList {
  List<offersAllList> listOffer;
  offersList({@required this.listOffer});

  factory offersList.fromJson(List<dynamic> json) {
    return offersList(

        listOffer: json.map((i) => offersAllList.fromJson(i)).toList());
  }
}

class offersAllList {
  String id;
  String Description,DurgId,Durg,Quantity,Price,Duration,WarehouseId,Warehouse,CreateDate,Status,Gift,Notes,Manufacture,
      ExpiryDate,Discount,TotalPrice,NormalPrice;

  offersAllList(
      {@required this.id,
        @required this.Status,this.TotalPrice,this.Durg,this.Discount,this.Gift,this.WarehouseId
        ,this.Warehouse,this.Price,this.ExpiryDate,this.Manufacture,this.CreateDate,this.Quantity,this.Notes,this.NormalPrice,this.Description,
        this.DurgId,this.Duration
      });



  factory offersAllList.fromJson(Map<String, dynamic> json) {
    return offersAllList(
      id: json['Id'].toString(),
      Status: json['Status'].toString(),
      CreateDate: json['CreateDate'],
      Description: json['Description'],
      Discount:  json['Discount'].toString(),
      Duration: json['Duration'].toString(),

      Durg: json['Durg'].toString(),
      DurgId: json['DurgId'].toString(),
      Price: json['Price'].toString(),
      ExpiryDate:json['ExpiryDate'].toString(),
      Gift:  json['Gift'].toString(),
      Manufacture: json['Manufacture'],
      NormalPrice:  json['NormalPrice'].toString(),
      Notes:  json['Notes'].toString(),
      Quantity:   json['Quantity'].toString(),
      TotalPrice:   json['TotalPrice'].toString(),
      Warehouse:   json['Warehouse'].toString(),
      WarehouseId:    json['WarehouseId'].toString(),


    );
  }
}