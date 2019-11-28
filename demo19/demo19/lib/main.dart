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
      home:ScaleAnimationRoute3()
    );
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  @override
  ScaleAnimationRouteState createState() => new ScaleAnimationRouteState();
}

class ScaleAnimationRouteState extends State<ScaleAnimationRoute> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScaleAnimationRoute'),
      ),
      body: Center(
        child: GestureDetector(
          child: Image.network("https://www.baidu.com/img/bd_logo1.png?where=super",
            width: animation.value,
            height: animation.value,
          ),
          onTap: (){

          },
        )
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(duration: Duration(seconds: 3),vsync: this);
    animation = CurvedAnimation(parent: controller,curve: Curves.bounceInOut);
    animation = new Tween(begin: 0.0,end: 300.0).animate(animation)
          ..addListener((){
            setState(() {
            });
          });
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  void didUpdateWidget(ScaleAnimationRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class AnimatedImage extends AnimatedWidget{

  AnimatedImage({Key key,Animation<double> animation})
    :super(key:key,listenable:animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Image.network("https://www.baidu.com/img/bd_logo1.png?where=super",
          width: animation.value,
          height: animation.value,
      ),
    );
  }
}

class ScaleAnimationRoute1 extends StatefulWidget {
  @override
  ScaleAnimationRoute1State createState() => new ScaleAnimationRoute1State();
}

class ScaleAnimationRoute1State extends State<ScaleAnimationRoute1> with SingleTickerProviderStateMixin{

  Animation<double> animation;
  AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScaleAnimationRoute1'),
      ),
      body: //AnimatedImage(animation: animation,),
            AnimatedBuilder(
              animation: animation,
              child: Image.network("https://www.baidu.com/img/bd_logo1.png?where=super",),
              builder: (context,child){
                return Center(
                  child: Container(
                    height: animation.value,
                    width: animation.value,
                    child: child,
                  ),
                );
              },
            )
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(vsync: this,duration: Duration(seconds: 3));
    animation = new Tween(begin: 0.0,end: 300.0).animate(controller);
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ScaleAnimationRoute1 oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class GrowTransition extends StatelessWidget{

  GrowTransition({this.child,this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context,child){
          return Container(
            width: animation.value,
            height: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
  }
}

class ScaleAnimationRoute2 extends StatefulWidget {
  @override
  ScaleAnimationRoute2State createState() => new ScaleAnimationRoute2State();
}

class ScaleAnimationRoute2State extends State<ScaleAnimationRoute2> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScaleAnimationRoute'),
      ),
      body: Center(
         child: GrowTransition(
           child: Image.network("https://www.baidu.com/img/bd_logo1.png?where=super"),
           animation: animation,
         ),
        )
      );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(duration: Duration(seconds: 3),vsync: this);
    animation = CurvedAnimation(parent: controller,curve: Curves.bounceInOut);
    animation = new Tween(begin: 0.0,end: 300.0).animate(animation)
      ..addListener((){
        setState(() {
        });
      });
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class ScaleAnimationRoute3 extends StatefulWidget {
  @override
  ScaleAnimationRoute3State createState() => new ScaleAnimationRoute3State();
}

class ScaleAnimationRoute3State extends State<ScaleAnimationRoute3> with SingleTickerProviderStateMixin{

  AnimationController controller;
  Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScaleAnimationRoute3'),
      ),
      body:  Center(
          child: GrowTransition(
          child: Image.network("https://www.baidu.com/img/bd_logo1.png?where=super"),
          animation: animation,
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),vsync: this
    );
    animation = Tween(begin: 0.0,end: 300.0).animate(controller);
    animation.addStatusListener((status){
      if(status==AnimationStatus.completed) {
        controller.reverse();
      }else if(status == AnimationStatus.dismissed){
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(ScaleAnimationRoute3 oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}