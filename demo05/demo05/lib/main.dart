import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '页面跳转返回数据',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirstPage()
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('demo'),
      ),
      body: Center(
        child: RouteButton(),
      ),
    );
  }
}

class RouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){_navigateToNext(context);},
      child: Text("go"),
    );
  }

  _navigateToNext(BuildContext context) async{
    final result = await Navigator.push(context,MaterialPageRoute(
      builder: (context)=>SecondScreen()
    ));

    Scaffold.of(context).showSnackBar(SnackBar(content: Text('$result'),));

  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("1"),
              onPressed: (){Navigator.pop(context,'1');},
            ),
            RaisedButton(
              child: Text("2"),
              onPressed: (){Navigator.pop(context,'2');},
            ),
          ],
        ),
      ),
    );
  }
}