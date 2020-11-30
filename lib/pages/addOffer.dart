import 'package:toast/toast.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/lang/localss.dart';
import 'package:warehouse/repository/drugRepository.dart';
import 'package:warehouse/response/registerResponse.dart';
import 'package:intl/date_symbol_data_local.dart';

class addOffer extends StatefulWidget {
  final String DrugId;

  final String DrugName;
  final String wareId;
  final String gen;
  final String phprice;

  addOffer(this.DrugId, this.DrugName, this.wareId, this.gen, this.phprice);

  @override
  _addOffer createState() => new _addOffer();
}

class _addOffer extends State<addOffer> {
  String isgift, isdiscount;
  DateFormat format ;

  String exdateSt;

  var exDate = GlobalKey<FormState>();

  ProgressDialog pr;

//  Location _location = new Location();
  final _des = TextEditingController();
  final _quan = TextEditingController();
  final _gift = TextEditingController();
  final _discount = TextEditingController();
  final _notes = TextEditingController();

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
    format   = DateFormat("dd-MM-yyyy");
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
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Text(
            widget.DrugName,
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
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: _des,
                    cursorColor: Colors.praimarydark,
                    style: TextStyle(color: Colors.praimarydark),
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.transparent,
                      hintText: AppLocalizations().lbDes,
                      hintStyle: TextStyle(color: Colors.praimarydark),
                      //can also add icon to the end of the textfiled
                      //  suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                widget.gen,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.praimarydark),
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                widget.phprice,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.praimarydark),
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
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: _quan,
                    cursorColor: Colors.praimarydark,
                    style: TextStyle(color: Colors.praimarydark),
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.transparent,
                      hintText: AppLocalizations().lbQuan,
                      hintStyle: TextStyle(color: Colors.praimarydark),
                      //can also add icon to the end of the textfiled
                      //  suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                isdiscount == null
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                            hintText: AppLocalizations().lbGift,
                            hintStyle: TextStyle(color: Colors.praimarydark),
                            //can also add icon to the end of the textfiled
                            //  suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                      )
                    : isdiscount == ""
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                hintText: AppLocalizations().lbGift,
                                hintStyle:
                                    TextStyle(color: Colors.praimarydark),
                                //can also add icon to the end of the textfiled
                                //  suffixIcon: Icon(Icons.remove_red_eye),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                          AppLocalizations().lbGift,
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
                          ),
                isgift == null
                    ? Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(),
                          enableInteractiveSelection: true,
                          controller: _discount,
                          cursorColor: Colors.praimarydark,
                          onChanged: (val) {
                            isEmpty();
                          },
                          style: TextStyle(color: Colors.praimarydark),
                          decoration: InputDecoration(
                            filled: true,

                            fillColor: Colors.transparent,
                            hintText: AppLocalizations().lbDis,
                            hintStyle: TextStyle(color: Colors.praimarydark),
                            //can also add icon to the end of the textfiled
                            //  suffixIcon: Icon(Icons.remove_red_eye),
                          ),
                        ),
                      )
                    : isgift == ""
                        ? Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: TextField(
                              keyboardType: TextInputType.numberWithOptions(),
                              enableInteractiveSelection: true,
                              controller: _discount,
                              cursorColor: Colors.praimarydark,
                              onChanged: (val) {
                                isEmpty();
                              },
                              style: TextStyle(color: Colors.praimarydark),
                              decoration: InputDecoration(
                                filled: true,

                                fillColor: Colors.transparent,
                                hintText: AppLocalizations().lbDis,
                                hintStyle:
                                    TextStyle(color: Colors.praimarydark),
                                //can also add icon to the end of the textfiled
                                //  suffixIcon: Icon(Icons.remove_red_eye),
                              ),
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                          AppLocalizations().lbDis,
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
                          ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: _notes,
                    cursorColor: Colors.praimarydark,
                    style: TextStyle(color: Colors.praimarydark),
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.transparent,
                      hintText: AppLocalizations().lbNote,
                      hintStyle: TextStyle(color: Colors.praimarydark),
                      //can also add icon to the end of the textfiled
                      //  suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                            return AppLocalizations().lbExDate;
                          }
                        },
                        decoration: InputDecoration(labelText: AppLocalizations().lbExDate),
                        //   initialValue: DateTime.now(), //Add this in your Code.
                        // initialDate: DateTime(2017),
                        onSaved: (value) {
                          exdateSt = value.toString().substring(0, 10);
                          debugPrint(value.toString());
                        },
                      ),
                    ),
                    visible: true,
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
                        AppLocalizations().lbAdd,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _buildSubmitForm(BuildContext context) async {
if(_des.text!=""&&_quan.text!=""&&(_gift.text!=""||_discount.text!="")&&_notes.text!=""){
  if (exDate.currentState.validate()) {
    pr.show();
    exDate.currentState.save();

    var preferences = await SharedPreferences.getInstance();
    String sessionId = preferences.getString('sessionId');

    Map<String, dynamic> data = {
      "Description": _des.text,
      "DurgId": widget.DrugId,
      "Quantity": _quan.text,
      "Price": widget.phprice,
      "Duration": 3500,
      "WarehouseId": widget.wareId,
      "Status": 1,
      "Gift": _gift.text,
      "Notes": _notes.text,
      "ExpiryDate": exdateSt,
      "Discount": _discount.text,
      "TotalPrice": 0
    };
    //  ProjectBloc().addProjectRevnue(data);
    // BankBloc().addBankCommission(data);
    print(data);
    final DurgsRepository _repository = DurgsRepository();
    registerResponse response = await _repository.addOffer(sessionId, data,langSave);
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
      Toast.show(response.msg.toString(), context,
          duration: 4, gravity: Toast.BOTTOM);
    }
  } else {}

}else{
 if(_des.text==""){
   if(langSave=='ar'){
     Toast.show(
         'الرجاء ادخال '+ AppLocalizations().lbDes,
         context,
         duration: 4,
         gravity: Toast.BOTTOM);
   }else{
     Toast.show(
         AppLocalizations().lbDes+' please insert ',
         context,
         duration: 4,
         gravity: Toast.BOTTOM);
   }
 }else if(_quan.text==""){
   if(langSave=='ar'){
     Toast.show(
         'الرجاء ادخال '+ AppLocalizations().lbQuan,
         context,
         duration: 4,
         gravity: Toast.BOTTOM);
   }else{
     Toast.show(
         AppLocalizations().lbQuan+' please insert ',
         context,
         duration: 4,
         gravity: Toast.BOTTOM);
   }}else if(_gift.text==""&&_discount.text==""){
   if(langSave=='ar'){
     Toast.show(
         'الرجاء ادخال الهدية او الخصم ',
         context,
         duration: 4,
         gravity: Toast.BOTTOM);
   }else{
     Toast.show(
        ' please insert the gift or discount ',
         context,
         duration: 4,
         gravity: Toast.BOTTOM);
   }}
 else if(_notes.text==""){
   if(langSave=='ar'){
     Toast.show(
         'الرجاء ادخال ملاحظة ',
         context,
         duration: 4,
         gravity: Toast.BOTTOM);
   }else{
     Toast.show(
         ' please insert the note ',
         context,
         duration: 4,
         gravity: Toast.BOTTOM);
   }}
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
