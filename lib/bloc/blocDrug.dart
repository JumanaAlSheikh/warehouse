
import 'package:rxdart/rxdart.dart';
import 'package:warehouse/repository/drugRepository.dart';
import 'package:warehouse/response/drugDetailsResponse.dart';
import 'package:warehouse/response/drugResponse.dart';
import 'package:warehouse/response/orderREsponseDetails.dart';

class durgsBloc {
  final DurgsRepository _repository = DurgsRepository();
  final BehaviorSubject<DurgsResponse> _subject =
  BehaviorSubject<DurgsResponse>();
  final BehaviorSubject<durgDetailsResponse> _subjectDetails =
  BehaviorSubject<durgDetailsResponse>();

  final BehaviorSubject<orderDetailsResponse> _subjectDetailsOrder =
  BehaviorSubject<orderDetailsResponse>();




  getDurgsDetails(String sessionId,Map<String, dynamic> data,String lang) async {
    print("before get the get med resonse");

    durgDetailsResponse response = await _repository.getDurgDetails(sessionId,data,lang);
    _subjectDetails.sink.add(response);

    print("after get the get med resonse \n ${response.results}");


  }


  getOrderDetails(String sessionId,Map<String, dynamic> data,String lang) async {
    print("before get the get med resonse");

    orderDetailsResponse response = await _repository.getOrderDetails(sessionId,data,lang);
    _subjectDetailsOrder.sink.add(response);

    print("after get the get med resonse \n ${response.results}");


  }


  dispose() {
    _subject.close();
    _subjectDetails.close();
    _subjectDetailsOrder.close();
  }

  BehaviorSubject<DurgsResponse> get subject => _subject;
  BehaviorSubject<durgDetailsResponse> get subjectdetails => _subjectDetails;
  BehaviorSubject<orderDetailsResponse> get subjectdetailsOrder => _subjectDetailsOrder;

}

final blocDurgs= durgsBloc();