import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ParentWidgetC(),
    );
  }
}
//widget管理自身状态
class TapboxA extends StatefulWidget {
  @override
  TapboxAState createState() => new TapboxAState();
}

class TapboxAState extends State<TapboxA> {

  bool _active = false;

  void _handleTap(){
    setState(() {
      _active = !_active;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _handleTap,
          child: Container(
            child: Center(
              child: Text(
                _active?'Activiy':'Inactive',
                style: TextStyle(fontSize: 32.0,color:Colors.white),
              ),
            ),
            width: 200.0,
            height: 200.0,
            decoration: BoxDecoration(
              color: _active?Colors.lightGreen:Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

//父Widget管理子Widget状态
class ParentWidget extends StatefulWidget {
  @override
  ParentWidgetState createState() => new ParentWidgetState();
}

class ParentWidgetState extends State<ParentWidget> {

  bool _active = false;

  void _handleTapboxChanged(bool newValue){
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: Container(
          child: TapboxB(
            active: _active,
            onChanged: _handleTapboxChanged,
          ),
        ),
      ),
    );
  }

}

class TapboxB extends StatelessWidget {

  TapboxB({Key key,this.active:false,@required this.onChanged}):super(key:key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap(){
    onChanged(!active);
  }
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//混合状态管理
class ParentWidgetC extends StatefulWidget {
  @override
  ParentWidgetCState createState() => new ParentWidgetCState();
}

class ParentWidgetCState extends State<ParentWidgetC> {

  bool _active = false;

  void _handleTapboxChanged(bool newValue){
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo'),
      ),
      body: Center(
        child: Container(
          child: TapboxC(
            active:_active,
            onChanged: _handleTapboxChanged,
          ),
        ),
      ),
    );
  }
}

class TapboxC extends StatefulWidget {

  TapboxC({Key key,this.active:false,@required this.onChanged}):super(key:key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  TapboxCState createState() => new TapboxCState();
}

class TapboxCState extends State<TapboxC> {

  bool _highlight = false;

  void _handleTapDown(TapDownDetails details){
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details){
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel(){
    setState(() {
      _highlight =false;
    });
  }

  void _handleTap(){
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: Container(
        child: Center(
          child: Text(
            widget.active ? 'Active' :'Inactive',
            style: TextStyle(fontSize: 32.0,color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: widget.active?Colors.lightGreen:Colors.grey,
          border:_highlight?Border.all(color: Colors.teal,width: 10.0):null
        ),
      ),
    );
  }
}
