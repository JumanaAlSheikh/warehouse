import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_version/get_version.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:warehouse/repository/HomeRepository.dart';
import 'package:warehouse/response/checkResponse.dart';

import '../lang/localss.dart';
import 'homePage.dart';
import 'loginPage.dart';

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> with SingleTickerProviderStateMixin{
  String sessionId,urlDou,idu;
  String _platformVersion = 'Unknown';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';
  String isversion;
//  Animation<double> animation;
  SpecificLocalizationDelegate _specificLocalizationDelegate;
  String langSave;
//  AnimationController animationController;
  var _visible = true;

  startTime() async {
    var _duration = new Duration(seconds: 4);

    return new Timer(_duration, navigationPage);
  }

  checkResponse response;

  @override
  void initState() {
    //  navigationPage();
//    animationController = new AnimationController(
//        vsync: this, duration: new Duration(seconds: 10));
//
//    animation =
//    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
//
//    animation.addListener(() => this.setState(() {}));
//
//    animationController.forward();
//
//    setState(() {
//      _visible = !_visible;
//    });

    startTime();
  }

  Future navigationPage() async {

    var preferences = await SharedPreferences.getInstance();
    sessionId = preferences.getString('sessionId');
    //  initPlatformState(sessionId);
    idu = preferences.getString('idu');
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
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get build number.';
    }

    String projectAppID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectAppID = await GetVersion.appID;
    } on PlatformException {
      projectAppID = 'Failed to get app ID.';
    }

    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectName = await GetVersion.appName;
    } on PlatformException {
      projectName = 'Failed to get app name.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });



    final HomeRepository _repository = HomeRepository();
    response =
    await _repository.checkForUpdate(sessionId, projectCode,langSave);

    //  GeneralResponse response = await _repository.addProjectRevnue(data);
    if (response.code == '1') {
      if(response.results.isActive.toString()=='1')
      {
        if(sessionId!=null){
          /*    Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) =>
                  homePage(idu),
            ),
          );*/
          Route route = MaterialPageRoute(builder: (context) =>

              Directionality(
                  textDirection:
                  langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                  child: homePage()
              ));
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
          /* Route route = MaterialPageRoute(builder: (context) => homePage());
    Navigator.pushReplacement(context, route);
    //  Navigator.pop(context);
//         SystemNavigator.pop();*/

        }else {


          // return  login();
          Route route = MaterialPageRoute(builder: (context) =>

              Directionality(
                  textDirection:
                  langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                  child: login()
              ));


          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        }
      }else{
        setState(() {
          isversion='1';
          urlDou=response.results.url.toString();
        });

      }
    }
    else {

    }

  }




  @override
  Widget build(BuildContext contextt) {

    return new Stack(children: <Widget>[

      Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Welcome In warehouse App',
                  style: new TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.praimarydark,
                      fontSize: 20.0),
                ),
                isversion!='1'?
                new Image.asset(
                  'assets/images/warelogos.png',
                  width: 150,
                  height:150,
                ):
                new Image.asset(
                    'assets/images/warelogos.png',
                    width:100,
                    height: 100
                ),
                Padding(padding: EdgeInsets.all(0.0),
                    child:isversion=='1'?Visibility(visible: true,child: Center(child:Padding(padding:EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[ Padding(
                          padding: EdgeInsets.fromLTRB(15, 40, 15, 10),
                          child: new RaisedButton(
                              onPressed: () {
                                print(urlDou);


                                _launchURL();
                                //  openBrowserTab();
                                //    _buildSubmitFormCo(context, wareId, offerId, dateD);
                              }
                              //  textColor: Colors.yellow,colorBrightness: Brightness.dark,
                              ,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              color: Colors.praimarydark,
                              child: Center(
                                child: new Text(
                                  'Update',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ), Padding(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
                          child: new RaisedButton(
                              onPressed: () {

                                if(sessionId!=null){
                                  /* Navigator.of(contextt).push(
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        homePage(idu),
                                  ),
                                );*/
                                  Route route = MaterialPageRoute(builder: (context) =>  Directionality(
                                      textDirection:
                                      langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                      child: homePage()
                                  ));
                                  Navigator.pushAndRemoveUntil(context, route, (route) => false);
                                }else {
                                  Route route = MaterialPageRoute(builder: (context) =>  Directionality(
                                      textDirection:
                                      langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                      child: login()
                                  ));
                                  Navigator.pushAndRemoveUntil(context, route, (route) => false);
                                }



                                //    _buildSubmitFormCo(context, wareId, offerId, dateD);
                              }
                              //  textColor: Colors.yellow,colorBrightness: Brightness.dark,
                              ,
                              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              color: Colors.praimarydark,
                              child: Center(
                                child: new Text(
                                  'Skip',
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        )],
                      ),))
                    ):Visibility(visible: false,child: Text('sdkjvs'),))
              ],
            ),

          ],
        ),
      ),




    ],);
  }
  _launchURL() async {
    if (await canLaunch(urlDou)) {
      await launch(
        urlDou,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $urlDou';
    }

  }
  @override
  void dispose() {
//    animationController.dispose();
    super.dispose();
  }

}
