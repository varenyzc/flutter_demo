import 'dart:math';

import 'package:flutter/material.dart';
import 'package:github_client_app/common/LocaleModel.dart';
import 'package:github_client_app/common/ThemeModel.dart';
import 'package:github_client_app/common/UserModel.dart';
import 'package:github_client_app/routes/HomeRoute.dart';
import 'package:github_client_app/routes/LoginRoute.dart';
import 'package:github_client_app/routes/ThemeChangeRoute.dart';
import 'package:provider/provider.dart';

import 'common/Global.dart';

void main() =>Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildCloneableWidget>[
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer2<ThemeModel,LocaleModel>(
        builder: (context,themeModel,localeModel,child){
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeModel.theme
            ),
            onGenerateTitle: (context){
              return "Github_flutter";
            },
            home: HomeRoute(),
            locale: localeModel.getLocale(),
            /*supportedLocales: [
              const Locale('en','US'),
              const Locale('zh',"CN")
            ],
            localeResolutionCallback:
              (Locale _locale,Iterable<Locale> supportedLocales){
              if(localeModel.getLocale()!=null){
                return localeModel.getLocale();
              }else{
                Locale locale;
                if(supportedLocales.contains(_locale)) {
                  locale = _locale;
                }else{
                  locale = Locale('en','US');
                }
                return locale;
              }
            },*/
            routes: <String,WidgetBuilder>{
              "login":(context)=>LoginRoute(),
              "themes":(context)=>ThemeChangeRoute(),
              //"language":(context)=>LanguageRoute()
            },
          );
        },
      ),
    );
  }
}