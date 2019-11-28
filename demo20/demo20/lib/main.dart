import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:CustomPaintRoute()
    );
  }
}

class TurnBox extends StatefulWidget {

  TurnBox({
    Key key,
    this.turns = .0,
    this.speed = 200,
    this.child
  }):super(key:key);

  final double turns;
  final int speed;
  final Widget child;

  @override
  TurnBoxState createState() => new TurnBoxState();
}

class TurnBoxState extends State<TurnBox> with SingleTickerProviderStateMixin{

  AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: widget.child,
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new AnimationController(vsync: this,
      lowerBound: -double.infinity,
      upperBound: double.infinity
    );
    _controller.value = widget.turns;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(TurnBox oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(oldWidget.turns != widget.turns) {
      _controller.animateTo(
        widget.turns,
        duration: Duration(milliseconds: widget.speed??200),
        curve: Curves.easeOut
      );
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class TurnBoxRoute extends StatefulWidget {
  @override
  TurnBoxRouteState createState() => new TurnBoxRouteState();
}

class TurnBoxRouteState extends State<TurnBoxRoute> {

  double _turns = .0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TurnBoxRoute'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TurnBox(
              turns: _turns,
              speed: 500,
              child: Icon(Icons.refresh,size: 50,),
            ),
            TurnBox(
              turns: _turns,
              speed: 1000,
              child: Icon(Icons.refresh,size: 150,),
            ),
            RaisedButton(
              child: Text("顺时针旋转1/5圈"),
              onPressed: (){
                setState(() {
                  _turns+=.2;
                });
              },
            ),
            RaisedButton(
              child: Text("逆时针旋转1/5圈"),
              onPressed: (){
                setState(() {
                  _turns-=.2;
                });
              },
            )
          ],
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
  void didUpdateWidget(TurnBoxRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class MyRichText extends StatefulWidget {

  MyRichText({
    Key key,
    this.text,
    this.linkStyle,
  }):super(key:key);

  final String text;
  final TextStyle linkStyle;

  @override
  MyRichTextState createState() => new MyRichTextState();
}

class MyRichTextState extends State<MyRichText> {

  TextSpan _textSpan;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: _textSpan,
    );
  }

  TextSpan parseText(String text){
    //耗时操作：解析文本字符串，构建出TextSpan
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textSpan = parseText(widget.text);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(MyRichText oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if(widget.text!=oldWidget.text) {
      _textSpan = parseText(widget.text);
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class CustomPaintRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomPaint'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(300,300),
          painter: MyPainter(),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width / 15;
    double eHeight = size.height / 15;

    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);
    canvas.drawRect(Offset.zero&size, paint);

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    for(int i =0;i<=15;i++){
      double dy = eHeight *i ;
      canvas.drawLine(Offset(0,dy), Offset(size.width,dy), paint);
    }

    for(int i=0;i<=15;i++){
      double dx = eWidth *i;
      canvas.drawLine(Offset(dx,0), Offset(dx,size.height), paint);
    }

    paint
      ..style =  PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(Offset(size.width/2-eWidth/2,size.height/2-eHeight/2),
        min(eWidth/2,eHeight/2)-2, paint);

    paint.color = Colors.white;
    canvas.drawCircle(Offset(size.width/2+eWidth/2,size.height/2-eHeight/2),
        min(eWidth/2,eHeight/2)-2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

}
