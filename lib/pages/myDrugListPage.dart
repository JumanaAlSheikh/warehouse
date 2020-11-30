import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:toast/toast.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/lang/localss.dart';
import 'package:warehouse/model/drugModel.dart';
import 'package:warehouse/pages/addOffer.dart';
import 'package:warehouse/pages/durgDetails.dart';
import 'package:warehouse/repository/drugRepository.dart';
import 'package:warehouse/response/drugResponse.dart';
import 'package:warehouse/response/registerResponse.dart';

class drugLPMy extends StatefulWidget {
  //final Widget child;

  //final bool changeOnRedraw;

  @override
  _drugLPMy createState() => new _drugLPMy();
}

class _drugLPMy extends State<drugLPMy> {
  String sessionId;
  var preferences;
  int load=0;
  String  searchePh;

  String wareId;
  bool activeSearchDrug = false;
  TextEditingController editingControllerDrug = TextEditingController();

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

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKeyPh =
      new GlobalKey<RefreshIndicatorState>();
  ScrollController _scMyDrug = new ScrollController();
  ProgressDialog pr;

  List<durgsAllList> tListallDrugMy;
  var itemsDrugMy = List<durgsAllList>();
  List<durgsAllList> tListDrugMy;
  List<durgsAllList> drugListMy;
  DurgsResponse responseDrugMy;
  bool isLoadingMyDrug = false;
  static int pageMy = 10;

