import 'package:flutter/material.dart';

class Setting {
  String appName = '';
  String mainColor;
  String mainDarkColor;
  String secondColor;
  String secondDarkColor;
  String accentColor;
  String accentDarkColor;
  String scaffoldDarkColor;
  String scaffoldColor;
  String googleMapsKey;
  String fcmKey;
  Locale mobileLanguage = const Locale('en', '');
  String appVersion;
  Brightness brightness = Brightness.dark;

  factory Setting.init() {
    return Setting(
        appName: "The Cloud",
        mainColor: "000",
        mainDarkColor: "000",
        secondColor: "000",
        secondDarkColor: "000",
        accentColor: "000",
        accentDarkColor: "000",
        scaffoldDarkColor: "000",
        scaffoldColor: "000",
        googleMapsKey: "000",
        fcmKey: "",
        mobileLanguage: const Locale('en'),
        appVersion: "1.0.0",
        );
  }

  Setting({
    required this.appName,
    required this.mainColor,
    required this.mainDarkColor,
    required this.secondColor,
    required this.secondDarkColor,
    required this.accentColor,
    required this.accentDarkColor,
    required this.scaffoldDarkColor,
    required this.scaffoldColor,
    required this.googleMapsKey,
    required this.fcmKey,
    required this.mobileLanguage,
    required this.appVersion,
  });

}