import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:warehouse/lang/localss.dart';
import 'package:warehouse/pages/drugListPage.dart';
import 'package:warehouse/pages/myDrugListPage.dart';

import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class drugPage extends StatefulWidget {
  final String lang;


  drugPage(this.lang);
  @override
  _drugPage createState() => new _drugPage();
}

class _drugPage extends State<drugPage> {
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
  }

  @override
  Widget build(BuildContext context) {
   // print('test'+langSave);

    return new Scaffold(
      //   resizeToAvoidBottomPadding: true,
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              child: Icon(Icons.arrow_back_ios),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                    icon: Image.asset(
                  'assets/images/drughome.png',
                  color: Colors.white,
                )),
                Tab(
                    icon: Image.asset(
                  'assets/images/mydrug.png',
                  color: Colors.white,
                )),
              ],
            ),
            title: Text(AppLocalizations().lbSyriaD),
          ),
          body: TabBarView(
            children: [Directionality(
          textDirection:
          widget.lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child:drugLP()), Directionality(
          textDirection:
          widget.lang == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child:drugLPMy())],
          ),
        ),
      ),
    );
  }
}
