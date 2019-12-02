import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/common/ProfileChangeNotifier.dart';

class ThemeModel extends ProfileChangeNotifier{

  ColorSwatch get theme => Global.themes
      .firstWhere((e)=>e.value==profile.theme,orElse: ()=> Colors.blue);

  set theme(ColorSwatch color){
    if(color!=theme) {
      profile.theme = color[500].value;
      notifyListeners();
    }
  }
}