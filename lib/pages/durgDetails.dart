import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/bloc/blocDrug.dart';
import 'package:warehouse/lang/localss.dart';
import 'package:warehouse/response/drugDetailsResponse.dart';

class durgDetails extends StatefulWidget {
  final String nameDurg;

  final String id;

  durgDetails(this.nameDurg, this.id);

  @override
  _durgsList createState() => new _durgsList();
}

class _durgsList extends State<durgDetails> {
  String sessionId;
  var preferences;
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

    Map<String, dynamic> data = {
      "Id": widget.id,
    };

    blocDurgs.getDurgsDetails(sessionId, data,langSave);
  }

  @override
  void initState() {
    navigationPage();
    getValueString();

    //  navigationPage();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          widget.nameDurg.toString(),
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
        stream: blocDurgs.subjectdetails.stream,
        builder: (BuildContext context,
            AsyncSnapshot<durgDetailsResponse> snapshot) {
          if (snapshot.hasData) {
            /*if (snapshot.data.error != null && snapshot.data.error.length > 0) {
          return ErrorHandle(snapshot.data.error);
        }*/

            return new ListView(
              shrinkWrap: true,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
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
                                          snapshot.data.results.CommerceNameEn
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.praimarydark,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(20, 20, 20, 10),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          snapshot.data.results.Strengths
                                              .toString(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 2, 0, 3),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              snapshot
                                                  .data.results.ScientificNameEn
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 10, 20, 0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.results.Category
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      )),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 20, 40),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              snapshot.data.results.Manufacture
                                                  .toString(),
                                              style: TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return Text(AppLocalizations().lbError);
          } else {
            return Text(AppLocalizations().lbLoad);
          }
        },
      ),
    );
  }
}
