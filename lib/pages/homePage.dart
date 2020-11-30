import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:warehouse/lang/localss.dart';
import 'package:warehouse/pages/orderDetails.dart';
import 'package:warehouse/pages/splashPage.dart';
import 'package:warehouse/response/registerResponse.dart';
import 'package:warehouse/pages/addOffer.dart';
import 'package:warehouse/pages/editOffer.dart';
import 'package:warehouse/pages/offerDetails.dart';
import 'package:warehouse/pages/profile.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/model/drugModel.dart';
import 'package:warehouse/model/orderHomeModel.dart';
import 'package:warehouse/pages/durgDetails.dart';
import 'package:warehouse/repository/drugRepository.dart';
import 'package:warehouse/response/drugResponse.dart';
import 'package:warehouse/model/offerHomeModel.dart';
import 'package:warehouse/response/offerResponse.dart';
import 'package:warehouse/response/orderResponse.dart';

class homePage extends StatefulWidget {
  @override
  _homePage createState() => new _homePage();
}

class _homePage extends State<homePage> {
  ProgressDialog pr;
  String sessionId;
  GlobalKey<FormState> _keyFormDeposit = GlobalKey();

  List<durgsAllList> tListallDrug;
  var itemsDrug = List<durgsAllList>();
  List<durgsAllList> tListDrug;
  List<durgsAllList> drugList;
  DurgsResponse responseDrug;
  final _pass = new TextEditingController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKeyOf =
  new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKeyOr =
  new GlobalKey<RefreshIndicatorState>();
  var fromdate = GlobalKey<FormState>();
  String dateD;
  String wareId;
  String ischange;
  List<durgsAllList> tListallDrugMy;
  var itemsDrugMy = List<durgsAllList>();
  List<durgsAllList> tListDrugMy;
  List<durgsAllList> drugListMy;
  DurgsResponse responseDrugMy;
  final _geneP = new TextEditingController();
  final _pharmaP = new TextEditingController();

  List<offersAllList> tListallOffer;
  var itemsOffer = List<offersAllList>();
  List<offersAllList> tListOffer;
  List<offersAllList> drugListOffer;
  OfferResponse responseOffer;

  List<ordersAllList> tListallOrder;
  var itemsOrder = List<ordersAllList>();
  List<ordersAllList> tListOrder;
  List<ordersAllList> drugListOrder;
  OrderResponse responseOrder;
  intl.DateFormat dateFormat ;

  int _current = 0;
  bool activeSearchDrug = false;
  bool activeSearchOffer = false;
  bool activeSearchOrder = false;

  TextEditingController editingControllerDrug = TextEditingController();
  bool activeSearchMyDrug = false;
  TextEditingController editingControllerMyDrug = TextEditingController();
  TextEditingController editingControllerOffer = TextEditingController();
  TextEditingController editingControllerOrder = TextEditingController();

  var preferences;

  ScrollController _scDrug = new ScrollController();
  ScrollController _scMyDrug = new ScrollController();
  ScrollController _scOffer = new ScrollController();
  ScrollController _scOrder = new ScrollController();

