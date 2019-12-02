import 'package:flutter/material.dart';
import 'package:github_client_app/common/ProfileChangeNotifier.dart';

class LocaleModel extends ProfileChangeNotifier{
  Locale getLocale(){
    if(profile.locale == null) return null;
    var t = profile.locale.split("_");
    return Locale(t[0],t[1]);
  }

  String get locale => profile.locale;

  set locale(String locale){
    if(locale!=profile.locale) {
      profile.locale = locale;
      notifyListeners();
    }
  }
}