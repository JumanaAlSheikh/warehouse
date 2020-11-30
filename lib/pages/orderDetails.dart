import 'dart:async';
import 'package:toast/toast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/lang/localss.dart';
import 'package:warehouse/model/orderItem.dart';
import 'package:warehouse/repository/drugRepository.dart';
import 'package:warehouse/response/orderREsponseDetails.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:warehouse/bloc/blocDrug.dart';
import 'package:warehouse/response/registerResponse.dart';

class orderDetails extends StatefulWidget {
  final String pharname;

  final String id;
  final String total;
  final String reqStatus;

  orderDetails(this.pharname, this.id, this.total, this.reqStatus);

  @override
  _orderDetails createState() => new _orderDetails();
}

class _orderDetails extends State<orderDetails> {
  String sessionId;
  var preferences;
  ProgressDialog pr;
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

  List<orderModelDetail> reportModel;
  String state, stateNew;

  getValueString() async {
    preferences = await SharedPreferences.getInstance();
    sessionId = preferences.getString('sessionId');
    //stateNew = preferences.getString('sta');
    stateNew = null;
    String last = widget.id.split('.')[0];
    Map<String, dynamic> data = {
      "Id": last,
    };

    blocDurgs.getOrderDetails(sessionId, data,langSave);
  }

