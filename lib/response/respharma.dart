


import 'package:warehouse/model/modelOrderGen.dart';
import 'package:warehouse/model/orderItem.dart';

class respharm {
  final pharmasAllList results;
  final OrderList resultsOrder;


  respharm(this.results,this.resultsOrder );

  respharm.fromJson(Map<String, dynamic> json)
      : results = pharmasAllList.fromJson(json["Pharmacist"]),
        resultsOrder = OrderList.fromJson(json["OrderItems"]) ;


        respharm.withError(String errorValue)
      : results = null,resultsOrder=null;

}
