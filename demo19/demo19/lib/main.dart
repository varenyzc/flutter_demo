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
      home:AnimatedSwitcherCounterRoute()
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

class HeroAnimationRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HeroAnimationRoute'),
      ),
      body: Container(
          alignment: Alignment.topCenter,
          child: InkWell(
            child: Hero(
              tag:"avatar",
              child: ClipOval(
                child: Image.network("https://varenyzc.github.io/assets/img/avatar.webp",
                  width: 50.0,
                ),
              ),
            ),
            onTap: (){
              Navigator.push(context,PageRouteBuilder(
                pageBuilder: (context,animation,secondaryAnimation){
                  return FadeTransition(
                    opacity: animation,
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text("原图"),
                      ),
                      body: HeroAnimationRouteB(),
                    ),
                  );
                }
              ));
            },
          ),
        ),
    );
  }
}

class HeroAnimationRouteB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: "avatar",
        child: Image.network("https://varenyzc.github.io/assets/img/avatar.webp"),
      ),
    );
  }
}

class StaggerAnimation extends StatelessWidget{

  StaggerAnimation({Key key,this.controller}) : super(key:key){
    height = Tween<double>(
      begin: .0,
      end: 300.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,0.6,
          curve: Curves.ease,
        )
      )
    );

    color = ColorTween(
      begin: Colors.green,
      end: Colors.red,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,0.6,
          curve: Curves.ease,
        )
      )
    );

    padding = Tween<EdgeInsets>(
      begin: EdgeInsets.only(left: .0),
      end: EdgeInsets.only(left: 100.0)
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.6,1.0,
          curve: Curves.ease
        )
      )
    );
  }

  final Animation<double> controller;
  Animation<double> height;
  Animation<EdgeInsets> padding;
  Animation<Color> color;

  Widget _buildAnimation(BuildContext context,Widget child){
    return Container(
      alignment: Alignment.bottomCenter,
      padding: padding.value,
      child: Container(
        color: color.value,
        width: 50.0,
        height: height.value,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: controller,
    );
  }
}

class StaggerRoute extends StatefulWidget {
  @override
  StaggerRouteState createState() => new StaggerRouteState();
}

class StaggerRouteState extends State<StaggerRoute> with SingleTickerProviderStateMixin{

  AnimationController controller;

  Future<Null> _playAnimation() async{
    try{
      await controller.forward().orCancel;
      await controller.reverse().orCancel;
    }on TickerCanceled{

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('StaggerRoute'),
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          _playAnimation();
        },
        child: Center(
          child: Container(
            width: 300.0,
            height: 300.0,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              border: Border.all(
                color: Colors.black.withOpacity(0.5)
              )
            ),
            child: StaggerAnimation(
              controller: controller,
            ),
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(StaggerRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class AnimatedSwitcherCounterRoute extends StatefulWidget {
  @override
  AnimatedSwitcherCounterRouteState createState() => new AnimatedSwitcherCounterRouteState();
}

class AnimatedSwitcherCounterRouteState extends State<AnimatedSwitcherCounterRoute> {

  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AnimatedSwitcherCounterRoute'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              transitionBuilder: (child,animation){
                return ScaleTransition(child: child,scale: animation,);
              },
              child: Text(
                "$_count",
                //显示指定key，不同的key会被认为是不同的Text，这样才能执行动画
                key: ValueKey<int>(_count),
                style: Theme.of(context).textTheme.display1,
              ),
            ),
            RaisedButton(
              child: Text("+1"),
              onPressed: (){
                setState(() {
                  _count ++;
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
  void didUpdateWidget(AnimatedSwitcherCounterRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}