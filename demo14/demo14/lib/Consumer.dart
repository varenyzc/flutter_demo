import 'package:demo14/ChangeNotifierProvider.dart';
import 'package:flutter/material.dart';

class Consumer<T> extends StatelessWidget{
  Consumer({
    Key key,
    @required this.builder,
    this.child
  }):assert(builder!=null),super(key:key);

  final Widget child;
  final Widget Function(BuildContext context,T value) builder;

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of<T>(context)
    );
  }


}