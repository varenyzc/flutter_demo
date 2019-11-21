import 'package:flutter/material.dart';

class StatefulBuilder extends StatefulWidget {

  const StatefulBuilder({
    Key key,
    @required this.builder,
  }):assert(builder!=null),super(key:key);

  final StatefulWidgetBuilder builder;

  @override
  _StatefulBuilderState createState() => new _StatefulBuilderState();
}

class _StatefulBuilderState extends State<StatefulBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context,setState);
  }
}
