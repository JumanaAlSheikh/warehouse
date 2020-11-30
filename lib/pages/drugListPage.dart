import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:toast/toast.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/lang/localss.dart';
import 'package:warehouse/model/drugModel.dart';
import 'package:warehouse/pages/durgDetails.dart';
import 'package:warehouse/repository/drugRepository.dart';
import 'package:warehouse/response/drugResponse.dart';
import 'package:warehouse/response/registerResponse.dart';

class drugLP extends StatefulWidget {
  //final Widget child;

  //final bool changeOnRedraw;

  @override
  _drugLP createState() => new _drugLP();
}

class _drugLP extends State<drugLP> {
  String sessionId;
  var preferences;
  int load=0;

  ScrollController _scDrug = new ScrollController();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKeyPh =
      new GlobalKey<RefreshIndicatorState>();
  bool activeSearchDrug = false;

  List<durgsAllList> tListallDrug;
  var itemsDrug = List<durgsAllList>();
  List<durgsAllList> tListDrug;
  List<durgsAllList> drugList;
  DurgsResponse responseDrug;
  static int page = 10;
  intl.DateFormat dateFormat ;
  ProgressDialog pr;
  String  searchePh;

  bool isLoadingDrug = false;
  TextEditingController editingControllerDrug = TextEditingController();
  GlobalKey<FormState> _keyFormDeposit = GlobalKey();
  final _geneP = new TextEditingController();
  final _pharmaP = new TextEditingController();
  var fromdate = GlobalKey<FormState>();
  String dateD;
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