  _getMoreDataDrugMy(int index) async {
    tListDrugMy = new List();
   if(searchePh==null){
     if (!isLoadingMyDrug) {
       setState(() {
         isLoadingMyDrug = true;
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
         "start": pageMy,
         "Search": {"value": "", "regex": "false"},
       };
       final DurgsRepository _repository = DurgsRepository();

       responseDrugMy = await _repository.getMyDrugList(sessionId, data,langSave);
//offerList = response.results.offers.listOffer;
       //   response = blocOffer.getOfferList(sessionId, data);
       //  if (responseDrug.code == '1') {
       for (int i = 0; i <= responseDrugMy.results.listdurgs.length; i++) {
         tListDrugMy = new List.from(responseDrugMy.results.listdurgs);
         //  tList.add(offerList[i]);
       }

       setState(() {
         isLoadingMyDrug = false;
         //  offerList.addAll(tList);
         //  offerList= new List.from(tList,tListall);
         if (tListallDrugMy == null) {
           tListallDrugMy = drugListMy + tListDrugMy;
         } else {
           tListallDrugMy = tListallDrugMy + tListDrugMy;
         }

         pageMy = pageMy + 10;
       });
     }
   }else{
     if (!isLoadingMyDrug) {
       setState(() {
         isLoadingMyDrug = true;
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
         "start": pageMy,
         "Search": {"value": searchePh, "regex": "true"},
       };
       final DurgsRepository _repository = DurgsRepository();

       responseDrugMy = await _repository.getMyDrugList(sessionId, data,langSave);
//offerList = response.results.offers.listOffer;
       //   response = blocOffer.getOfferList(sessionId, data);
       //  if (responseDrug.code == '1') {
       for (int i = 0; i <= responseDrugMy.results.listdurgs.length; i++) {
         tListDrugMy = new List.from(responseDrugMy.results.listdurgs);
         //  tList.add(offerList[i]);
       }

       setState(() {
         isLoadingMyDrug = false;
         //  offerList.addAll(tList);
         //  offerList= new List.from(tList,tListall);
         if (tListallDrugMy == null) {
           tListallDrugMy = drugListMy + tListDrugMy;
         } else {
           tListallDrugMy = tListallDrugMy + tListDrugMy;
         }

         pageMy = pageMy + 10;
       });
     }
   }
  }

  Widget _buildProgressIndicatorMyDrug() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoadingMyDrug ? 1.0 : 00,
          child: new CircularProgressIndicator(
              valueColor:
                  new AlwaysStoppedAnimation<Color>(Colors.praimarydark)),
        ),
      ),
    );
  }

  getValueString() async {
    preferences = await SharedPreferences.getInstance();
    sessionId = preferences.getString('sessionId');
    wareId = preferences.getString('id');

   if(searchePh==null){
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

     responseDrugMy = await _repository.getMyDrugList(sessionId, data,langSave);
     setState(() {
       tListallDrugMy = responseDrugMy.results.listdurgs;
       itemsDrugMy.addAll(tListallDrugMy);
     });
   }else{
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
       "Search": {"value": searchePh, "regex": "true"},
     };

     final DurgsRepository _repository = DurgsRepository();

     responseDrugMy = await _repository.getMyDrugList(sessionId, data,langSave);
     setState(() {
       tListallDrugMy = responseDrugMy.results.listdurgs;
       itemsDrugMy.addAll(tListallDrugMy);
     });
   }
  }

  @override
  void initState() {
    activeSearchDrug = false;
    navigationPage();
    pr = new ProgressDialog(context);
    pr.update(
      progress: 50.0,
      message: AppLocalizations().lbWait,
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
    getValueString();
    activeSearchDrug = false;
    _scMyDrug.addListener(() {
      if (_scMyDrug.position.pixels == _scMyDrug.position.maxScrollExtent) {
        _getMoreDataDrugMy(pageMy);
      }
    });
    super.initState();
  }

  void filterSearchResultsDrug(String query) {
    activeSearchDrug = true;

    List<durgsAllList> dummySearchList = List<durgsAllList>();
    dummySearchList.addAll(tListallDrugMy);
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
             "Search": {"value": searchePh, "regex": "true"},
           };

           final DurgsRepository _repository = DurgsRepository();

           responseDrugMy = await _repository.getMyDrugList(sessionId, data,langSave);
           setState(() {
             load=0;

             tListallDrugMy = responseDrugMy.results.listdurgs;
             itemsDrugMy.addAll(tListallDrugMy);
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
             "Search": {"value": searchePh, "regex": "true"},
           };

           final DurgsRepository _repository = DurgsRepository();

           responseDrugMy = await _repository.getMyDrugList(sessionId, data,langSave);
           setState(() {
             load=0;

             tListallDrugMy = responseDrugMy.results.listdurgs;
             itemsDrugMy.addAll(tListallDrugMy);
           });

         }
       }
      });
      setState(() {
        itemsDrugMy.clear();
        itemsDrugMy.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        searchePh=null;

        activeSearchDrug=false;
        tListallDrugMy.clear();
        itemsDrugMy.clear();
        //  getValueString();
        initState();
      });
    }
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
          body: tListallDrugMy == null
              ? Center(
                  child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Colors.praimarydark)))
              : tListallDrugMy.length == 0
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
                                          itemsDrugMy.clear();
                                          itemsDrugMy.addAll(tListallDrugMy);
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
                                  itemCount: itemsDrugMy.length + 1,
                                  // Add one more item for progress indicator
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index == itemsDrugMy.length) {
                                      return _buildProgressIndicatorMyDrug();
                                    } else {
                                      return new Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 10),
                                        child: GestureDetector(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.praimarydark,
                                                    width: 1),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 5, 10, 5),
                                              child: Column(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 0, 0, 0),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Container(
                                                          child: langSave=='ar'?Text(
                                                            itemsDrugMy[index]
                                                                .CommerceNameAr
                                                                .toString() +
                                                                '(' +
                                                                itemsDrugMy[
                                                                index]
                                                                    .form
                                                                    .toString() +
                                                                ')',
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
                                                            itemsDrugMy[index]
                                                                .CommerceNameEn
                                                                .toString() +
                                                                '(' +
                                                                itemsDrugMy[
                                                                index]
                                                                    .form
                                                                    .toString() +
                                                                ')',
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
                                                          width: 250,
                                                        ),
                                                        new Spacer(),
                                                        Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0, 0, 0, 0),
                                                            child:
                                                                PopupMenuButton<
                                                                    int>(
                                                              itemBuilder:
                                                                  (context) => [
                                                                PopupMenuItem(
                                                                  value: 1,
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                          AppLocalizations().lbDelete)
                                                                    ],
                                                                  ),
                                                                ),
                                                                PopupMenuItem(
                                                                  value: 2,
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                          AppLocalizations().lbAddO)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                              onCanceled: () {
                                                                print(
                                                                    "You have canceled the menu.");
                                                              },
                                                              onSelected:
                                                                  (value) async {
                                                                if (value ==
                                                                    1) {
                                                                  showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return showDialogwindowDelete(itemsDrugMy[index]
                                                                            .id
                                                                            .toString());
                                                                      });
                                                                } else if (value ==
                                                                    2) {
                                                                  Navigator.of(
                                                                          context)
                                                                      .push(
                                                                    PageRouteBuilder(
                                                                      pageBuilder: (_, __, ___) => Directionality(
                                                                          textDirection:
                                                                          langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                                                          child:addOffer(
                                                                          itemsDrugMy[index]
                                                                              .id,
                                                                          itemsDrugMy[index]
                                                                              .CommerceNameEn,
                                                                          wareId,
                                                                          itemsDrugMy[index]
                                                                              .Price,
                                                                          itemsDrugMy[index]
                                                                              .SecondPrice)),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ))
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
                                                          itemsDrugMy[index]
                                                              .Manufacture
                                                              .toString(),
                                                          style: TextStyle(
                                                            color:
                                                                Colors.praimary,
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
                                                          itemsDrugMy[index]
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
                                                              0, 16, 0, 1),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 0, 10, 0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              width: 250,
                                                              child: Text(
                                                                itemsDrugMy[
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
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 1, 0, 1),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 0, 10, 0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Text(
                                                              itemsDrugMy[index]
                                                                  .Category
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 1, 0, 1),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 0, 10, 0),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Text(
                                                        AppLocalizations().lbGePrice+' : ' +
                                                                  itemsDrugMy[
                                                                          index]
                                                                      .Price
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 1, 0, 1),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                10, 3, 10, 3),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Text(
                                                            AppLocalizations().lbPhPrice+' : ' +
                                                                  itemsDrugMy[
                                                                          index]
                                                                      .SecondPrice
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                            ),
                                                          ],
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    Directionality(
                                                      textDirection:
                                                      langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                                      child:  durgDetails(
                                                        itemsDrugMy[index]
                                                            .CommerceNameEn,
                                                        itemsDrugMy[index].id)),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                    }
                                  },
                                  controller: _scMyDrug,
                                ))
                              : tListallDrugMy == null
                                  ? Container()
                                  : Expanded(
                                      child: ListView.builder(
                                      itemCount: tListallDrugMy.length + 1,
                                      // Add one more item for progress indicator
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index == tListallDrugMy.length) {
                                          return _buildProgressIndicatorMyDrug();
                                        } else {
                                          return new Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: GestureDetector(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color:
                                                            Colors.praimarydark,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0))),
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
                                                              child:langSave=='ar'? Text(
                                                                tListallDrugMy[
                                                                index]
                                                                    .CommerceNameAr
                                                                    .toString() +
                                                                    '(' +
                                                                    tListallDrugMy[
                                                                    index]
                                                                        .form
                                                                        .toString() +
                                                                    ')',
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
                                                                tListallDrugMy[
                                                                index]
                                                                    .CommerceNameEn
                                                                    .toString() +
                                                                    '(' +
                                                                    tListallDrugMy[
                                                                    index]
                                                                        .form
                                                                        .toString() +
                                                                    ')',
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
                                                              width: 250,
                                                            ),
                                                            new Spacer(),
                                                            Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .fromLTRB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child:
                                                                    PopupMenuButton<
                                                                        int>(
                                                                  itemBuilder:
                                                                      (context) =>
                                                                          [
                                                                    PopupMenuItem(
                                                                      value: 1,
                                                                      child:
                                                                          Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                              AppLocalizations().lbDelete)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    PopupMenuItem(
                                                                      value: 2,
                                                                      child:
                                                                          Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Text(
                                                                              AppLocalizations().lbAddO)
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  onCanceled:
                                                                      () {
                                                                    print(
                                                                        "You have canceled the menu.");
                                                                  },
                                                                  onSelected:
                                                                      (value) async {
                                                                    if (value ==
                                                                        1) {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return showDialogwindowDelete(tListallDrugMy[index].id.toString());
                                                                          });
                                                                    } else if (value ==
                                                                        2) {
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(
                                                                        PageRouteBuilder(
                                                                          pageBuilder: (_, __, ___) => Directionality(
                                                                            textDirection:
                                                                            langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                                                            child:addOffer(
                                                                              tListallDrugMy[index].id,
                                                                              tListallDrugMy[index].CommerceNameEn,
                                                                              wareId,
                                                                              tListallDrugMy[index].Price,
                                                                              tListallDrugMy[index].SecondPrice)),
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                ))
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
                                                              tListallDrugMy[
                                                                      index]
                                                                  .Manufacture
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .praimary,
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
                                                              tListallDrugMy[
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
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 16, 0, 1),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    10, 0),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  width: 250,
                                                                  child: Text(
                                                                    tListallDrugMy[
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
                                                                )
                                                              ],
                                                            ),
                                                          )),
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 1, 0, 1),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    10, 0),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  tListallDrugMy[
                                                                          index]
                                                                      .Category
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 1, 0, 1),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 0,
                                                                    10, 0),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                AppLocalizations().lbGePrice+' : ' +
                                                                      tListallDrugMy[
                                                                              index]
                                                                          .Price
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                      Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 1, 0, 1),
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(10, 3,
                                                                    10, 3),
                                                            child: Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                AppLocalizations().lbPhPrice+' : ' +
                                                                      tListallDrugMy[
                                                                              index]
                                                                          .SecondPrice
                                                                          .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ],
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                  PageRouteBuilder(
                                                    pageBuilder: (_, __, ___) =>
                                                        Directionality(
                                                          textDirection:
                                                          langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                                          child:  durgDetails(
                                                            tListallDrugMy[
                                                                    index]
                                                                .CommerceNameEn,
                                                            tListallDrugMy[
                                                                    index]
                                                                .id)),
                                                  ),
                                                );
                                              },
                                            ),
                                          );
                                        }
                                      },
                                      controller: _scMyDrug,
                                    )):Center(
                              child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.praimarydark))),
                        ],
                      ),
                    )),
    );
  }

  Widget showDialogwindowDelete(String id) {
    return AlertDialog(
      title: Text(     AppLocalizations().lbDeleteD),
      content: Text(     AppLocalizations().lbDeleteDM),
      actions: <Widget>[
        // usually buttons at the bottoReminiderItemDatem of the dialog
        Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Center(
              child: Text(
                AppLocalizations().lbSubmit,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.praimarydark),
        ),

        GestureDetector(
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Center(
                child: Text(
                  AppLocalizations().lbCancel,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.praimarydark),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),

        GestureDetector(
          child: Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Center(
                child: Text(
                  AppLocalizations().lbOk,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.praimarydark),
          ),
          onTap: () async {
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
              Toast.show(response.msg.toString(), context,
                  duration: 4, gravity: Toast.BOTTOM);
            }
          },
        )
      ],
    );
  }

  Future<void> _refresh() async {
    // dummy code

    getValueString();
    return Future.value();
  }
}
