import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:warehouse/lang/messages_all.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();

    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;

      return new AppLocalizations();
    });
  }

  String get locale {
    return Intl.message('en', name: 'locale');
  }
  String get lbWait {
    return Intl.message('Wait', name: 'lbWait');
  }
  String get lbDes {
    return Intl.message('Description', name: 'lbDes');
  }

  String get lbLogin {
    return Intl.message('Login', name: 'lbLogin');
  }
  String get lbEmail {
    return Intl.message('Email', name: 'lbEmail');
  }
  String get lbPass {
    return Intl.message('Password', name: 'lbPass');
  }
  String get lbSubmit {
    return Intl.message('Submit', name: 'lbSubmit');
  }
  String get lbSelectDate {
    return Intl.message('Please select delivary date', name: 'lbSelectDate');
  }
  String get lbinsertDate {
    return Intl.message('Please Insert delivary date', name: 'lbinsertDate');
  }
  String get lbDDate {
    return Intl.message('Delivary Date', name: 'lbDDate');
  }
  String get lbCancel {
    return Intl.message('Cancel', name: 'lbCancel');
  }
  String get lbUser {
    return Intl.message('Username', name: 'lbUser');
  }

  String get lbChangeS {
    return Intl.message('Change Status', name: 'lbChangeS');
  }

  String get lbOfferD {
    return Intl.message('Offer Details', name: 'lbOfferD');}
  String get lbDate {
    return Intl.message('Date', name: 'lbDate');}


  String get lbAddO {
    return Intl.message('Add Offer', name: 'lbAddO');}
  String get lbDelete {
    return Intl.message('Delete', name: 'lbDelete');}
  String get lbDeleteD {
    return Intl.message('Delete Drug', name: 'lbDeleteD');
  }  String get lbDeleteDM {
    return Intl.message('Are you sure to delete this drug from my drug', name: 'lbDeleteDM');
  }

  String get lbDeleteO {
    return Intl.message('Delete Offer', name: 'lbDeleteO');
  }  String get lbDeleteOM {
    return Intl.message('Are you sure to delete this offer', name: 'lbDeleteOM');
  }


  String get lbReg {
    return Intl.message('Register', name: 'lbReg');
  }
  String get lbFor {
    return Intl.message('Forget Password', name: 'lbFor');
  }

  String get lbCpass {
    return Intl.message('Confirm Password', name: 'lbCpass');
  }
  String get lbMyPro {
    return Intl.message('My Profile', name: 'lbMyPro');
  }

  String get lbCpassMatch {
    return Intl.message(' *New password and confirm is not match', name: 'lbCpassMatch');
  }


  String get lbPhasN {
    return Intl.message('Pharmacist Name', name: 'lbPhasN');
  }
  String get lbPhacN {
    return Intl.message('Pharmacy Name', name: 'lbPhacN');
  }


  String get lbPhone {
    return Intl.message('Phone', name: 'lbPhone');
  }


  String get lbEx {
    return Intl.message('Ex:', name: 'lbEx');
  }


  String get lbMobile {
    return Intl.message('Mobile', name: 'lbMobile');
  }

  String get lbSyNum {
    return Intl.message('Syndicate Number', name: 'lbSyNum');
  }
  String get lbLisNum {
    return Intl.message('License Number', name: 'lbLisNum');
  }
  String get lbAddress {
    return Intl.message('Address', name: 'lbAddress');
  }
  String get lbSelectc {
    return Intl.message('Select City', name: 'lbSelectc');
  }


  String get lbLoccation {
    return Intl.message('Loccation', name: 'lbLoccation');
  }
  String get lbBackLog {
    return Intl.message('Back To Login', name: 'lbBackLog');
  }
  String get lbNewPass {
    return Intl.message('New Password', name: 'lbNewPass');
  }

  String get lbWh {
    return Intl.message('Working Hours', name: 'lbWh');
  }
  String get lbFrom {
    return Intl.message('From', name: 'lbFrom');
  }
  String get lbTo {
    return Intl.message('To', name: 'lbTo');
  }
  String get lbPhotoSyn {
    return Intl.message('Add Your Syndicate Photo ', name: 'lbPhotoSyn');
  }
  String get lbAddI {
    return Intl.message('Add Image', name: 'lbAddI');
  }
  String get lbAddIP {
    return Intl.message('Please pick an image', name: 'lbAddIP');
  }
  String get lbPhotoPh {
    return Intl.message('Add Your Pharmacy Photo ', name: 'lbPhotoPh');
  }
  String get lbUpIS {
    return Intl.message('Image Uploaded Successfully!!!', name: 'lbUpIS');
  }
  String get lbUpIF {
    return Intl.message('Image Upload Failed!!!', name: 'lbUpIF');
  }
  String get lbSp {
    return Intl.message('SP', name: 'lbSp');
  }


  String get lbSyPS {
    return Intl.message('Please select the syndicate image', name: 'lbSyPS');
  } String get lbPhPS {
    return Intl.message('Please select the pharmacy image', name: 'lbPhPS');
  }


  String get lbGallery {
    return Intl.message('Select From Gallery', name: 'lbGallery');
  }
  String get lbCamera {
    return Intl.message('Use Camera', name: 'lbCamera');
  }
  String get lbPickI {
    return Intl.message('Pick an image', name: 'lbPickI');
  }
  String get lbDone {
    return Intl.message('Done', name: 'lbDone');
  }
  String get lbOk {
    return Intl.message('Ok', name: 'lbOk');
  }


  String get lbVerCode {
    return Intl.message('Verification Code', name: 'lbVerCode');
  }

  String get lbResVerCode {
    return Intl.message('Resend Verification Code', name: 'lbResVerCode');
  }
  String get lbVerAccount {
    return Intl.message('Verify Account', name: 'lbVerAccount');
  }
  String get lbEnDrugN {
    return Intl.message('Enter Drug Name', name: 'lbEnDrugN');
  }
  String get lbEnComN {
    return Intl.message('Enter Company Name', name: 'lbEnComN');
  }
  String get lbEnPhN {
    return Intl.message('Enter Pharmacy Name', name: 'lbEnPhN');
  }
  String get lbEnDrugW {
    return Intl.message('Warehouse Name Or Drug Name', name: 'lbEnDrugW');
  }
  String get lbWare {
    return Intl.message('Warehouse', name: 'lbWare');
  }
  String get lbWareN {
    return Intl.message('Warehouse Name', name: 'lbWareN');
  }
  String get lbOther {
    return Intl.message('Others', name: 'lbOther');
  }
  String get lbOreberN {
    return Intl.message('Oreder Number', name: 'lbOreberN');
  }

  String get lbHome {
    return Intl.message('HomePage', name: 'lbHome');
  }
  String get lbOffer {
    return Intl.message('Offer', name: 'lbOffer');
  }
  String get lbAds {
    return Intl.message('Ads', name: 'lbAds');
  }
  String get lbDrugN {
    return Intl.message('Drug Name', name: 'lbDrugN');
  }
  String get lbPrice {
    return Intl.message('Price', name: 'lbPrice');
  }  String get lbDrug {
    return Intl.message('Drugs', name: 'lbDrug');
  }
  String get lbCom {
    return Intl.message('Compains', name: 'lbCom');
  }
  String get lbFilA {
    return Intl.message('Filter by city/ All', name: 'lbFilA');
  }
  String get lbFil {
    return Intl.message('Filter by city/ ', name: 'lbFil');
  }
  String get lbFilAC {
    return Intl.message('Filter by category/ All', name: 'lbFilAC');
  }
  String get lbWD {
    return Intl.message('Workind days and times', name: 'lbWD');
  }
  String get lbFilC {
    return Intl.message('Filter by category/ ', name: 'lbFilC');
  }
  String get lbDis {
    return Intl.message('Discount', name: 'lbDis');
  }
  String get lbNote {
    return Intl.message('Notes', name: 'lbNote');
  }
  String get lbComN {
    return Intl.message('Company Name', name: 'lbComN');
  }
  String get lbClick {
    return Intl.message('Click try again to exit from application', name: 'lbClick');
  }
  String get lbDrugF {
    return Intl.message('Drug Form', name: 'lbDrugF');
  }
  String get lbDrugEx {
    return Intl.message('Drug Expired Date', name: 'lbDrugEx');
  }
  String get lbPhPrice {
    return Intl.message('Pharma Price', name: 'lbPhPrice');
  }
  String get lbGePrice {
    return Intl.message('General Price', name: 'lbGePrice');
  }
  String get lbQuan {
    return Intl.message('Quantity', name: 'lbQuan');
  }
  String get lbToPrice {
    return Intl.message('Total Price', name: 'lbToPrice');

  }
  String get lbExDate {
    return Intl.message('Expired Date', name: 'lbExDate');

  }
  String get lbExDateOff {
    return Intl.message('Expired Date Offer', name: 'lbExDateOff');

  }
  String get lbGift {
    return Intl.message('Gift', name: 'lbGift');

  }
  String get lbReq {
    return Intl.message('My Request', name: 'lbReq');

  }
  String get lbPharma {
    return Intl.message('Pharmacies', name: 'lbPharma');

  }

  String get lbRem {
    return Intl.message('Reminder', name: 'lbRem');

  }
  String get lbRemAt {
    return Intl.message('Reminder at', name: 'lbRemAt');

  }

  String get lbChangeL {
    return Intl.message('Change Language', name: 'lbChangeL');

  }
  String get lbSetLoc {
    return Intl.message('Set your location', name: 'lbSetLoc');

  }
  String get lbChangeP {
    return Intl.message('Change Password', name: 'lbChangeP');

  }


  String get lbMyOff {
    return Intl.message('My Offers', name: 'lbMyOff');

  } String get lbMyOrd {
    return Intl.message('My Orders', name: 'lbMyOrd');

  }

  String get lbAbout {
    return Intl.message('About', name: 'lbAbout');

  }
  String get lbPro {
    return Intl.message('Profile', name: 'lbPro');

  }
  String get lbLog {
    return Intl.message('LogOut', name: 'lbLog');

  }
  String get lbMin {
    return Intl.message('Minimum order', name: 'lbMin');

  }
  String get lbDev {
    return Intl.message('Deleviry', name: 'lbDev');

  }
  String get lbMinP {
    return Intl.message('Minimum order price', name: 'lbMinP');

  }
  String get lbOldP {
    return Intl.message('Old Password', name: 'lbOldP');
  }
  String get lbNewP {
    return Intl.message('New Password', name: 'lbNewP');
  }
  String get lbOldPW {
    return Intl.message(' *old password is wrong', name: 'lbOldPW');
  }

    String get lbLogM {
    return Intl.message('Are you confirm to log out ?', name: 'lbLogM');

  }



  String get lbSet {
    return Intl.message('Setting', name: 'lbSet');

  }
  String get lbShoList {
    return Intl.message('Shopping list', name: 'lbShoList');

  }
  String get lbAva {
    return Intl.message('Availble on store', name: 'lbAva');

  }
  String get lbNotAvaD {
    return Intl.message('This store cant contain drugs', name: 'lbNotAvaD');

  }
  String get lbNotAvaO {
    return Intl.message('This store cant contain offers', name: 'lbNotAvaO');

  }
  String get lbOwner {
    return Intl.message('The owner of this medicine', name: 'lbOwner');

  } String get lbRemi {
    return Intl.message('Remider daily at', name: 'lbRemi');

  }
  String get lbCreDate {
    return Intl.message('Create Date', name: 'lbCreDate');

  }
  String get lbBuyD {
    return Intl.message('Are you sure add another drugs from this warehouse with this order ?', name: 'lbBuyD');

  }
  String get lbyes {
    return Intl.message('Yes', name: 'lbyes');

  }

  String get lbno {
    return Intl.message('No', name: 'lbno');

  }

  String get lbOrederWare {
    return Intl.message('You have an order for another warehouse, please confirm it or cancel it from your basket to be able to order from the rest of the warehouse', name: 'lbOrederWare');

  }

  String get lbAdd {
    return Intl.message('Add', name: 'lbAdd');

  }
  String get lbSyriaD {
    return Intl.message('Syrian Drugs', name: 'lbSyriaD');

  }
  String get lbLoad {
    return Intl.message('Load', name: 'lbLoad');

  }
  String get lbError {
    return Intl.message('Error', name: 'lbError');

  }

  String get lbConfAdd {
    return Intl.message('This item has been added to your cart. To confirm your order, please go to shopping list in main activity', name: 'lbConfAdd');

  }

  String get lbEnterQ {
    return Intl.message('Please enter quantity', name: 'lbEnterQ');

  }

  String get lbMyOre {
    return Intl.message('Order', name: 'lbMyOre');

  }
  String get lbOffOr {
    return Intl.message('Offer & Order', name: 'lbOffOr');

  }

  String get lbStatus {
    return Intl.message('Status', name: 'lbStatus');

  }

  String get lbPending {
    return Intl.message('Pending', name: 'lbPending');

  }

  String get lbProcessing {
    return Intl.message('Processing', name: 'lbProcessing');

  }

  String get lbRej {
    return Intl.message('Rejected', name: 'lbRej');

  }

  String get lbWareI {
    return Intl.message('Warehouse info', name: 'lbWareI');

  }
  String get lbAddM {
    return Intl.message('Add Minimum order price', name: 'lbAddM');

  }

  String get lbOrders {
    return Intl.message('Details', name: 'lbOrders');

  }
  String get lbOffDru {
    return Intl.message('Offer for this drug ', name: 'lbOffDru');

  }

  String get lbEnterPhN {
    return Intl.message('Enter Pharmacy Name', name: 'lbEnterPhN');

  }
  String get lbNOData {
    return Intl.message('No data found', name: 'lbNOData');

  }

  String get lbDr {
    return Intl.message('Dr.', name: 'lbDr');

  }
  String get lbAlarm {
    return Intl.message('Alarms', name: 'lbAlarm');

  }
  String get lbNoAlarm {
    return Intl.message('No Alarms found', name: 'lbNoAlarm');

  }



//and add all the text you have inside the app that you need to make it in

//arabic and english launguages

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) {
    return false;
  }
}

class FallbackCupertinoLocalisationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalisationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      SynchronousFuture<_DefaultCupertinoLocalizations>(
          _DefaultCupertinoLocalizations(locale));

  @override
  bool shouldReload(FallbackCupertinoLocalisationsDelegate old) => false;
}

class _DefaultCupertinoLocalizations extends DefaultCupertinoLocalizations {
  final Locale locale;

  _DefaultCupertinoLocalizations(this.locale);
}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
