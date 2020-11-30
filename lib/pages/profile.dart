import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:toast/toast.dart';
import 'package:location/location.dart';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:warehouse/lang/localss.dart';
import 'package:warehouse/pages/LocalHelper.dart';
import 'package:warehouse/pages/splashPage.dart';
import 'package:warehouse/repository/drugRepository.dart';
import 'package:warehouse/response/registerResponse.dart';
import 'package:warehouse/pages/drugPage.dart';
import 'package:geolocator/geolocator.dart' as geo;

class profile extends StatefulWidget {
  @override
  _profile createState() => new _profile();
}

class _profile extends State<profile> {
  GlobalKey<FormState> _keyFormDeposit = GlobalKey();
  final _pass = new TextEditingController();
  ProgressDialog pr;
  geo.Position res;

  final _min = new TextEditingController();
  bool monVal = false;
  SpecificLocalizationDelegate _specificLocalizationDelegate;
  String langSave;

  Future<void> getCurrentLocation() async {
    geo.Position posiion = await geo.Geolocator().getCurrentPosition(desiredAccuracy: geo.LocationAccuracy.high);
    setState(() {
      res = posiion;
      //    _createMarker();
      //  markers = _createMarker();
    });
  }
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

  Widget showDialogLang() {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/alert.png'),
                    fit: BoxFit.fill)),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    AppLocalizations().lbChangeL,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.praimarydark),
                  ),
                ),
                GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('English'),
                    ),
                    onTap: () async {
                      var preferences = await SharedPreferences.getInstance();

                      AppLocalizations().locale == 'en';
                      helper.onLocaleChanged(new Locale("en"));
                      AppLocalizations.load(new Locale("en"));
                      preferences.setString('lang', 'en');

                      preferences.remove('sessionId');

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Directionality(
                                  textDirection: langSave == 'ar'
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                                  child: Splash())),
                          ModalRoute.withName("/Home"));
                    }),
                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('العربية'),
                  ),
                  onTap: () async {
                    String lang = AppLocalizations().locale;
                    var preferences = await SharedPreferences.getInstance();

// Save a value

                    AppLocalizations().locale == 'ar';
                    helper.onLocaleChanged(new Locale("ar"));
                    AppLocalizations.load(new Locale("ar"));
                    preferences.setString('lang', 'ar');

                    preferences.remove('sessionId');

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Directionality(
                                textDirection: langSave == 'ar'
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                child: Splash())),
                        ModalRoute.withName("/Home"));
                  },
                ),
              ],
            )),
      ),
    );
  }
  Future<bool> getLocationPermission() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {}
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {}
    }

    _locationData = await location.getLocation();
    print(_locationData);
    setState(() {
      res = geo.Position(
          latitude: _locationData.latitude, longitude: _locationData.longitude);
    });
  }

  @override
  void initState() {
    getLocationPermission();
getCurrentLocation();
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
  }

  onLocaleChange(Locale locale) {
    _specificLocalizationDelegate = new SpecificLocalizationDelegate(locale);
  }

  @override
  Widget build(BuildContext context) {
    helper.onLocaleChanged = onLocaleChange;

    return new Scaffold(
        appBar: new AppBar(
          title: new Text(
            AppLocalizations().lbWareI,
          ),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations().lbDrug,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                          new Spacer(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => Directionality(
                              textDirection: langSave == 'ar'
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              child: drugPage(langSave)),
                        ),
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return showDialogLang();
                            });
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations().lbChangeL,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 17),
                            ),
                            new Spacer(),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 16,
                              ),
                            )
                          ],
                        ),
                      )),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  GestureDetector(
                      onTap: () {
                        getCurrentLocation();
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (_, __, ___) =>
                                map(res, this),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations().lbSetLoc,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 17),
                            ),
                            new Spacer(),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 16,
                              ),
                            )
                          ],
                        ),
                      )),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations().lbChangeP,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                          new Spacer(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return showDialogwindowAdd();
                            });
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Text(
                            AppLocalizations().lbAddM,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 17),
                          ),
                          new Spacer(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey,
                              size: 16,
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return MyDialog(this);
                            });
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 50, 20, 50),
                    child: GestureDetector(
                        onTap: () {
                          _buildSubmitForm(context);
                        },
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            child: Center(
                              child: Text(
                                AppLocalizations().lbLog,
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
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget showDialogwindowAdd() {
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

                        _buildSubmitFormCo(context);
                      }
                      //  textColor: Colors.yellow,colorBrightness: Brightness.dark,
                      ,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      disabledColor: Colors.yellow,
                      child: Center(
                        child: new Text(
                          AppLocalizations().lbDone,
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

  _buildSubmitFormCo(BuildContext context) async {
    pr.show();
    var preferences = await SharedPreferences.getInstance();
    String sessionId = preferences.getString('sessionId');
    String wareid = preferences.getString('id');

    Map<String, dynamic> data = {"Id": wareid, "Password": _pass.text};
    //  ProjectBloc().addProjectRevnue(data);
    // BankBloc().addBankCommission(data);
    print(data);
    final DurgsRepository _repository = DurgsRepository();
    registerResponse response =
        await _repository.chacnePass(sessionId, data, langSave);

    //  GeneralResponse response = await _repository.addProjectRevnue(data);
    if (response.code == '1') {
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

  _buildSubmitForm(BuildContext context) async {
    var preferences = await SharedPreferences.getInstance();

    preferences.remove('sessionId');

    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => Directionality(
            textDirection:
                langSave == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child: Splash()),
      ),
    );
  }

  _buildSubmitFormMin(BuildContext context, bool ischeck, String min) async {
    pr.show();
    var preferences = await SharedPreferences.getInstance();
    String sessionId = preferences.getString('sessionId');

    Map<String, dynamic> data = {
      "MinOrderValue": min,
      "DeliveryStatus": ischeck == true ? '1' : '0'
    };
    //  ProjectBloc().addProjectRevnue(data);
    // BankBloc().addBankCommission(data);
    print(data);
    final DurgsRepository _repository = DurgsRepository();
    registerResponse response =
        await _repository.addDeleviry(sessionId, data, langSave);

    //  GeneralResponse response = await _repository.addProjectRevnue(data);
    if (response.code == '1') {
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
}

class MyDialog extends StatefulWidget {
  _profile bankA;

  MyDialog(this.bankA);

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  GlobalKey<FormState> _keyFormDeposit = GlobalKey();
  final _pass = new TextEditingController();
  ProgressDialog pr;
  final _min = new TextEditingController();
  bool monVal = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations().lbMin),
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
                      controller: _min,
                      decoration: InputDecoration(
                        filled: true,
                        hintText: AppLocalizations().lbMinP,
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
                  padding: EdgeInsets.fromLTRB(15, 35, 15, 0),
                  child: Material(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            value: monVal,
                            onChanged: (bool value) {
                              setState(() {
                                monVal = value;
                              });
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Text(AppLocalizations().lbDev),
                          ),
                        ],
                      )),
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

                        widget.bankA
                            ._buildSubmitFormMin(context, monVal, _min.text);
                      }
                      //  textColor: Colors.yellow,colorBrightness: Brightness.dark,
                      ,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      disabledColor: Colors.yellow,
                      child: Center(
                        child: new Text(
                          AppLocalizations().lbDone,
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
}
class map extends StatefulWidget {
  final geo.Position pos;

  final _profile reg;

  map(this.pos, this.reg);

  @override
  _map createState() => new _map();
}

class _map extends State<map> {
  GoogleMapController mapController;

  String lat;

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> markers;

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
          markerId: MarkerId(AppLocalizations().lbLoccation),
          position: LatLng(widget.pos.latitude, widget.pos.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: AppLocalizations().lbLoccation))
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
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              markers: markers,
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.pos.latitude, widget.pos.longitude),
                  zoom: 1.0),
              mapType: MapType.normal,
              mapToolbarEnabled: false,
              onTap: (position) {
                Marker mk1 = Marker(
                  infoWindow: InfoWindow(
                      title: position.latitude.toString() +
                          ',' +
                          position.longitude.toString()),
                  markerId: MarkerId('1'),
                  position: position,
                );

                setState(() {
                  markers.clear();
                  markers.add(mk1);
                  saveValue(position.latitude.toString(),
                      position.longitude.toString());

// Save a value
                  // Navigator.of(context).pop();

                  print(position.latitude.toString());
                });
              },
              onMapCreated: _onMapCreated,
              /* onMapCreated: (GoogleMapController controller) {

                _controller.complete(controller);

              },
*/
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: FloatingActionButton.extended(
                  icon: Icon(Icons.location_on),
                  label: Text(AppLocalizations().lbDone),
                  onPressed: () {
                    saveValuede(widget.pos.latitude.toString(),
                        widget.pos.longitude.toString());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  saveValue(String lat, String lon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lat', lat);

    prefs.setString('lon', lon);

    widget.reg.setState(() {
      widget.reg.initState();
    });
    String sessionId = prefs.getString('sessionId');
    Map<String, dynamic> data = {"Longitude": lon, "Latitude":lat};
    //  ProjectBloc().addProjectRevnue(data);
    // BankBloc().addBankCommission(data);
    print(data);
    final DurgsRepository _repository = DurgsRepository();
    registerResponse response =
    await _repository.setLocation(sessionId, data);
    if (response.code == '1') {


      Navigator.pop(context, true);
    } else {

      Toast.show(response.msg.toString(), context,
          duration: 4, gravity: Toast.BOTTOM);
    }


  }

  saveValuede(String lat, String lon) async {
    var preferences = await SharedPreferences.getInstance();
    String latdefault = preferences.getString('lat');
    String londe = preferences.getString('lon');

    if (latdefault == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lat', widget.pos.latitude.toString());

      prefs.setString('lon', widget.pos.longitude.toString());
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('lat', latdefault);

      prefs.setString('lon', londe);
    }

    widget.reg.setState(() {
      widget.reg.initState();
    });
    String sessionId = preferences.getString('sessionId');
    Map<String, dynamic> data = {"Longitude": lon, "Latitude":lat};
    //  ProjectBloc().addProjectRevnue(data);
    // BankBloc().addBankCommission(data);
    print(data);
    final DurgsRepository _repository = DurgsRepository();
    registerResponse response =
    await _repository.setLocation(sessionId, data);
    if (response.code == '1') {


      Navigator.pop(context, true);
    } else {

      Toast.show(response.msg.toString(), context,
          duration: 4, gravity: Toast.BOTTOM);
    }


  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  final Set<Polyline> poly = {};
}