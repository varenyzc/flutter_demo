import 'package:flutter/material.dart';

class ShareDataWidget extends InheritedWidget{
  ShareDataWidget({
    @required this.data,
    Widget child
  }):super(child:child);

  final int data;

  static ShareDataWidget of(BuildContext context){
    //return context.inheritFromWidgetOfExactType(ShareDataWidget);
    return context.ancestorInheritedElementForWidgetOfExactType(ShareDataWidget).widget;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return oldWidget!=data;
  }

}
