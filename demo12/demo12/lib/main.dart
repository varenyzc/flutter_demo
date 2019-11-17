import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text('Demo')
      ),
      body: Center(
        child: Column(
         children: <Widget>[
           RaisedButton(
             child: Text('toNext'),
             onPressed: (){
               Navigator.of(context).push(
                   MaterialPageRoute(
                       builder: (BuildContext context){
                         return CustomScrollViewTestRoute();
                       }
                   )
               );
             },
           ),
           RaisedButton(
             child: Text('ScrollBarTest'),
             onPressed: () {
               Navigator.of(context).push(
                 MaterialPageRoute(
                   builder: (BuildContext context){
                     return ScrollControlerTestRoute();
                   }
                 )
               );
             }
           ),
           RaisedButton(
             child: Text('ScrollNotificationTest'),
             onPressed: (){
               Navigator.of(context).push(
                 MaterialPageRoute(
                   builder: (BuildContext context){
                     return ScrollNotificationTestRoute();
                   }
                 )
               );
             },
           )
         ],
        )
      ),
    );
  }
}

class CustomScrollViewTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Demo'),
              background: Image.asset(
                "assets/assert.png",fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0
              ),
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context,int index){
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.cyan[100 * (index % 9)],
                      child: Text('grid item $index'),
                    );
                  },
                childCount: 20,
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: SliverChildBuilderDelegate(
                (BuildContext context,int index){
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.lightBlue[100 * (index%9)],
                    child: Text('list item $index'),
                  );
                },
              childCount: 50
            ),
          )
        ],
      ),
    );
  }
}

class ScrollControlerTestRoute extends StatefulWidget {
  @override
  ScrollControlerTestRouteState createState() => new ScrollControlerTestRouteState();
}

class ScrollControlerTestRouteState extends State<ScrollControlerTestRoute> {

  ScrollController _controller = new ScrollController();
  bool showToTopBtn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('滑动控制demo'),
      ),
      body: Scrollbar(
        child: ListView.builder(
            itemBuilder: (context,index){
              return ListTile(title: Text("$index"),);
            },
            itemExtent: 50.0,
            itemCount: 100,
            controller: _controller,
        ),
      ),
      floatingActionButton: !showToTopBtn?null:FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: (){
          _controller.animateTo(
              .0,
              duration: Duration(milliseconds: 200),
              curve: Curves.ease
          );
        },
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener((){
      print(_controller.offset);
      if(_controller.offset<1000 && showToTopBtn) {
        setState(() {
          showToTopBtn = false;
        });
      }else if(_controller.offset>=1000 && showToTopBtn==false){
        setState(() {
          showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(ScrollControlerTestRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

class ScrollNotificationTestRoute extends StatefulWidget {
  @override
  ScrollNotificationTestRouteState createState() => new ScrollNotificationTestRouteState();
}

class ScrollNotificationTestRouteState extends State<ScrollNotificationTestRoute> {

  String _progress = "0%";
  DateTime _lastPressedAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotificationTest'),
        leading: WillPopScope(
          onWillPop: () async{
            if(_lastPressedAt == null || DateTime.now().difference(_lastPressedAt)>Duration(seconds: 1)) {
              _lastPressedAt = DateTime.now();
              return false;
            }
            return true;
          },
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: (){
              if(_lastPressedAt == null || DateTime.now().difference(_lastPressedAt)>Duration(seconds: 2)) {
                _lastPressedAt = DateTime.now();
                return;
              }//2秒内连续按leading退出
              //return true;
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: Scrollbar(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification notification){
            double progress = notification.metrics.pixels /
                notification.metrics.maxScrollExtent;
            setState(() {
              _progress = "${(progress*100).toInt()}%";
            });
            print("BottomEdge: ${notification.metrics.extentAfter == 0}");
            return true;
          },
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              ListView.builder(
                  itemBuilder: (context,index){
                    return ListTile(title: Text('$index'));
                  },
                  itemCount: 100,
                  itemExtent: 50.0,
              ),
              CircleAvatar(
                radius: 30.0,
                child: Text(_progress),
                backgroundColor: Colors.black54,
              )
            ],
          ),
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
  void didUpdateWidget(ScrollNotificationTestRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}