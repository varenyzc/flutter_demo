import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:github_client_app/models/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'CacheObject.dart';
import 'Git.dart';

const _theme = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.pink,
  Colors.purple,
  Colors.indigo,
  Colors.lime,
];


class Global{
  static SharedPreferences _prefs;
  static Profile profile = Profile();

  static NetCache netCache = NetCache();

  static List<MaterialColor> get themes => _theme;

  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  static Future init() async{
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if(_profile!=null) {
      try{
        profile = Profile.fromJson(jsonDecode(_profile));
      }catch(e) {
        print(e);
      }
    }

    profile.cache = profile.cache??CacheConfig()
      ..enable = true
      ..maxAge = 3600
      ..maxCount = 100;

    Git.init();
  }

  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}