  static int page = 10;
  bool isLoadingDrug = false;
  bool isLoadingMyDrug = false;
  bool isLoadingMyOffer = false;
  bool isLoadingMyOrder = false;
  static int pageMy = 10;
  static int pageOrder = 10;
  static int pageOffer = 10;
  SpecificLocalizationDelegate _specificLocalizationDelegate;
  String langSave;
  Future navigationPage() async {
    var preferences = await SharedPreferences.getInstance();

    langSave = preferences.getString('lang');
    print("lang saved == $langSave");
    //langSave=lang1;
    if (langSave == 'ar') {
      _specificLocalizationDelegate =
          SpecificLocalizationDelegate(new Locale("ar"));

      AppLocalizations.load(new Locale("ar"));


    } else {
      _specificLocalizationDelegate =
          SpecificLocalizationDelegate(new Locale("en"));
      AppLocalizations.load(new Locale("en"));


    }
  }
  Widget _buildProgressIndicatorDrug() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoadingDrug ? 1.0 : 00,
          child: new CircularProgressIndicator( valueColor:
          new AlwaysStoppedAnimation<Color>(Colors.praimarydark)),
        ),
      ),
    );
  }



  Widget _buildProgressIndicatorMyOffer() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoadingMyOffer ? 1.0 : 00,
          child: new CircularProgressIndicator( valueColor:
          new AlwaysStoppedAnimation<Color>(Colors.praimarydark)),
        ),
      ),
    );
  }

  Widget _buildProgressIndicatorMyOrder() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoadingMyOrder ? 1.0 : 00,
          child: new CircularProgressIndicator( valueColor:
          new AlwaysStoppedAnimation<Color>(Colors.praimarydark)),
        ),
      ),
    );
  }

  void filterSearchResultsDrug(String query) {
    activeSearchDrug = true;

    List<durgsAllList> dummySearchList = List<durgsAllList>();
    dummySearchList.addAll(tListallDrug);
    if (query.isNotEmpty) {
      List<durgsAllList> dummyListData = List<durgsAllList>();
      dummySearchList.forEach((item) {
        if (item.CommerceNameEn.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        itemsDrug.clear();
        itemsDrug.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        itemsDrug.clear();
        itemsDrug.addAll(tListallDrug);
      });
    }
  }

  void filterSearchResultsMyDrug(String query) {
    activeSearchMyDrug = true;

    List<durgsAllList> dummySearchList = List<durgsAllList>();
    dummySearchList.addAll(tListallDrugMy);
    if (query.isNotEmpty) {
      List<durgsAllList> dummyListData = List<durgsAllList>();
      dummySearchList.forEach((item) {
        if (item.CommerceNameEn.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        itemsDrugMy.clear();
        itemsDrugMy.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        itemsDrugMy.clear();
        itemsDrugMy.addAll(tListallDrugMy);
      });
    }
  }

  void filterSearchResultsMyOffer(String query) {
    activeSearchOffer = true;

    List<offersAllList> dummySearchList = List<offersAllList>();
    dummySearchList.addAll(tListallOffer);
    if (query.isNotEmpty) {
      List<offersAllList> dummyListData = List<offersAllList>();
      dummySearchList.forEach((item) {
        if (item.Durg.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        itemsOffer.clear();
        itemsOffer.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        itemsOffer.clear();
        itemsOffer.addAll(tListallOffer);
      });
    }
  }

  void filterSearchResultsMyOrder(String query) {
    activeSearchOrder = true;

    List<ordersAllList> dummySearchList = List<ordersAllList>();
    dummySearchList.addAll(tListallOrder);
    if (query.isNotEmpty) {
      List<ordersAllList> dummyListData = List<ordersAllList>();
      dummySearchList.forEach((item) {
        if (item.Pharmacy.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        itemsOrder.clear();
        itemsOrder.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        itemsOrder.clear();
        itemsOrder.addAll(tListallOrder);
      });
    }
  }

  String text = 'Offer';



  _buildSubmitFormCoPass(BuildContext context) async {
    pr.show();
    var preferences = await SharedPreferences.getInstance();
    String sessionId = preferences.getString('sessionId');
    String wareid = preferences.getString('id');

    Map<String, dynamic> data = {
      "Id":wareid,
      "Password": _pass.text
    };
    //  ProjectBloc().addProjectRevnue(data);
    // BankBloc().addBankCommission(data);
    print(data);
    final DurgsRepository _repository = DurgsRepository();
    registerResponse response =
    await _repository.chacnePass(sessionId, data,langSave);

    //  GeneralResponse response = await _repository.addProjectRevnue(data);
    if (response.code == '1') {

      pr.hide().then((isHidden) {
        print(isHidden);
      });


      var preferences = await SharedPreferences.getInstance();

      preferences.remove('sessionId');

      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => Directionality(
            textDirection:
            langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child:Splash()),
        ),
      );

    } else {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      Toast.show(
          response.msg.toString(),
          context,
          duration: 4,
          gravity: Toast.BOTTOM);
    }
  }

  _getMoreDataOffer(int index) async {
    tListOffer = new List();
    if (!isLoadingMyOffer) {
      setState(() {
        isLoadingMyOffer = true;
      });

      preferences = await SharedPreferences.getInstance();
      sessionId = preferences.getString('sessionId');
      Map<String, dynamic> data = {
        "draw": 1,
        "columns": [
          {
            "data": "name",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "country",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "",
            "name": "",
            "searchable": "false",
            "orderable": "false",
            "search": {"value": "", "regex": "false"}
          }
        ],
        "order": [
          {"column": "1", "dir": "desc"}
        ],
        "length": 10,
        "start": pageOffer,
        "Search": {"value": "", "regex": "false"},
      };
      final DurgsRepository _repository = DurgsRepository();

      responseOffer = await _repository.getOfferList(sessionId, data,langSave);
//offerList = response.results.offers.listOffer;
      //   response = blocOffer.getOfferList(sessionId, data);
      //  if (responseDrug.code == '1') {
      for (int i = 0; i <= responseOffer.results.listOffer.length; i++) {
        tListOffer = new List.from(responseOffer.results.listOffer);
        //  tList.add(offerList[i]);
      }

      setState(() {
        isLoadingMyOffer = false;
        //  offerList.addAll(tList);
        //  offerList= new List.from(tList,tListall);
        if (tListallOffer == null) {
          tListallOffer = drugListOffer + tListOffer;
        } else {
          tListallOffer = tListallOffer + tListOffer;
        }

        pageOffer = pageOffer + 10;
      });
    }
  }

  _getMoreDataOrder(int index) async {
    tListOrder = new List();
    if (!isLoadingMyOrder) {
      setState(() {
        isLoadingMyOrder = true;
      });

      preferences = await SharedPreferences.getInstance();
      sessionId = preferences.getString('sessionId');
      Map<String, dynamic> data = {
        "draw": 1,
        "columns": [
          {
            "data": "name",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "country",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "",
            "name": "",
            "searchable": "false",
            "orderable": "false",
            "search": {"value": "", "regex": "false"}
          }
        ],
        "order": [
          {"column": "1", "dir": "desc"}
        ],
        "length": 10,
        "start": pageOrder,
        "Search": {"value": "", "regex": "false"},
      };
      final DurgsRepository _repository = DurgsRepository();

      responseOrder = await _repository.getOrderList(sessionId, data,langSave);
//offerList = response.results.offers.listOffer;
      //   response = blocOffer.getOfferList(sessionId, data);
      //  if (responseDrug.code == '1') {
      for (int i = 0; i <= responseOrder.results.listOrder.length; i++) {
        tListOrder = new List.from(responseOrder.results.listOrder);
        //  tList.add(offerList[i]);
      }

      setState(() {
        isLoadingMyOrder = false;
        //  offerList.addAll(tList);
        //  offerList= new List.from(tList,tListall);
        if (tListallOrder == null) {
          tListallOrder = drugListOrder + tListOrder;
        } else {
          tListallOrder = tListallOrder + tListOrder;
        }

        pageOrder = pageOrder + 10;
      });
    }
  }

  Widget showDialogwindowAddPass() {
    return AlertDialog(
      title: Text(AppLocalizations().lbChangeP),
      content: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _keyFormDeposit,
            child: Column(
              children: <Widget>[
                //Commission amount
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 35, 15, 0),
                  child: Material(
                    color: Colors.white,
                    child: TextFormField(
                      controller: _pass,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: AppLocalizations().lbNewP,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ), //can also add icon to the end of the textfiled
                        //  suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.fromLTRB(15, 50, 15, 10),
                  child: new RaisedButton(
                      onPressed: () {
                        if (!_keyFormDeposit.currentState.validate()) {
                          print("Not Validate Form");

                          return 0;
                        }
                        _keyFormDeposit.currentState.save();

                        _buildSubmitFormCoPass(context);
                      }
                      //  textColor: Colors.yellow,colorBrightness: Brightness.dark,
                      ,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      disabledColor: Colors.yellow,
                      child: Center(
                        child: new Text(
                          AppLocalizations().lbChangeP,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    initializeDateFormatting();
    dateFormat   = intl.DateFormat("dd-MM-yyyy");
navigationPage();



  //  activeSearchDrug = false;
   // activeSearchMyDrug = false;
    activeSearchOffer = false;
    activeSearchOrder = false;

    getValueString();

  /*  _scDrug.addListener(() {
      if (_scDrug.position.pixels == _scDrug.position.maxScrollExtent) {
        _getMoreDataDrug(page);
      }
    });
    _scMyDrug.addListener(() {
      if (_scMyDrug.position.pixels == _scMyDrug.position.maxScrollExtent) {
        _getMoreDataDrugMy(pageMy);
      }
    });*/

    _scOffer.addListener(() {
      if (_scOffer.position.pixels == _scOffer.position.maxScrollExtent) {
        _getMoreDataOffer(pageOffer);
      }
    });

    _scOrder.addListener(() {
      if (_scOrder.position.pixels == _scOrder.position.maxScrollExtent) {
        _getMoreDataOrder(pageOrder);
      }
    });

    pr = new ProgressDialog(context);
    pr.update(
      progress: 50.0,
      message: AppLocalizations().lbWait,
      progressWidget: Container(
          padding: EdgeInsets.all(8.0), child: CircularProgressIndicator( valueColor:
      new AlwaysStoppedAnimation<Color>(Colors.praimarydark))),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
  }

  getValueString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    wareId = prefs.getString('id');
    ischange = prefs.getString('RequireRestPassword');

if(ischange =='0'){

}else{

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    await  showDialog(
        context:
        context,
        builder:
            (BuildContext
        context) {
          return showDialogwindowAddPass();
        });
  });
}


   /* if (text == 'Drug') {
      preferences = await SharedPreferences.getInstance();
      sessionId = preferences.getString('sessionId');

      Map<String, dynamic> data = {
        "draw": 1,
        "columns": [
          {
            "data": "name",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "country",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "",
            "name": "",
            "searchable": "false",
            "orderable": "false",
            "search": {"value": "", "regex": "false"}
          }
        ],
        "order": [
          {"column": "1", "dir": "desc"}
        ],
        "length": 10,
        "start": 0,
        "Search": {"value": "", "regex": "false"},
      };

      final DurgsRepository _repository = DurgsRepository();

      responseDrug = await _repository.getDurgsLisy(sessionId, data);
      setState(() {
        tListallDrug = responseDrug.results.listdurgs;
        itemsDrug.addAll(tListallDrug);
      });
    }
    else if (text == 'MyDrug') {
      preferences = await SharedPreferences.getInstance();
      sessionId = preferences.getString('sessionId');

      Map<String, dynamic> data = {
        "draw": 0,
        "columns": [
          {
            "data": "name",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "country",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "",
            "name": "",
            "searchable": "false",
            "orderable": "false",
            "search": {"value": "", "regex": "false"}
          }
        ],
        "order": [
          {"column": "1", "dir": "desc"}
        ],
        "length": 10,
        "start": 0,
        "Search": {"value": "", "regex": "false"},
      };

      final DurgsRepository _repository = DurgsRepository();

      responseDrugMy = await _repository.getMyDrugList(sessionId, data);
      setState(() {
        tListallDrugMy = responseDrugMy.results.listdurgs;
        itemsDrugMy.addAll(tListallDrugMy);
      });
    }
    else*/
      if (text == 'Offer') {
      preferences = await SharedPreferences.getInstance();
      sessionId = preferences.getString('sessionId');

      Map<String, dynamic> data = {
        "draw": 0,
        "columns": [
          {
            "data": "name",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "country",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "",
            "name": "",
            "searchable": "false",
            "orderable": "false",
            "search": {"value": "", "regex": "false"}
          }
        ],
        "order": [
          {"column": "1", "dir": "desc"}
        ],
        "length": 10,
        "start": 0,
        "Search": {"value": "", "regex": "false"},
      };

      final DurgsRepository _repository = DurgsRepository();

      responseOffer = await _repository.getOfferList(sessionId, data,langSave);
      setState(() {
        tListallOffer = responseOffer.results.listOffer;
        itemsOffer.addAll(tListallOffer);
      });
    } else {
      preferences = await SharedPreferences.getInstance();
      sessionId = preferences.getString('sessionId');

      Map<String, dynamic> data = {
        "draw": 0,
        "columns": [
          {
            "data": "name",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "country",
            "name": "",
            "searchable": "true",
            "orderable": "true",
            "search": {"value": "", "regex": "false"}
          },
          {
            "data": "",
            "name": "",
            "searchable": "false",
            "orderable": "false",
            "search": {"value": "", "regex": "false"}
          }
        ],
        "order": [
          {"column": "1", "dir": "desc"}
        ],
        "length": 10,
        "start": 0,
        "Search": {"value": "", "regex": "false"},
      };

      final DurgsRepository _repository = DurgsRepository();

      responseOrder = await _repository.getOrderList(sessionId, data,langSave);
      setState(() {
        tListallOrder = responseOrder.results.listOrder;
        itemsOrder.addAll(tListallOrder);
      });
    }
  }

  _onTap(int index) async {
    switch (index) {
      case 0:
        setState(() => text = 'Offer');
        getValueString();
        break;
      case 1:
        setState(() => text = 'Order');
        getValueString();
        break;


      default:
        setState(() => text = 'Offer');
    }
  }



  PreferredSizeWidget _appBarOffer() {
    if (activeSearchOffer) {
      return AppBar(
        leading: Icon(Icons.search),
        title: TextField(
          onChanged: (value) {
            filterSearchResultsMyOffer(value);
          },
          controller: editingControllerOffer,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            border: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.white)),
            labelStyle: new TextStyle(color: Colors.white),
            hintText: AppLocalizations().lbEnDrugN,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => setState(() => activeSearchOffer = false),
          )
        ],
      );
    } else {
      return AppBar(
        leading: GestureDetector(
          child: Image.asset(
            'assets/images/warelogo.png',
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    Directionality(
                      textDirection:
                      langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                      child: profile()),
              ),
            );
          },
        ),
        title: Text(AppLocalizations().lbMyOff),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => setState(() => activeSearchOffer = true),
          ),
        ],
      );
    }
  }

  PreferredSizeWidget _appBarOrder() {
    if (activeSearchOrder) {
      return AppBar(
        leading: Icon(Icons.search),
        title: TextField(
          onChanged: (value) {
            filterSearchResultsMyOrder(value);
          },
          controller: editingControllerOrder,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white),
            border: new UnderlineInputBorder(
                borderSide: new BorderSide(color: Colors.white)),
            labelStyle: new TextStyle(color: Colors.white),
            hintText: AppLocalizations().lbEnPhN,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => setState(() => activeSearchOrder = false),
          )
        ],
      );
    } else {
      return AppBar(
        leading: GestureDetector(
          child: Image.asset(
            'assets/images/warelogo.png',
            color: Colors.white,
          ),
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) =>
                    Directionality(
                      textDirection:
                      langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                      child:profile()),
              ),
            );
          },
        ),
        title: Text(AppLocalizations().lbMyOrd),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => setState(() => activeSearchOrder = true),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      appBar: text == 'Offer' ? _appBarOffer() : _appBarOrder(),
      body:
      text == 'Offer'
          ? tListallOffer == null
          ? Center(
        child: CircularProgressIndicator( valueColor:
        new AlwaysStoppedAnimation<Color>(Colors.praimarydark)),
      )
          : tListallOffer.length == 0
          ? Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            //  Image.asset('assets/images/pharmalogo.jpg'),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(AppLocalizations().lbNOData),
              )
            ],
          ))
          : RefreshIndicator(
        key: _refreshIndicatorKeyOf,
        onRefresh: _refresh,
        child: Container(
        color: Colors.white,
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: Column(
          children: <Widget>[
            activeSearchOffer == true
                ? Expanded(
                child: ListView.builder(
                  itemCount: itemsOffer.length + 1,
                  // Add one more item for progress indicator
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0),
                  itemBuilder: (BuildContext context,
                      int index) {
                    if (index == itemsOffer.length) {
                      return _buildProgressIndicatorMyOffer();
                    } else {
                      return new Padding(
                        padding: EdgeInsets.fromLTRB(
                            10, 10, 10, 10),
                        child: GestureDetector(
                          child: Container(
                            child: Padding(
                              padding:
                              EdgeInsets.fromLTRB(
                                  10, 5, 10, 5),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets
                                        .fromLTRB(10,
                                        10, 10, 0),
                                    child: Row(
                                      children: <
                                          Widget>[
                                        Text(
                                          itemsOffer[
                                          index]
                                              .Durg
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors
                                                  .praimarydark,
                                              fontSize:
                                              17,
                                              fontWeight:
                                              FontWeight
                                                  .bold),
                                        ),
                                        new Spacer(),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 0, 10, 0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __,
                                                      ___) =>
                                                      Directionality(
                                                        textDirection:
                                                        langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                                        child:  editOffer(
                                                          itemsOffer[index],homePage())),
                                                ),
                                              );
                                            }
                                            , child: Icon(
                                            Icons
                                                .edit,size: 20,
                                            color: Colors
                                                .praimarydark,
                                          ),),),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets
                                        .fromLTRB(10,
                                        2, 10, 2),
                                    child: Row(
                                      children: <
                                          Widget>[
                                        Text(
                                          itemsOffer[
                                          index]
                                              .Description
                                              .toString(),
                                          style:
                                          TextStyle(
                                            color: Colors
                                                .grey,
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets
                                        .fromLTRB(10, 8,
                                        10, 8),
                                    child: itemsOffer[
                                    index]
                                        .Discount ==
                                        '0.0'
                                        ? Row(
                                      children: <
                                          Widget>[
                                        Text(
                                        AppLocalizations().lbGift+' : ' +
                                              itemsOffer[index].Gift.toString(),
                                          style:
                                          TextStyle(
                                            color:
                                            Colors.praimarydark,
                                            fontSize:
                                            17,
                                          ),
                                        )
                                      ],
                                    )
                                        : Row(
                                      children: <
                                          Widget>[
                                        Text(
                                        AppLocalizations().lbDis+' : ' +
                                              itemsOffer[index].Discount
                                                  .toString(),
                                          style:
                                          TextStyle(
                                            color:
                                            Colors.praimarydark,
                                            fontSize:
                                            17,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding:
                                      EdgeInsets
                                          .fromLTRB(
                                          0,
                                          3,
                                          0,
                                          3),
                                      child: Padding(
                                        padding:
                                        EdgeInsets
                                            .fromLTRB(
                                            10,
                                            0,
                                            10,
                                            0),
                                        child: Row(
                                          children: <
                                              Widget>[
                                            Text(
                                            AppLocalizations().lbGePrice+' : ' +
                                                  itemsOffer[index]
                                                      .NormalPrice
                                                      .toString().split('.')[0] ,
                                              style: TextStyle(
                                                  color:
                                                  Colors.grey),
                                            ),
                                            new Spacer(),
                                            Padding(padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                              child:   Text(
                                                  AppLocalizations().lbPhPrice+' : ' +
                                                    itemsOffer[index]
                                                        .Price
                                                        .toString().split('.')[0] ,
                                                style: TextStyle(
                                                    color:
                                                    Colors.grey),
                                              ),)
                                          ],
                                        ),
                                      )),
                                  Padding(
                                      padding:
                                      EdgeInsets
                                          .fromLTRB(
                                          0,
                                          3,
                                          0,
                                          3),
                                      child: Padding(
                                        padding:
                                        EdgeInsets
                                            .fromLTRB(
                                            10,
                                            0,
                                            10,
                                            0),
                                        child: Row(
                                          children: <
                                              Widget>[
                                            Text(
                                            AppLocalizations().lbToPrice+' : ' +
                                                  itemsOffer[index]
                                                      .TotalPrice
                                                      .toString().split('.')[0] ,
                                              style: TextStyle(
                                                  color:
                                                  Colors.grey),
                                            ),

                                          ],
                                        ),
                                      )),

                                  Padding(
                                      padding:
                                      EdgeInsets
                                          .fromLTRB(
                                          0,
                                          3,
                                          0,
                                          3),
                                      child: Padding(
                                        padding:
                                        EdgeInsets
                                            .fromLTRB(
                                            10,
                                            0,
                                            10,
                                            0),
                                        child: Row(
                                          children: <
                                              Widget>[
                                            Text(
                                            AppLocalizations().lbFrom +
                                                  itemsOffer[index]
                                                      .CreateDate
                                                      .toString() +
                                            AppLocalizations().lbTo +
                                                  itemsOffer[index]
                                                      .ExpiryDate
                                                      .toString(),
                                              style: TextStyle(
                                                  color:
                                                  Colors.grey),
                                            ),
                                            new Spacer(),
                                            Padding(padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
                                              child:   GestureDetector(onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (
                                                        BuildContext context) {
                                                      return showDialogwindowDeleteOffer(
                                                          itemsOffer[index].id
                                                              .toString());
                                                    });
                                              }, child: Icon(
                                                Icons
                                                    .delete,size: 20,
                                                color: Colors
                                                    .praimarydark,
                                              ),),)
                                          ],
                                        ),
                                      )),

                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors
                                        .praimarydark,
                                    width: 1),
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(
                                        20.0))),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    Directionality(
                                      textDirection:
                                      langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                      child: offerDetails(itemsOffer[index])),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                  controller: _scOffer,
                ))
                : tListallOffer == null
                ? Container()
                : Expanded(
                child: ListView.builder(
                  itemCount:
                  tListallOffer.length + 1,
                  // Add one more item for progress indicator
                  padding: EdgeInsets.symmetric(
                      vertical: 8.0),
                  itemBuilder:
                      (BuildContext context,
                      int index) {
                    if (index ==
                        tListallOffer.length) {
                      return _buildProgressIndicatorMyOffer();
                    } else {
                      return new Padding(
                        padding:
                        EdgeInsets.fromLTRB(
                            10, 10, 10, 10),
                        child: GestureDetector(
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets
                                  .fromLTRB(
                                  10, 5, 10, 5),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    EdgeInsets
                                        .fromLTRB(
                                        10,
                                        10,
                                        10,
                                        5),
                                    child: Row(
                                      children: <
                                          Widget>[
                                        Text(
                                          tListallOffer[
                                          index]
                                              .Durg
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors
                                                  .praimarydark,
                                              fontSize:
                                              17,
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        new Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                pageBuilder: (_, __,
                                                    ___) =>
                                                    Directionality(
                                                      textDirection:
                                                      langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                                      child:   editOffer(
                                                        tListallOffer[index],homePage())),
                                              ),
                                            );
                                          },
                                          child: Icon(
                                            Icons
                                                .edit,size: 20,
                                            color: Colors
                                                .praimarydark,
                                          ),)
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets
                                        .fromLTRB(
                                        10,
                                        1,
                                        10,
                                        1),
                                    child: Row(
                                      children: <
                                          Widget>[
                                        Text(
                                          tListallOffer[
                                          index]
                                              .Description
                                              .toString(),
                                          style:
                                          TextStyle(
                                            color: Colors
                                                .grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    EdgeInsets
                                        .fromLTRB(
                                        10,
                                        10,
                                        10,
                                        3),
                                    child: tListallOffer[index]
                                        .Discount ==
                                        '0.0'
                                        ? Row(
                                      children: <
                                          Widget>[
                                        Text(
                                        AppLocalizations().lbGift+' : ' +
                                              tListallOffer[index].Gift
                                                  .toString(),
                                          style:
                                          TextStyle(
                                            color: Colors.praimarydark,
                                            fontSize: 17,
                                          ),
                                        )
                                      ],
                                    )
                                        : Row(
                                      children: <
                                          Widget>[
                                        Text(
                                        AppLocalizations().lbDis+' : ' +
                                              tListallOffer[index].Discount
                                                  .toString(),
                                          style:
                                          TextStyle(
                                            color: Colors.praimarydark,
                                            fontSize: 17,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  Padding(
                                      padding: EdgeInsets
                                          .fromLTRB(
                                          0,
                                          3,
                                          0,
                                          3),
                                      child:
                                      Padding(
                                        padding: EdgeInsets
                                            .fromLTRB(
                                            10,
                                            0,
                                            10,
                                            0),
                                        child: Row(
                                          children: <
                                              Widget>[
                                            Text(
                                            AppLocalizations().lbGePrice+' :  ' +
                                                  tListallOffer[index]
                                                      .NormalPrice.toString().split('.')[0] ,
                                              style:
                                              TextStyle(color: Colors.grey),
                                            ),
                                            new Spacer(),
                                            Padding(padding: EdgeInsets.fromLTRB(13, 8, 1, 8),child:
                                            Text(
                                                AppLocalizations().lbPhPrice+' :  ' +
                                                  tListallOffer[index]
                                                      .Price.toString().split('.')[0] ,
                                              style:
                                              TextStyle(color: Colors.grey),
                                            )
                                            )


                                          ],
                                        ),
                                      )),
                                  Padding(
                                      padding: EdgeInsets
                                          .fromLTRB(
                                          0,
                                          3,
                                          0,
                                          3),
                                      child:
                                      Padding(
                                        padding: EdgeInsets
                                            .fromLTRB(
                                            10,
                                            0,
                                            10,
                                            0),
                                        child: Row(
                                          children: <
                                              Widget>[
                                            Text(
                                            AppLocalizations().lbToPrice+' : ' +
                                                  tListallOffer[index]
                                                      .TotalPrice.toString().split('.')[0] ,
                                              style:
                                              TextStyle(color: Colors.grey),
                                            ),



                                          ],
                                        ),
                                      )),
                                  Padding(
                                      padding: EdgeInsets
                                          .fromLTRB(
                                          0,
                                          3,
                                          0,
                                          3),
                                      child:
                                      Padding(
                                        padding: EdgeInsets
                                            .fromLTRB(
                                            10,
                                            0,
                                            10,
                                            0),
                                        child: Row(
                                          children: <
                                              Widget>[
                                            Text(
                                            AppLocalizations().lbFrom +
                                                  tListallOffer[index]
                                                      .CreateDate.toString() +
                                               AppLocalizations().lbTo +
                                                  tListallOffer[index]
                                                      .ExpiryDate.toString(),
                                              style:
                                              TextStyle(color: Colors.grey),
                                            ),
                                            new Spacer(),
                                            Padding(padding: EdgeInsets.fromLTRB(13, 8, 1, 8),child:GestureDetector(onTap: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (
                                                      BuildContext context) {
                                                    return showDialogwindowDeleteOffer(
                                                        tListallOffer[index].id
                                                            .toString());
                                                  });
                                            }, child: Icon(
                                              Icons
                                                  .delete,size: 20,
                                              color: Colors
                                                  .praimarydark,
                                            ),)
                                            )


                                          ],
                                        ),
                                      )),

                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors
                                        .praimarydark,
                                    width: 1),
                                borderRadius:
                                BorderRadius.all(
                                    Radius.circular(
                                        20.0))),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) =>
                                    Directionality(
                                      textDirection:
                                      langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                      child:offerDetails(tListallOffer[index])),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                  controller: _scOffer,
                )),
          ],
        ),
      ),)
          :  RefreshIndicator(
        key: _refreshIndicatorKeyOf,
        onRefresh: _refresh,
        child:   Container(
          color: Colors.white,
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: Column(
            children: <Widget>[
              activeSearchOrder == true
                  ? Expanded(
                  child: ListView.builder(
                    itemCount: itemsOrder.length + 1,
                    // Add one more item for progress indicator
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    itemBuilder:
                        (BuildContext context, int index) {
                      if (index == itemsOrder.length) {
                        return _buildProgressIndicatorMyOrder();
                      } else {
                        return new Padding(
                          padding:
                          EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: GestureDetector(
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 5, 10, 5),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(
                                          10, 10, 10, 5),
                                      child: Row(
                                        children: <Widget>[
                                          Text(   AppLocalizations().lbPhacN+' : '+
                                              itemsOrder[
                                              index]
                                                  .Pharmacy
                                                  .toString(),
                                            style: TextStyle(
                                                color: Colors
                                                    .praimarydark,
                                                fontSize: 17,
                                                fontWeight:
                                                FontWeight
                                                    .bold),
                                          ),new Spacer(),
                                          itemsOrder[index].RequestType == '1'
                                              ? Text(   AppLocalizations().lbOffer, style: TextStyle(
                                              color: Colors.orange),)
                                              :
                                          itemsOrder[index].RequestType == '2'
                                              ? Text(   AppLocalizations().lbMyOre, style: TextStyle(
                                              color: Colors.orange),)
                                              :
                                          Text(AppLocalizations().lbOffOr, style: TextStyle(
                                              color: Colors.orange),)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Row(
                                        children: <Widget>[

                                          Text(AppLocalizations().lbToPrice+' :'+
                                              itemsOrder[index]
                                                  .RequestPrice
                                                  .toString().split('.')[0],
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Row(
                                        children: <Widget>[
                                          Text(AppLocalizations().lbCreDate+' :'+
                                              itemsOrder[index]
                                                  .CreateDate
                                                  .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          new Spacer(),

                                          itemsOrder[index].RequestStatus == '1'
                                              ? Container(padding: EdgeInsets.all(10),child: Text(AppLocalizations().lbPending),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0)))):
                                          itemsOrder[index].RequestStatus == '2'
                                              ? Container(padding: EdgeInsets.all(10),child: Text(AppLocalizations().lbProcessing),
                                              decoration: BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  border: Border.all(
                                                      color: Colors.blueAccent,
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0)))):
                                          itemsOrder[index].RequestStatus == '3'
                                              ? Container(padding: EdgeInsets.all(10),child: Text(AppLocalizations().lbDone),
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  border: Border.all(
                                                      color: Colors.green,
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0)))):
                                          Container(padding: EdgeInsets.all(10),child: Text(AppLocalizations().lbRej),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  border: Border.all(
                                                      color: Colors.red,
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0))))
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                      Colors.praimarydark,
                                      width: 1),
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          20.0))),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      Directionality(
                                        textDirection:
                                        langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                        child: orderDetails(
                                          itemsOrder[index].Pharmacy,
                                          itemsOrder[index].id,
                                          itemsOrder[index].RequestPrice.split('.')[0], itemsOrder[index].RequestStatus) ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                    controller: _scOrder,
                  ))
                  : tListallOrder == null
                  ? Container()
                  : Expanded(
                  child: ListView.builder(
                    itemCount: tListallOrder.length + 1,
                    // Add one more item for progress indicator
                    padding:
                    EdgeInsets.symmetric(vertical: 8.0),
                    itemBuilder:
                        (BuildContext context, int index) {
                      if (index == tListallOrder.length) {
                        return _buildProgressIndicatorMyOrder();
                      } else {
                        return new Padding(
                          padding: EdgeInsets.fromLTRB(
                              10, 10, 10, 10),
                          child: GestureDetector(
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    10, 5, 10, 5),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(
                                          10, 10, 10, 5),
                                      child: Row(
                                        children: <Widget>[
                                          Text(AppLocalizations().lbPhacN+' : '+
                                            tListallOrder[
                                            index]
                                                .Pharmacy
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors
                                                    .praimarydark,
                                                fontSize: 17,
                                                fontWeight:
                                                FontWeight
                                                    .bold),
                                          ),new Spacer(),
                                          tListallOrder[index].RequestType == '1'
                                              ? Text(AppLocalizations().lbOffer, style: TextStyle(
                                              color: Colors.orange),)
                                              :
                                          tListallOrder[index].RequestType == '2'
                                              ? Text(AppLocalizations().lbMyOre, style: TextStyle(
                                              color: Colors.orange),)
                                              :
                                          Text(AppLocalizations().lbOffOr, style: TextStyle(
                                              color: Colors.orange),)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Row(
                                        children: <Widget>[

                                          Text(AppLocalizations().lbToPrice+' :'+
                                              tListallOrder[index]
                                                  .RequestPrice
                                                  .toString().split('.')[0],
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(
                                          10, 10, 10, 10),
                                      child: Row(
                                        children: <Widget>[
                                          Text(AppLocalizations().lbCreDate+' :'+
                                              tListallOrder[index]
                                                  .CreateDate
                                                  .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          new Spacer(),

                                          tListallOrder[index].RequestStatus == '1'
                                              ? Container(padding: EdgeInsets.all(10),child: Text(AppLocalizations().lbPending),
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                      color: Colors.black,
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0)))):
                                          tListallOrder[index].RequestStatus == '2'
                                              ? Container(padding: EdgeInsets.all(10),child: Text(AppLocalizations().lbProcessing),
                                              decoration: BoxDecoration(
                                                  color: Colors.blueAccent,
                                                  border: Border.all(
                                                      color: Colors.blueAccent,
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0)))):
                                          tListallOrder[index].RequestStatus == '3'
                                              ? Container(padding: EdgeInsets.all(10),child: Text(AppLocalizations().lbDone),
                                              decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  border: Border.all(
                                                      color: Colors.green,
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0)))):
                                          Container(padding: EdgeInsets.all(10),child: Text(AppLocalizations().lbRej),
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  border: Border.all(
                                                      color: Colors.red,
                                                      width: 1),
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20.0))))
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                      Colors.praimarydark,
                                      width: 1),
                                  borderRadius:
                                  BorderRadius.all(
                                      Radius.circular(
                                          20.0))),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (_, __, ___) =>
                                      Directionality(
                                        textDirection:
                                        langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                        child: orderDetails(
                                          tListallOrder[index].Pharmacy,
                                          tListallOrder[index].id,
                                          tListallOrder[index].RequestPrice.split('.')[0], tListallOrder[index].RequestStatus) ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                    controller: _scOrder,
                  )),
            ],
          ),
        ),)


    ,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: text == 'Offer'
                ? Image.asset('assets/images/offerws.png')
                : Image.asset('assets/images/offerw.png'),
            title: Text(""),
          ),
          BottomNavigationBarItem(
            icon: text == 'Order'
                ? Image.asset('assets/images/requests.png')
                : Image.asset('assets/images/request.png'),
            title: Text(""),
          ),
        ],
        onTap: _onTap,
      ),
    );
  }

  Widget showDialogwindowAdd(String drugname, String drugId) {
    return AlertDialog(
      title: Text(
        drugname, textAlign: TextAlign.center,
        style:
        TextStyle(color: Colors.praimarydark, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _keyFormDeposit,
            child: Column(
              children: <Widget>[
                //Commission amount
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 35, 15, 0),
                  child: Material(
                    color: Colors.white,
                    child: TextFormField(
                      controller: _geneP,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: AppLocalizations().lbGePrice,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ), //can also add icon to the end of the textfiled
                        //  suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Material(
                    color: Colors.white,
                    child: TextFormField(
                      controller: _pharmaP,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: AppLocalizations().lbPhPrice,
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ), //can also add icon to the end of the textfiled
                        //  suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Visibility(
                    child: Form(
                      key: fromdate,
                      child: DateTimeField(
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        format: dateFormat,
                        validator: (val) {
                          if (val != null) {
                            return null;
                          } else {
                            return AppLocalizations().lbExDate;
                          }
                        },
                        decoration: InputDecoration(labelText: AppLocalizations().lbExDate),
                        //   initialValue: DateTime.now(), //Add this in your Code.
                        // initialDate: DateTime(2017),
                        onSaved: (value) {
                          dateD = value.toString().substring(0, 10);
                          debugPrint(value.toString());
                        },
                      ),
                    ),
                    visible: true,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(15, 50, 15, 10),
                  child: new RaisedButton(
                      onPressed: () {
                        if (!_keyFormDeposit.currentState.validate()) {
                          print("Not Validate Form");

                          return 0;
                        }
                        _keyFormDeposit.currentState.save();

                        _buildSubmitFormCo(context, drugId);
                      }
                      //  textColor: Colors.yellow,colorBrightness: Brightness.dark,
                      ,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      disabledColor: Colors.yellow,
                      child: Center(
                        child: new Text(
                          AppLocalizations().lbAdd,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildSubmitFormCo(BuildContext context, String drugID) async {
    pr.show();
    fromdate.currentState.save();

    var preferences = await SharedPreferences.getInstance();
    String sessionId = preferences.getString('sessionId');

    Map<String, dynamic> data = {
      "Id": drugID,
      "Price": _geneP.text,
      "SecondPrice": _pharmaP.text,
      "DrugExpiryDate": dateD
    };
    //  ProjectBloc().addProjectRevnue(data);
    // BankBloc().addBankCommission(data);

    final DurgsRepository _repository = DurgsRepository();
    registerResponse response =
    await _repository.addDrugToWare(sessionId, data,langSave);

    //  GeneralResponse response = await _repository.addProjectRevnue(data);
    if (response.code == '1') {
      getValueString();

      pr.hide().then((isHidden) {
        print(isHidden);
      });

      Navigator.pop(context, true);
    } else {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      Toast.show(
          response.msg.toString(),
          context,
          duration: 4,
          gravity: Toast.BOTTOM);
    }
  }


  Widget showDialogwindowDelete(String id) {
    return AlertDialog(
      title: Text(AppLocalizations().lbDeleteD),
      content: Text(AppLocalizations().lbDeleteDM),
      actions: <Widget>[
        // usually buttons at the bottoReminiderItemDatem of the dialog
        OutlineButton(
          color: Colors.yellow,
          focusColor: Colors.yellow,
          hoverColor: Colors.yellow,
          highlightColor: Colors.yellow,
          borderSide: BorderSide(color: Colors.green, width: 1),
          disabledBorderColor: Colors.yellow,
          child: Text(AppLocalizations().lbCancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        OutlineButton(
          color: Colors.yellow,
          focusColor: Colors.yellow,
          hoverColor: Colors.yellow,
          highlightColor: Colors.yellow,
          borderSide: BorderSide(color: Colors.green, width: 1),
          disabledBorderColor: Colors.yellow,
          child: new Text(AppLocalizations().lbOk),
          onPressed: () async {
            pr.show();


            var preferences = await SharedPreferences.getInstance();
            String sessionId = preferences.getString('sessionId');

            Map<String, dynamic> data = {
              "Id": id,

            };
            //  ProjectBloc().addProjectRevnue(data);
            // BankBloc().addBankCommission(data);

            final DurgsRepository _repository = DurgsRepository();
            registerResponse response =
            await _repository.deleteDrugToWare(sessionId, data,langSave);

            //  GeneralResponse response = await _repository.addProjectRevnue(data);
            if (response.code == '1') {
              getValueString();
              pr.hide().then((isHidden) {
                print(isHidden);
              });
              Navigator.pop(context, true);
            } else {
              pr.hide().then((isHidden) {
                print(isHidden);
              });
              Toast.show(
                  response.msg.toString(),
                  context,
                  duration: 4,
                  gravity: Toast.BOTTOM);
            }


            //  GeneralResponse response = await _repository.addProjectRevnue(data);

          },
        ),
      ],
    );
  }


  Widget showDialogwindowDeleteOffer(String id) {
    return AlertDialog(
      title: Text(AppLocalizations().lbDeleteO),
      content: Text(AppLocalizations().lbDeleteOM),
      actions: <Widget>[
        // usually buttons at the bottoReminiderItemDatem of the dialog
        OutlineButton(
          color: Colors.yellow,
          focusColor: Colors.yellow,
          hoverColor: Colors.yellow,
          highlightColor: Colors.yellow,
          borderSide: BorderSide(color: Colors.green, width: 1),
          disabledBorderColor: Colors.yellow,
          child: Text(AppLocalizations().lbCancel),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        OutlineButton(
          color: Colors.yellow,
          focusColor: Colors.yellow,
          hoverColor: Colors.yellow,
          highlightColor: Colors.yellow,
          borderSide: BorderSide(color: Colors.green, width: 1),
          disabledBorderColor: Colors.yellow,
          child: new Text(AppLocalizations().lbOk),
          onPressed: () async {
            pr.show();


            var preferences = await SharedPreferences.getInstance();
            String sessionId = preferences.getString('sessionId');

            Map<String, dynamic> data = {
              "Id": id,

              "Status": 0
            };
            //  ProjectBloc().addProjectRevnue(data);
            // BankBloc().addBankCommission(data);

            final DurgsRepository _repository = DurgsRepository();
            registerResponse response =
            await _repository.deleteOffer(sessionId, data,langSave);
            print(response.code);
            //  GeneralResponse response = await _repository.addProjectRevnue(data);
            if (response.code == '1') {
              getValueString();
              pr.hide().then((isHidden) {
                print(isHidden);
              });
              Navigator.pop(context, true);
            } else {
              pr.hide().then((isHidden) {
                print(isHidden);
              });
              Toast.show(
                  response.msg.toString(),
                  context,
                  duration: 4,
                  gravity: Toast.BOTTOM);
            }


            //  GeneralResponse response = await _repository.addProjectRevnue(data);

          },
        ),
      ],
    );
  }
  Future<void> _refresh() async {
    // dummy code

    getValueString();
    return Future.value();
  }
}
