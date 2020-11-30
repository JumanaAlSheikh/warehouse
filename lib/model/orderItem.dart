import 'dart:ffi';

import 'package:flutter/material.dart';


class OrderList {
  List<orderModelDetail> listOrder;
  OrderList({@required this.listOrder});

  factory OrderList.fromJson(List<dynamic> json) {
    return OrderList(

        listOrder: json.map((i) => orderModelDetail.fromJson(i)).toList());
  }
}

class orderModelDetail {
  String id,drugId,drugName,Manufacture;
  String gift,quantity,offerId,offerDes,price,subPrice,subTotalPrice;


  // "stores": []
  orderModelDetail(
      {@required this.id,
        @required this.quantity,this.gift,this.price,this.offerId,this.drugName,this.offerDes,this.subPrice,this.Manufacture,this.drugId,
        this.subTotalPrice
      });


  factory orderModelDetail.fromJson(Map<String, dynamic> json) {
    return orderModelDetail(
      id: json['Id'].toString(),
      drugName: json['Drug'],
      gift: json['Gift'].toString(),
      quantity: json['Quantity'].toString(),
      offerId: json['OfferId'].toString(),
      offerDes: json['OfferDescription'].toString(),
      price: json['Price'].toString(),
      subPrice: json['SecondPrice'].toString(),
drugId: json['DrugId'].toString(),
      Manufacture: json['Manufacture'].toString(),
      subTotalPrice: json['SubTotalPrice'].toString(),


    );
  }
}