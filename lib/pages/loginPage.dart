import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/lang/localss.dart';
import 'package:warehouse/pages/homePage.dart';
import 'package:warehouse/repository/loginRepository.dart';
import 'package:warehouse/response/loginResponse.dart';
import 'package:toast/toast.dart';

class login extends StatefulWidget {
  @override
  _login createState() => new _login();
}

class _login extends State<login> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  ProgressDialog pr;
  String msgError;
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


  @override
  void initState() {
    navigationPage();
    super.initState();
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
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/registration.jpg'),
          fit: BoxFit.fill,
        )),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 70, 0, 30),
                  child: Text(
                    AppLocalizations().lbLogin,
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        color: Colors.praimarydark),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 70, 30, 10),
                  child: TextField(
                    controller: _username,
                    cursorColor: Colors.praimarydark,
                    style: TextStyle(color: Colors.praimarydark),
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.transparent,
                      hintText: AppLocalizations().lbUser,
                      hintStyle: TextStyle(color: Colors.praimarydark),
                      //can also add icon to the end of the textfiled
                      //  suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: TextField(
                    controller: _password,
                    cursorColor: Colors.praimarydark,
                    obscureText: true,
                    style: TextStyle(color: Colors.praimarydark),
                    decoration: InputDecoration(
                      filled: true,

                      fillColor: Colors.transparent,
                      hintText:  AppLocalizations().lbPass,
                      hintStyle: TextStyle(color: Colors.praimarydark),
                      //can also add icon to the end of the textfiled
                      //  suffixIcon: Icon(Icons.remove_red_eye),
                    ),
                  ),
                ),
                msgError == null
                    ? Visibility(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          child: Text(
                            '$msgError',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                        visible: false,
                      )
                    : Visibility(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                          child: Text(
                            '$msgError',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                        visible: true,
                      ),
                Padding(
                  padding: EdgeInsets.fromLTRB(115, 80, 115, 50),
                  child: GestureDetector(
                      onTap: () {
                        _buildSubmitForm(context);
                      },
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Center(
                            child: Text(
                              AppLocalizations().lbSubmit,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Colors.praimarydark),
                      )),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 40),
                  child: GestureDetector(
                      onTap: () {
                        //_buildSubmitForm(context);
                      },
                      child: Text(
                        AppLocalizations().lbFor,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  _buildSubmitForm(BuildContext context) async {
    String workingTime;
    pr.show();

    Map<String, dynamic> data = {
      "Username": _username.text,
      "Password": _password.text,
    };
    print(data);
    final LoginRepository _repository = LoginRepository();

    loginResponse res = await _repository.login(data,langSave);
    /*  apiRequest('http://api.mypharma-order.com:8080/APIS/api/Authentication/Login', {
      "Email": _email.text,
      "Password": _password.text,
    });*/

    if (res.code == "1") {
      pr.hide().then((isHidden) {
        print(isHidden);
      });

      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString('sessionId', res.data.sessionId.toString());
      prefs.setString('username', res.data.username.toString());
      prefs.setString('roleId', res.data.roleId.toString());
      prefs.setString('id', res.data.id.toString());
      prefs.setString(
          'RequireRestPassword', res.data.RequireRestPassword.toString());

      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => Directionality(
            textDirection:
            langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child:homePage()),
        ),
      );
    } else {
      pr.hide().then((isHidden) {
        print(isHidden);
      });
      setState(() {
        msgError = res.msg.toString();
      });
    }
  }
}
