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
      home: ScaleTestRoute(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  PointerEvent _event;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListenerDemo'),
      ),
      body: Center(
        child: Listener(
          child: Container(
            alignment: Alignment.center,
            color:Colors.blue,
            width: 300,
            height: 150,
            child: Text(_event?.toString()??"",style: TextStyle(color: Colors.white),),
          ),
          onPointerDown: (event)=>setState(()=>_event=event),
          onPointerMove: (event)=>setState(()=>_event=event),
          onPointerUp: (event)=>setState(()=>_event=event),
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
  }

  @override
  void didUpdateWidget(MyHomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class GestureDetectorTestRoute extends StatefulWidget {
  @override
  GestureDetectorTestRouteState createState() => new GestureDetectorTestRouteState();
}

class GestureDetectorTestRouteState extends State<GestureDetectorTestRoute> {

  String _operation = "No Gesture detected!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GestureDetectorTestRoute'),
      ),
      body: Center(
        child: GestureDetector(
          child: Container(
            alignment: Alignment.center,
            color:Colors.blue,
            width: 200,
            height: 100,
            child: Text(_operation, style: TextStyle(color: Colors.white),),
          ),
          onTap: ()=>updateText("Tap"),
          onDoubleTap: ()=>updateText("DoubleTap"),
          onLongPress: ()=>updateText("LongPress"),
        ),
      ),
    );
  }

  void updateText(String text){
    setState(() {
      _operation = text;
    });
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
  void didUpdateWidget(GestureDetectorTestRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class DragTestRoute extends StatefulWidget {
  @override
  DragTestRouteState createState() => new DragTestRouteState();
}

class DragTestRouteState extends State<DragTestRoute> with SingleTickerProviderStateMixin {

  double _top = 0.0;
  double _left = 0.0;

  double _top2 = 1.0;

  double _left2 = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DragTestRoute'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: _top,
            left: _left,
            child: GestureDetector(
              child: CircleAvatar(
                child: Text("A"),
              ),
              onPanDown: (e)=>print("用户手指按下:${e.globalPosition}"),
              onPanUpdate: (e)=>setState((){
                _left += e.delta.dx;
                _top += e.delta.dy;
              }),
              onPanEnd: (e)=>print(e.velocity),
            ),
          ),
          Positioned(
            top: _top2,
            child: GestureDetector(
              child: CircleAvatar(child: Text("B"),),
              onVerticalDragUpdate: (e)=>setState((){
                _top2 += e.delta.dy;
              }),
            ),
          ),
          Positioned(
            left: _left2,
            child: GestureDetector(
              child: CircleAvatar(child: Text("C"),),
              onHorizontalDragUpdate: (e)=>setState((){
                _left2 += e.delta.dx;
              }),
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
  void didUpdateWidget(DragTestRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class ScaleTestRoute extends StatefulWidget {
  @override
  ScaleTestRouteState createState() => new ScaleTestRouteState();
}

class ScaleTestRouteState extends State<ScaleTestRoute> {

  double _width = 200.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScaleTestRoute'),
      ),
      body: Center(
        child: GestureDetector(
          child: Image.network("https://www.baidu.com/img/bd_logo1.png?where=super",width: _width,),
          onScaleUpdate: (e){
            setState(() {
              _width = 200*e.scale.clamp(.1, 100.0);
            });
          },
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
  }

  @override
  void didUpdateWidget(ScaleTestRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}