  getValueString() async {
    preferences = await SharedPreferences.getInstance();

    sessionId = preferences.getString('sessionId');
if(searchePh==null){
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

  responseDrug = await _repository.getDurgsLisy(sessionId, data,langSave);
  setState(() {
    tListallDrug = responseDrug.results.listdurgs;
    itemsDrug.addAll(tListallDrug);
  });
}else{
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
    "Search": {"value": searchePh, "regex": "true"},
  };

  final DurgsRepository _repository = DurgsRepository();

  responseDrug = await _repository.getDurgsLisy(sessionId, data,langSave);
  setState(() {
    tListallDrug = responseDrug.results.listdurgs;
    itemsDrug.addAll(tListallDrug);
  });
}

  }

  Widget showDialogwindowAdd(String drugname, String drugId) {
    return AlertDialog(
      title: Text(
        drugname,
        textAlign: TextAlign.center,
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
                            return  AppLocalizations().lbExDate;
                          }
                        },
                        decoration: InputDecoration(labelText:  AppLocalizations().lbExDate),
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
                    child: GestureDetector(
                      child: Center(
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Center(
                              child: Text(
                                AppLocalizations().lbAdd,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: Colors.praimarydark),
                        ),
                      ),
                      onTap: () {
                        if (!_keyFormDeposit.currentState.validate()) {
                          print("Not Validate Form");

                          return 0;
                        }
                        _keyFormDeposit.currentState.save();

                        _buildSubmitFormCo(context, drugId);
                      },
                    )),
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
    activeSearchDrug = false;

    navigationPage();
    pr = new ProgressDialog(context);
    pr.update(
      progress: 50.0,
      message:  AppLocalizations().lbWait,
      progressWidget: Container(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.praimarydark))),
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    activeSearchDrug = false;
    getValueString();
    _scDrug.addListener(() {
      if (_scDrug.position.pixels == _scDrug.position.maxScrollExtent) {
        _getMoreDataDrug(page);
      }
    });
    super.initState();
  }

  _getMoreDataDrug(int index) async {
    tListDrug = new List();
    if(searchePh==null){
      if (!isLoadingDrug) {
        setState(() {
          isLoadingDrug = true;
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
          "start": page,
          "Search": {"value": "", "regex": "true"},
        };
        final DurgsRepository _repository = DurgsRepository();

        responseDrug = await _repository.getDurgsLisy(sessionId, data,langSave);
//offerList = response.results.offers.listOffer;
        //   response = blocOffer.getOfferList(sessionId, data);
        //  if (responseDrug.code == '1') {
        for (int i = 0; i <= responseDrug.results.listdurgs.length; i++) {
          tListDrug = new List.from(responseDrug.results.listdurgs);
          //  tList.add(offerList[i]);
        }

        setState(() {
          isLoadingDrug = false;
          //  offerList.addAll(tList);
          //  offerList= new List.from(tList,tListall);
          if (tListallDrug == null) {
            tListallDrug = drugList + tListDrug;
            itemsDrug.addAll(tListallDrug);
          } else {
            tListallDrug = tListallDrug + tListDrug;
            itemsDrug.addAll(tListallDrug);
          }

          page = page + 10;
        });
      }
    }else{
      if (!isLoadingDrug) {
        setState(() {
          isLoadingDrug = true;
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
          "start": page,
          "Search": {"value": searchePh, "regex": "true"},
        };
        final DurgsRepository _repository = DurgsRepository();

        responseDrug = await _repository.getDurgsLisy(sessionId, data,langSave);
//offerList = response.results.offers.listOffer;
        //   response = blocOffer.getOfferList(sessionId, data);
        //  if (responseDrug.code == '1') {
        for (int i = 0; i <= responseDrug.results.listdurgs.length; i++) {
          tListDrug = new List.from(responseDrug.results.listdurgs);
          //  tList.add(offerList[i]);
        }

        setState(() {
          isLoadingDrug = false;
          //  offerList.addAll(tList);
          //  offerList= new List.from(tList,tListall);
          if (tListallDrug == null) {
            tListallDrug = drugList + tListDrug;
            itemsDrug.addAll(tListallDrug);
          } else {
            tListallDrug = tListallDrug + tListDrug;
            itemsDrug.addAll(tListallDrug);
          }

          page = page + 10;
        });
      }
    }

  }

  void filterSearchResultsDrug(String query) {
    activeSearchDrug = true;

    List<durgsAllList> dummySearchList = List<durgsAllList>();
    dummySearchList.addAll(tListallDrug);
    if (query.isNotEmpty) {
      List<durgsAllList> dummyListData = List<durgsAllList>();
      dummySearchList.forEach((item) async {
     if(langSave=='ar'){
       if (item.CommerceNameAr.toLowerCase().contains(query.toLowerCase())) {
         //   dummyListData.add(item);


         searchePh = query;
         //  _getMoreData(page);
         setState(() {
           load = 1;
         });
         // _buildProgressIndicator();
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
           "Search": {"value": searchePh, "regex": "true"},
         };

         final DurgsRepository _repository = DurgsRepository();

         responseDrug = await _repository.getDurgsLisy(sessionId, data,langSave);
         setState(() {
           load=0;

           tListallDrug = responseDrug.results.listdurgs;
           itemsDrug.addAll(tListallDrug);
         });

       }
     }else{
       if (item.CommerceNameEn.toLowerCase().contains(query.toLowerCase())) {
         //   dummyListData.add(item);


         searchePh = query;
         //  _getMoreData(page);
         setState(() {
           load = 1;
         });
         // _buildProgressIndicator();
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
           "Search": {"value": searchePh, "regex": "true"},
         };

         final DurgsRepository _repository = DurgsRepository();

         responseDrug = await _repository.getDurgsLisy(sessionId, data,langSave);
         setState(() {
           load=0;

           tListallDrug = responseDrug.results.listdurgs;
           itemsDrug.addAll(tListallDrug);
         });

       }
     }

      });
      setState(() {
        itemsDrug.clear();
        itemsDrug.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        searchePh=null;

        activeSearchDrug=false;
        tListallDrug.clear();
        itemsDrug.clear();
        //  getValueString();
        initState();
      //  itemsDrug.clear();
        //itemsDrug.addAll(tListallDrug);
      });
    }
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
      Toast.show(response.msg.toString(), context,
          duration: 4, gravity: Toast.BOTTOM);
    }
  }

  Widget _buildProgressIndicatorDrug() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoadingDrug ? 1.0 : 00,
          child: new CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.praimarydark)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return RefreshIndicator(
      key: _refreshIndicatorKeyPh,
      onRefresh: _refresh,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          resizeToAvoidBottomPadding: false,
          body: tListallDrug == null
              ? Center(
              child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      Colors.praimarydark)))
              : tListallDrug.length == 0
              ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Image.asset('assets/images/pharmalogo.jpg'),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Text(AppLocalizations().lbNOData),
                  )
                ],
              ))
              : Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.all(
                              Radius.circular(40.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new ListTile(
                          leading: new Icon(Icons.search),
                          title: new TextField(
                            onChanged: (value) {
                              filterSearchResultsDrug(value);
                            },
                            controller: editingControllerDrug,
                            style: TextStyle(color: Colors.grey),
                            decoration: InputDecoration(
                              hintStyle:
                              TextStyle(color: Colors.grey),
                              border: new UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: Colors.white)),
                              labelStyle:
                              new TextStyle(color: Colors.white),
                              hintText: AppLocalizations().lbEnDrugN,
                            ),
                          ),
                          trailing: new IconButton(
                            icon: new Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                searchePh=null;
                                activeSearchDrug = false;
                                editingControllerDrug.clear();
                                itemsDrug.clear();
                                itemsDrug.addAll(tListallDrug);
                              });
                              initState();

                              //onSearchTextChanged('');
                            },
                          ),
                        ),
                      )),
                ),
                load==0?  activeSearchDrug == true
                    ? Expanded(
                    child: ListView.builder(
                      itemCount: itemsDrug.length + 1,
                      // Add one more item for progress indicator
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      itemBuilder:
                          (BuildContext context, int index) {
                        if (index == itemsDrug.length) {
                          return _buildProgressIndicatorDrug();
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
                                            10, 0, 10, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              child: langSave=='ar'?Text(
                                                itemsDrug[index]
                                                    .CommerceNameAr
                                                    .toString(),
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors
                                                        .praimarydark,
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ):
                                              Text(
                                                itemsDrug[index]
                                                    .CommerceNameEn
                                                    .toString(),
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors
                                                        .praimarydark,
                                                    fontSize: 17,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                              //  width: 250,
                                            ),
                                            new Spacer(),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(
                                            10, 1, 10, 1),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              itemsDrug[index]
                                                  .Strengths
                                                  .toString(),
                                              style: TextStyle(
                                                color:
                                                Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(
                                            10, 1, 10, 1),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              itemsDrug[index]
                                                  .form
                                                  .toString(),
                                              style: TextStyle(
                                                color:
                                                Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(
                                            0, 16, 0, 3),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              itemsDrug[index]
                                                  .Manufacture
                                                  .toString(),
                                              overflow: TextOverflow
                                                  .ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 17,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(
                                              0, 3, 0, 3),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  width: 250,
                                                  child: Text(
                                                    itemsDrug[index]
                                                        .ScientificNameEn
                                                        .toString(),
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                      Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(
                                              0, 3, 0, 3),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.fromLTRB(
                                                10, 0, 10, 0),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                  itemsDrug[index]
                                                      .Category
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey),
                                                ),
                                                new Spacer(),
                                                itemsDrug[index]
                                                    .avalible ==
                                                    '0'
                                                    ? Visibility(
                                                  child:
                                                  GestureDetector(
                                                    child:
                                                    Icon(
                                                      Icons
                                                          .add_circle,
                                                      color: Colors
                                                          .praimarydark,
                                                      size:
                                                      40,
                                                    ),
                                                    onTap:
                                                        () {
                                                      showDialog(
                                                          context:
                                                          context,
                                                          builder:
                                                              (BuildContext context) {
                                                            return showDialogwindowAdd(itemsDrug[index].CommerceNameEn.toString(), itemsDrug[index].id.toString());
                                                          });
                                                    },
                                                  ),
                                                  visible:
                                                  true,
                                                )
                                                    : Visibility(
                                                  child:
                                                  GestureDetector(
                                                    child:
                                                    Icon(
                                                      Icons
                                                          .add_circle,
                                                      color: Colors
                                                          .praimarydark,
                                                      size:
                                                      40,
                                                    ),
                                                    onTap:
                                                        () {
                                                      showDialog(
                                                          context:
                                                          context,
                                                          builder:
                                                              (BuildContext context) {
                                                            return showDialogwindowAdd(itemsDrug[index].CommerceNameEn.toString(), itemsDrug[index].id.toString());
                                                          });
                                                    },
                                                  ),
                                                  visible:
                                                  false,
                                                )
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/carddurg.png'),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        Directionality(
                                            textDirection:
                                            langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                            child:     durgDetails(
                                                itemsDrug[index]
                                                    .CommerceNameEn,
                                                itemsDrug[index].id)),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                      controller: _scDrug,
                    ))
                    : tListallDrug == null
                    ? Container()
                    : Expanded(
                    child: ListView.builder(
                      itemCount: tListallDrug.length + 1,
                      // Add one more item for progress indicator
                      padding:
                      EdgeInsets.symmetric(vertical: 8.0),
                      itemBuilder:
                          (BuildContext context, int index) {
                        if (index == tListallDrug.length) {
                          return _buildProgressIndicatorDrug();
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
                                            10, 0, 10, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              width: 250,
                                              child: langSave=='ar'?Text(
                                                tListallDrug[
                                                index]
                                                    .CommerceNameAr
                                                    .toString(),
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors
                                                        .praimarydark,
                                                    fontSize:
                                                    17,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ):
                                              Text(
                                                tListallDrug[
                                                index]
                                                    .CommerceNameEn
                                                    .toString(),
                                                overflow:
                                                TextOverflow
                                                    .ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: Colors
                                                        .praimarydark,
                                                    fontSize:
                                                    17,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                            ),
                                            new Spacer(),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              tListallDrug[
                                              index]
                                                  .Strengths
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors
                                                    .grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              tListallDrug[
                                              index]
                                                  .form
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors
                                                    .grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Row(
                                          children: <Widget>[
                                            itemsDrug[index]
                                                .Manufacture ==
                                                null
                                                ? Text(
                                              '',
                                              overflow:
                                              TextOverflow
                                                  .ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors
                                                      .praimarydark,
                                                  fontSize:
                                                  17,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            )
                                                : Text(
                                              itemsDrug[
                                              index]
                                                  .Manufacture
                                                  .toString(),
                                              overflow:
                                              TextOverflow
                                                  .ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  color: Colors
                                                      .red,
                                                  fontSize:
                                                  17,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets
                                              .fromLTRB(
                                              0, 16, 0, 3),
                                          child: Padding(
                                            padding: EdgeInsets
                                                .fromLTRB(10, 0,
                                                10, 0),
                                            child: Row(
                                              children: <
                                                  Widget>[
                                                Container(
                                                  child: Text(
                                                    tListallDrug[
                                                    index]
                                                        .ScientificNameEn
                                                        .toString(),
                                                    overflow:
                                                    TextOverflow
                                                        .ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey),
                                                  ),
                                                  width: 250,
                                                )
                                              ],
                                            ),
                                          )),
                                      Padding(
                                          padding: EdgeInsets
                                              .fromLTRB(
                                              0, 3, 0, 3),
                                          child: Padding(
                                            padding: EdgeInsets
                                                .fromLTRB(10, 0,
                                                10, 0),
                                            child: Row(
                                              children: <
                                                  Widget>[
                                                Text(
                                                  tListallDrug[
                                                  index]
                                                      .Category
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors
                                                          .grey),
                                                ),
                                                new Spacer(),
                                                tListallDrug[index]
                                                    .avalible ==
                                                    '0'
                                                    ? Visibility(
                                                  child:
                                                  GestureDetector(
                                                    child:
                                                    Icon(
                                                      Icons.add_circle,
                                                      color:
                                                      Colors.praimarydark,
                                                      size:
                                                      40,
                                                    ),
                                                    onTap:
                                                        () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return showDialogwindowAdd(tListallDrug[index].CommerceNameEn.toString(), tListallDrug[index].id.toString());
                                                          });
                                                    },
                                                  ),
                                                  visible:
                                                  true,
                                                )
                                                    : Visibility(
                                                  child:
                                                  GestureDetector(
                                                    child: Icon(
                                                        Icons.add_circle,
                                                        color: Colors.praimarydark,
                                                        size: 40),
                                                    onTap:
                                                        () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext context) {
                                                            return showDialogwindowAdd(tListallDrug[index].CommerceNameEn.toString(), tListallDrug[index].id.toString());
                                                          });
                                                    },
                                                  ),
                                                  visible:
                                                  false,
                                                )
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/carddurg.png'),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        Directionality(
                                            textDirection:
                                            langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                            child:  durgDetails(
                                                tListallDrug[index]
                                                    .CommerceNameEn,
                                                tListallDrug[index]
                                                    .id)),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      },
                      controller: _scDrug,
                    )):Center(
                    child: CircularProgressIndicator(
                        valueColor: new AlwaysStoppedAnimation<Color>(
                            Colors.praimarydark))),
              ],
            ),
          )),
    );
  }

  Future<void> _refresh() async {
    // dummy code

    getValueString();
    return Future.value();
  }
}
