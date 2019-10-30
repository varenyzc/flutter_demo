import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    var stack = Stack(
      //alignment: new FractionalOffset(0.5, 0.8),//仅用Stack布局的时候，用于两个child的位置控制，方法里的数为0~1之间
      children: <Widget>[
        CircleAvatar(
          backgroundImage:  new NetworkImage("https://upload.jianshu.io/users/upload_avatars/13517457/c3fdec57-8982-4b4e-8ffd-3b6dafab4a10.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240"),
          radius: 100.0,
        ),
        //Positioned布局更加方便，可用top、bottom、left、right控制组件的位置
        Positioned(
          top: 10.0,
          left: 10.0,
          child:Container(
            decoration: new BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(8.0)
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
                "varenyzc"
            ),
          ) ,
        ),
        Positioned(
          bottom: 10.0,
          right: 10.0,
          child:Container(
            decoration: new BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(8.0)
            ),
            padding: EdgeInsets.all(10.0),
            child: Text(
                "dgut"
            ),
          ) ,
        ),
      ],
    );

    var card = new Card(
      child: new Column(
        children: <Widget>[
          ListTile(
            title: Text("varenyzc",style: TextStyle(fontWeight: FontWeight.w500),),
            subtitle: Text("dgut2019"),
            leading: Icon(Icons.account_box,color: Theme.of(context).primaryColor,),
            onTap: (){},
          ),
          Divider(),
          ListTile(
            title: Text("varenyzc",style: TextStyle(fontWeight: FontWeight.w500),),
            subtitle: Text("dgut2019"),
            leading: Icon(Icons.account_box,color: Theme.of(context).primaryColor,),
            onTap: (){},
          ),
          Divider(),
          ListTile(
            title: Text("varenyzc",style: TextStyle(fontWeight: FontWeight.w500),),
            subtitle: Text("dgut2019"),
            leading: Icon(Icons.account_box,color: Theme.of(context).primaryColor,),
            onTap: (){},
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: card
      ),
    );
  }
}
