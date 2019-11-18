import 'package:flutter/material.dart';

import 'InheritedProvider.dart';


Type _typeOf<T>() => T;

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget{

  ChangeNotifierProvider({
    Key key,
    this.data,
    this.child,
  });

  final Widget child;
  final T data;

  static T of<T>(BuildContext context,{bool listen = true}){
    final type = _typeOf<InheritedProvider<T>>();
    final provide = listen
        ? context.inheritFromWidgetOfExactType(type) as InheritedProvider<T>
        : context.ancestorInheritedElementForWidgetOfExactType(type)?.widget
          as InheritedProvider<T>;
    return provide.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState<T>();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {

  void update(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.data.removeListener(update);
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    if(widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    widget.data.addListener(update);
  }


}