  @override
  void initState() {
    navigationPage();
    getValueString();
    state = widget.reqStatus;
    pr = new ProgressDialog(context);
    pr.update(
      progress: 50.0,
      message:       AppLocalizations().lbWait,
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
    //  navigationPage();
  }

  @override
  Widget build(BuildContext context) {
    print(state);
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pharname,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.praimarydark,
      ),
      resizeToAvoidBottomPadding: true,
      body: StreamBuilder(
        stream: blocDurgs.subjectdetailsOrder.stream,
        builder: (BuildContext context,
            AsyncSnapshot<orderDetailsResponse> snapshot) {
          if (snapshot.hasData) {
            /*if (snapshot.data.error != null && snapshot.data.error.length > 0) {
          return ErrorHandle(snapshot.data.error);
        }*/
            reportModel = snapshot.data.results.resultsOrder.listOrder;
            return new Padding(
              padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
              child: Container(
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                AppLocalizations().lbOreberN+' : '.toString(),
                                      style: TextStyle(
                                          color: Colors.praimarydark,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(widget.id.split('.')[0]),
                                    new Spacer(),
                                    Text(
                                        AppLocalizations().lbDate+' : '.toString(),
                                      style: TextStyle(
                                          color: Colors.praimarydark,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(snapshot
                                        .data.results.results.CreateDate
                                        .substring(0, 10))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations().lbToPrice+' : '.toString(),
                                      style: TextStyle(
                                          color: Colors.praimarydark,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(widget.total.split('.')[0]),

                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      snapshot.data.results.results.City +
                                          ' - ' +
                                          snapshot.data.results.results.Address
                                              .toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    new Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                            pageBuilder: (_, __, ___) => map(
                                                snapshot.data.results.results
                                                    .Latidute,
                                                snapshot.data.results.results
                                                    .Longitude),
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                        'assets/images/mappharma.png',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              snapshot.data.results.results.phone == 'null'
                                  ? Visibility(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 5),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                            AppLocalizations().lbPhone+' : '.toString(),
                                              style: TextStyle(
                                                color: Colors.praimarydark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      visible: false,
                                    )
                                  : Visibility(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 5),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                            AppLocalizations().lbPhone+' : '.toString(),
                                              style: TextStyle(
                                                color: Colors.praimarydark,
                                              ),
                                            ),
                                            Text(snapshot
                                                .data.results.results.phone)
                                          ],
                                        ),
                                      ),
                                      visible: true,
                                    ),
                              snapshot.data.results.results.mobile == 'null'
                                  ? Visibility(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 5),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                            AppLocalizations().lbMobile+' : '.toString(),
                                              style: TextStyle(
                                                color: Colors.praimarydark,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      visible: false,
                                    )
                                  : Visibility(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 10, 10, 5),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                            AppLocalizations().lbMobile+' : '.toString(),
                                              style: TextStyle(
                                                color: Colors.praimarydark,
                                              ),
                                            ),
                                            Text(snapshot
                                                .data.results.results.mobile)
                                          ],
                                        ),
                                      ),
                                      visible: true,
                                    ),
                              stateNew == null
                                  ? Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 20, 10, 20),
                                      child: state == '1'
                                          ? Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 0, 10),
                                                      child: Text(
                                                        AppLocalizations().lbChangeS+' : ',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .praimarydark,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
                                                        _buildSubmitFormCo(
                                                            context,
                                                            widget.id
                                                                .split('.')[0],
                                                            '2');
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(
                                                              AppLocalizations().lbProcessing),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .lightBlueAccent,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .lightBlueAccent,
                                                                width: 1),
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(      AppLocalizations().lbDone),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .lightGreenAccent,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .lightGreenAccent,
                                                                width: 1),
                                                          )),
                                                      onTap: () {
                                                        _buildSubmitFormCo(
                                                            context,
                                                            widget.id
                                                                .split('.')[0],
                                                            '3');
                                                      },
                                                    ),
                                                    GestureDetector(
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child:
                                                              Text(      AppLocalizations().lbRej),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .redAccent,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .redAccent,
                                                                width: 1),
                                                          )),
                                                      onTap: () {
                                                        _buildSubmitFormCo(
                                                            context,
                                                            widget.id
                                                                .split('.')[0],
                                                            '4');
                                                      },
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          : state == '2'
                                              ? Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 10, 0, 10),
                                                          child: Text(
                                                            AppLocalizations().lbChangeS+' : ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .praimarydark,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            _buildSubmitFormCo(
                                                                context,
                                                                widget.id.split(
                                                                    '.')[0],
                                                                '3');
                                                          },
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              child:
                                                                  Text(      AppLocalizations().lbDone),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .lightGreenAccent,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .lightGreenAccent,
                                                                    width: 1),
                                                              )),
                                                        ),
                                                        GestureDetector(
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              child: Text(
                                                                  AppLocalizations().lbRej),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .redAccent,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    width: 1),
                                                              )),
                                                          onTap: () {
                                                            _buildSubmitFormCo(
                                                                context,
                                                                widget.id.split(
                                                                    '.')[0],
                                                                '4');
                                                          },
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              : state == '3'
                                                  ? Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          10),
                                                              child: Text(
                                                                AppLocalizations().lbChangeS+' : ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .praimarydark,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(      AppLocalizations().lbDone)
                                                      ],
                                                    )
                                                  : Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          10),
                                                              child: Text(
                                                                AppLocalizations().lbChangeS+' : ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .praimarydark,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(      AppLocalizations().lbRej)
                                                      ],
                                                    ),
                                    )
                                  : Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 20, 10, 20),
                                      child: stateNew == '1'
                                          ? Column(
                                              children: <Widget>[
                                                Row(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              0, 10, 0, 10),
                                                      child: Text(
                                                        AppLocalizations().lbChangeS+' : ',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .praimarydark,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                      onTap: () {
                                                        _buildSubmitFormCo(
                                                            context,
                                                            widget.id
                                                                .split('.')[0],
                                                            '2');
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(
                                                              AppLocalizations().lbProcessing),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .lightBlueAccent,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .lightBlueAccent,
                                                                width: 1),
                                                          )),
                                                    ),
                                                    GestureDetector(
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(      AppLocalizations().lbDone),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .lightGreenAccent,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .lightGreenAccent,
                                                                width: 1),
                                                          )),
                                                      onTap: () {
                                                        _buildSubmitFormCo(
                                                            context,
                                                            widget.id
                                                                .split('.')[0],
                                                            '3');
                                                      },
                                                    ),
                                                    GestureDetector(
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child:
                                                              Text(      AppLocalizations().lbRej),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .redAccent,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .redAccent,
                                                                width: 1),
                                                          )),
                                                      onTap: () {
                                                        _buildSubmitFormCo(
                                                            context,
                                                            widget.id
                                                                .split('.')[0],
                                                            '4');
                                                      },
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          : stateNew == '2'
                                              ? Column(
                                                  children: <Widget>[
                                                    Row(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 10, 0, 10),
                                                          child: Text(
                                                            AppLocalizations().lbChangeS+' : ',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .praimarydark,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        GestureDetector(
                                                          onTap: () {
                                                            _buildSubmitFormCo(
                                                                context,
                                                                widget.id.split(
                                                                    '.')[0],
                                                                '3');
                                                          },
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              child:
                                                                  Text(      AppLocalizations().lbDone),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .lightGreenAccent,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .lightGreenAccent,
                                                                    width: 1),
                                                              )),
                                                        ),
                                                        GestureDetector(
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              margin: EdgeInsets
                                                                  .all(10),
                                                              child: Text(
                                                                  AppLocalizations().lbRej),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .redAccent,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .redAccent,
                                                                    width: 1),
                                                              )),
                                                          onTap: () {
                                                            _buildSubmitFormCo(
                                                                context,
                                                                widget.id.split(
                                                                    '.')[0],
                                                                '4');
                                                          },
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              : stateNew == '3'
                                                  ? Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          10),
                                                              child: Text(
                                                                AppLocalizations().lbChangeS+' : ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .praimarydark,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(      AppLocalizations().lbDone)
                                                      ],
                                                    )
                                                  : Column(
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .fromLTRB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          10),
                                                              child: Text(
                                                                AppLocalizations().lbChangeS+' : ',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .praimarydark,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Text(      AppLocalizations().lbRej)
                                                      ],
                                                    ),
                                    ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                                  child: Container(
                                      child: Wrap(
                                    spacing: 0.0,
                                    alignment: WrapAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(2, 0, 2, 0),
                                        child: Container(
                                          child: _getBodyWidget(snapshot.data
                                              .results.resultsOrder.listOrder),
                                        ),
                                      )

                                      /* GridView.count(
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,ssss
                    padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 1 / 1.8,
                    crossAxisCount: 2,
//          primary: false,
                    children: List.generate(
                      model.notes.length,
                          (index) => ItemCardNote(model.notes[index]),
                    ),
                  )*/
                                    ],
                                  ))),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text(      AppLocalizations().lbError);
          } else {
            return Text(      AppLocalizations().lbLoad);
          }
        },
      ),
    );
  }

  Widget _getBodyWidget(List<orderModelDetail> reportModel) {
    return Container(
      child: HorizontalDataTable(
        leftHandSideColumnWidth: 100,
        rightHandSideColumnWidth: 10000,
        isFixedHeader: true,
        headerWidgets: _getTitleWidget(),
        leftSideItemBuilder: _generateFirstColumnRow,
        rightSideItemBuilder: _generateRightHandSideColumnRow,
        itemCount: reportModel.length,
        rowSeparatorWidget: const Divider(
          color: Colors.black54,
          height: 1.0,
          thickness: 0.0,
        ),
        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
      ),
      height: MediaQuery.of(context).size.height,
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget(      AppLocalizations().lbComN, 100),
      _getTitleItemWidget(      AppLocalizations().lbDrug, 100),
      _getTitleItemWidget(      AppLocalizations().lbQuan, 100),
      _getTitleItemWidget(      AppLocalizations().lbGePrice, 100),
      _getTitleItemWidget(      AppLocalizations().lbPhPrice, 100),
      _getTitleItemWidget(      AppLocalizations().lbToPrice, 100),
      _getTitleItemWidget(      AppLocalizations().lbGift, 100),
      _getTitleItemWidget(      AppLocalizations().lbDes, 100),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.praimarydark)),
      width: width,
      height: 56,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int index) {
    return Container(
      child: Text(reportModel[index].Manufacture),
      width: 200,
      height: 52,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    return Row(
      children: <Widget>[
        Container(
          child: Text(reportModel[index].drugName),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(reportModel[index].quantity),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(reportModel[index].price.split('.')[0]),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(reportModel[index].subPrice.split('.')[0]),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(reportModel[index].subTotalPrice.split('.')[0]),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(reportModel[index].gift),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(reportModel[index].offerDes),
          width: 100,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }

  _buildSubmitFormCo(
      BuildContext context, String orderId, String status) async {
    pr.show();

    var preferences = await SharedPreferences.getInstance();
    String sessionId = preferences.getString('sessionId');

    Map<String, dynamic> data = {"Id": orderId, "Status": status};
    //  ProjectBloc().addProjectRevnue(data);
    // BankBloc().addBankCommission(data);

    final DurgsRepository _repository = DurgsRepository();
    registerResponse response = await _repository.changeStatus(sessionId, data,langSave);

    //  GeneralResponse response = await _repository.addProjectRevnue(data);
    if (response.code == '1') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      preferences = await SharedPreferences.getInstance();
      sessionId = preferences.getString('sessionId');
      //stateNew = preferences.getString('sta');
      String last = widget.id.split('.')[0];
      Map<String, dynamic> data = {
        "Id": last,
      };

      blocDurgs.getOrderDetails(sessionId, data,langSave);
//      getValueString();
      if (status == '2') {
        setState(() {
          stateNew = '2';

          prefs.setString('sta', status);
        });
      } else if (status == '3') {
        setState(() {
          stateNew = '3';
          prefs.setString('sta', status);
        });
      } else if (status == '4') {
        setState(() {
          stateNew = '4';
          prefs.setString('sta', status);
        });
      }
      pr.hide().then((isHidden) {
        print(isHidden);
      });
    } else {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      Toast.show(response.msg.toString(), context,
          duration: 4, gravity: Toast.BOTTOM);
    }
  }
}

class map extends StatefulWidget {
  final String lat;

  final String lon;

  map(this.lat, this.lon);

  @override
  _map createState() => new _map();
}

class _map extends State<map> {
  GoogleMapController mapController;

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers;

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId('Your Location'),
          position: LatLng(double.parse(widget.lat), double.parse(widget.lon)),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'Your Location'))
    ].toSet();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getCurrentLocation();
    _createMarker();
    markers = _createMarker();
    //  markers = _createMarker();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              markers: markers,
              initialCameraPosition: CameraPosition(
                  target: LatLng(
                      double.parse(widget.lat), double.parse(widget.lon)),
                  zoom: 15.0),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              /* onMapCreated: (GoogleMapController controller) {

                _controller.complete(controller);

              },
*/
            ),
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final Set<Polyline> poly = {};
}
