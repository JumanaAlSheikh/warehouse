import 'dart:ffi';

import 'package:flutter/material.dart';


class ordersList {
  List<ordersAllList> listOrder;
  ordersList({@required this.listOrder});

  factory ordersList.fromJson(List<dynamic> json) {
    return ordersList(

        listOrder: json.map((i) => ordersAllList.fromJson(i)).toList());
  }
}

class ordersAllList {
  String id;
  String PharmacistId,DurgId,Durg,Quantity,Pharmacy,WarehouseId,Warehouse,DeliveryDate,OfferId,OfferDescription,
      RequestType,CreateDate,
      City,RequestStatus,RequestPrice;

  ordersAllList(
      {@required this.id,
        @required this.City,this.DeliveryDate,this.Durg,this.OfferDescription,this.OfferId,this.WarehouseId
        ,this.Warehouse,this.PharmacistId,this.Pharmacy,this.RequestPrice,this.CreateDate,this.Quantity,this.RequestStatus,
        this.RequestType
      });




  factory ordersAllList.fromJson(Map<String, dynamic> json) {
    return ordersAllList(
      id: json['Id'].toString(),
      City:  json['City'].toString(),
      CreateDate: json['CreateDate'],
      DeliveryDate:  json['DeliveryDate'],
      OfferDescription:   json['OfferDescription'].toString(),
      OfferId: json['OfferId'].toString(),

      Durg: json['Durg'].toString(),
      PharmacistId: json['PharmacistId'].toString(),
      Pharmacy:  json['Pharmacy'].toString(),
      RequestPrice: json['RequestPrice'].toString(),
      RequestStatus:   json['RequestStatus'].toString(),
      RequestType:  json['RequestType'].toString(),

      Quantity:   json['Quantity'].toString(),
      Warehouse:   json['Warehouse'].toString(),
      WarehouseId:    json['WarehouseId'].toString(),


    );
  }
}