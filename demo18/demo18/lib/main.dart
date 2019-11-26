import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GestureConflictTestRoute()
    );
  }
}

class GestureRecognizerTestRoute extends StatefulWidget {
  @override
  GestureRecognizerTestRouteState createState() => new GestureRecognizerTestRouteState();
}

class GestureRecognizerTestRouteState extends State<GestureRecognizerTestRoute> {

  TapGestureRecognizer _tapGestureRecognizer = new TapGestureRecognizer();
  bool _toggle = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GestureRecognizerRoute'),
      ),
      body: Center(
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "你好世界"),
              TextSpan(
                text:"点我变色",
                style: TextStyle(
                  fontSize: 30.0,
                  color:_toggle?Colors.blue:Colors.redAccent
                ),
                recognizer: _tapGestureRecognizer
                  ..onTap = (){
                  setState(() {
                    _toggle = !_toggle;
                  });
                }
              ),
              TextSpan(text: "你好世界")
            ]
          )
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tapGestureRecognizer.dispose();
  }

  @override
  void didUpdateWidget(GestureRecognizerTestRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

//手势竞争
class BothDirectionTestRoute extends StatefulWidget {
  @override
  BothDirectionTestRouteState createState() => new BothDirectionTestRouteState();
}

class BothDirectionTestRouteState extends State<BothDirectionTestRoute> {

  double _top =0.0;
  double _left=0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BothDirectionRoute'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(child: Text('A'),),
              onVerticalDragUpdate: (e){
                setState(() {
                  _top+=e.delta.dy;
                });
              },
              onHorizontalDragUpdate: (e){
                setState(() {
                  _left+=e.delta.dx;
                });
              },
            ),
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(BothDirectionTestRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

//手势冲突
class GestureConflictTestRoute extends StatefulWidget {
  @override
  GestureConflictTestRouteState createState() => new GestureConflictTestRouteState();
}

class GestureConflictTestRouteState extends State<GestureConflictTestRoute> {

  double _left = 0.0;
  double _left2 = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GustureConflictRoute'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(child: Text("A"),),
              onHorizontalDragUpdate: (e){
                setState(() {
                  _left += e.delta.dx;
                });
              },
              onHorizontalDragEnd: (e){
                print("onHorizontalDragEnd");
              },
              onTapDown: (e){
                print("down");
              },
              onTapUp: (e){
                print("up");
              },
            ),
          ),
          Positioned(
            top: 80.0,
            left: _left2,
            child: Listener(
              onPointerUp: (e){
                print("up");
              },
              onPointerDown: (e){
                print("down");
              },
              child: GestureDetector(
                child: CircleAvatar(child: Text("B"),),
                onHorizontalDragUpdate: (e){
                  setState(() {
                    _left2 += e.delta.dx;
                  });
                },
                onHorizontalDragEnd: (e){
                  print("onHorizontalDragEnd");
                },
              ),
            ),
          )
        ],
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(GestureConflictTestRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}