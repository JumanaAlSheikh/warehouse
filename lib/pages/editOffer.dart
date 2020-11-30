import 'package:toast/toast.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:warehouse/pages/homePage.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/lang/localss.dart';
import 'package:warehouse/model/offerHomeModel.dart';
import 'package:warehouse/repository/drugRepository.dart';
import 'package:warehouse/response/registerResponse.dart';

class editOffer extends StatefulWidget {
  offersAllList itemsOffer;
homePage home;
  editOffer(this.itemsOffer,this.home);

  @override
  _editOffer createState() => new _editOffer();
}

class _editOffer extends State<editOffer> {
  String isgift, isdiscount;
  intl.DateFormat format ;

  String exdateSt;

  var exDate = GlobalKey<FormState>();

  ProgressDialog pr;

//  Location _location = new Location();
  final _des = TextEditingController();
  final _genP = TextEditingController();
  final _phaP = TextEditingController();
  final _quan = TextEditingController();
  final _gift = TextEditingController();
  final _discount = TextEditingController();
  final _notes = TextEditingController();
  final _totalp = TextEditingController();

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
    var preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    initializeDateFormatting();
    format   = intl.DateFormat("dd-MM-yyyy");
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
    //  navigationPage();
  }

  @override
  Widget build(BuildContext context) {
    return new
    WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => Directionality(
                      textDirection:
                      langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                      child: homePage())
              ),
              ModalRoute.withName("/Home")
          );



        },child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text(
            widget.itemsOffer.Durg,
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
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations().lbDes+' : ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextField(
                          controller: _des,
                          cursorColor: Colors.praimarydark,
                          style: TextStyle(color: Colors.praimarydark),
                          decoration: InputDecoration(
                            filled: true,

                            fillColor: Colors.transparent,
                            hintText: widget.itemsOffer.Description,
                            hintStyle: TextStyle(color: Colors.praimarydark),
                            //can also add icon to the end of the textfiled
                            //  suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(     AppLocalizations().lbGePrice+' : ',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Container(
                          height: 50,
                          color: Colors.black12,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      widget.itemsOffer.NormalPrice,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.praimarydark),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Divider(
                                  color: Colors.praimarydark,
                                  height: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(     AppLocalizations().lbPhPrice+' : ',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextField(
                          controller: _phaP,
                          cursorColor: Colors.praimarydark,
                          style: TextStyle(color: Colors.praimarydark),
                          decoration: InputDecoration(
                            filled: true,

                            fillColor: Colors.transparent,
                            hintText: widget.itemsOffer.Price,
                            hintStyle: TextStyle(color: Colors.praimarydark),
                            //can also add icon to the end of the textfiled
                            //  suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(     AppLocalizations().lbQuan+' : ',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextField(
                          controller: _quan,
                          cursorColor: Colors.praimarydark,
                          style: TextStyle(color: Colors.praimarydark),
                          decoration: InputDecoration(
                            filled: true,

                            fillColor: Colors.transparent,
                            hintText: widget.itemsOffer.Quantity,
                            hintStyle: TextStyle(color: Colors.praimarydark),
                            //can also add icon to the end of the textfiled
                            //  suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                widget.itemsOffer.Gift != ""
                    ? Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(     AppLocalizations().lbGift+' : ',
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: TextField(
                          onChanged: (val) {
                            isEmptygift();
                          },
                          controller: _gift,
                          cursorColor: Colors.praimarydark,
                          style: TextStyle(color: Colors.praimarydark),
                          decoration: InputDecoration(
                            filled: true,

                            fillColor: Colors.transparent,
                            hintText: widget.itemsOffer.Gift,
                            hintStyle:
                            TextStyle(color: Colors.praimarydark),
                            //can also add icon to the end of the textfiled
                            //  suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                      )
                    ],
                  ),
                )
                    : Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(     AppLocalizations().lbDis+' : ',
                              style:
                              TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextField(
                            onChanged: (val) {
                              isEmptygift();
                            },
                            controller: _discount,
                            cursorColor: Colors.praimarydark,
                            style: TextStyle(color: Colors.praimarydark),
                            decoration: InputDecoration(
                              filled: true,

                              fillColor: Colors.transparent,
                              hintText: widget.itemsOffer.Discount,
                              hintStyle:
                              TextStyle(color: Colors.praimarydark),
                              //can also add icon to the end of the textfiled
                              //  suffixIcon: Icon(Icons.remove_red_eye),
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(     AppLocalizations().lbCreDate+' : ',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Container(
                            height: 50,
                            color: Colors.black12,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        widget.itemsOffer.CreateDate
                                            .substring(0, 10),
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.praimarydark),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Divider(
                                    color: Colors.praimarydark,
                                    height: 2,
                                  ),
                                )
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(     AppLocalizations().lbNote+' : ',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: TextField(
                            controller: _notes,
                            cursorColor: Colors.praimarydark,
                            style: TextStyle(color: Colors.praimarydark),
                            decoration: InputDecoration(
                              filled: true,

                              fillColor: Colors.transparent,
                              hintText: widget.itemsOffer.Notes,
                              hintStyle: TextStyle(color: Colors.praimarydark),
                              //can also add icon to the end of the textfiled
                              //  suffixIcon: Icon(Icons.remove_red_eye),
                            ),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(     AppLocalizations().lbExDate+' : ',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Visibility(
                            child: Form(
                              key: exDate,
                              child: DateTimeField(
                                onShowPicker: (context, currentValue) {
                                  return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate: DateTime.now(),
                                      lastDate: DateTime(2100));
                                },
                                format: format,
                                validator: (val) {
                                  if (val != null) {
                                    return null;
                                  } else {
                                    return      AppLocalizations().lbExDate;
                                  }
                                },
                                decoration: InputDecoration(
                                    labelText: widget.itemsOffer.ExpiryDate
                                        .substring(0, 10)),
                                //   initialValue: DateTime.now(), //Add this in your Code.
                                // initialDate: DateTime(2017),
                                onSaved: (value) {
                                  if (value == null) {
                                    exdateSt = widget.itemsOffer.ExpiryDate
                                        .substring(0, 10);
                                  } else {
                                    exdateSt =
                                        value.toString().substring(0, 10);
                                  }
                                },
                              ),
                            ),
                            visible: true,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(     AppLocalizations().lbToPrice+' : ',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Container(
                          height: 50,
                          color: Colors.black12,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      widget.itemsOffer.TotalPrice,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.praimarydark),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                child: Divider(
                                  color: Colors.praimarydark,
                                  height: 2,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Center(
                    child: RaisedButton(
                      onPressed: () {
                        _buildSubmitForm(context);
                        /* Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              verifyCode(),
                                        ),
                                      );*/
                      },
                      disabledColor: Colors.praimarydark,
                      color: Colors.praimarydark,
                      child: Text(
                        AppLocalizations().lbDone,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )))


   ;
  }

  _buildSubmitForm(BuildContext context) async {
    pr.show();
    exDate.currentState.save();

    var preferences = await SharedPreferences.getInstance();
    String sessionId = preferences.getString('sessionId');

    Map<String, dynamic> data = {
      "Id": widget.itemsOffer.id.toString(),
      "Description":
          _des.text == "" ? widget.itemsOffer.Description : _des.text,
      "DurgId": widget.itemsOffer.DurgId,
      "Quantity": _quan.text == "" ? widget.itemsOffer.Quantity : _quan.text,
      "Price": _phaP.text == "" ? widget.itemsOffer.Price : _phaP.text,
      "Duration": 3500,
      "WarehouseId": widget.itemsOffer.WarehouseId,
      "Status": 1,
      "Gift": _gift.text == "" ? widget.itemsOffer.Gift : _gift.text,
      "Notes": _notes.text == "" ? widget.itemsOffer.Notes : _notes.text,
      "ExpiryDate": exdateSt,
      "Discount":
          _discount.text == "" ? widget.itemsOffer.Discount : _discount.text,
      "TotalPrice": widget.itemsOffer.TotalPrice
    };
    //  ProjectBloc().addProjectRevnue(data);
    // BankBloc().addBankCommission(data);
    print(data);
    final DurgsRepository _repository = DurgsRepository();
    registerResponse response = await _repository.editOffer(sessionId, data,langSave);
    print(response.code);
    //  GeneralResponse response = await _repository.addProjectRevnue(data);
    if (response.code == '1') {
    //  getValueString();
      //Navigator.pop(context, true);
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => Directionality(
              textDirection:
              langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
              child:homePage()),
        ),
      );
     // widget.home.createState();

    } else {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      Toast.show(response.msg.toString(), context,
          duration: 4, gravity: Toast.BOTTOM);
    }
  }

  String isEmpty() {
    setState(() {
      if (_discount.text != null || _discount.text != " ") {
        isdiscount = _discount.text;
      }
    });
    return isdiscount;
  }

  String isEmptygift() {
    setState(() {
      if (_gift.text != null || _gift.text != "") {
        isgift = _gift.text;
      }
    });
    return isgift;
  }
}
