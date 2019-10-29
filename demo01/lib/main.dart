import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MyApp());
  if(Platform.isAndroid) {
    var style = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  List<String> _abs = ['A','B','C'];
  TabController _tabController;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _abs.length,vsync: this);
    _pageController = PageController(initialPage: 0);
    _tabController.addListener((){
      if(_tabController.indexIsChanging) {
        _pageController.animateToPage(_tabController.index, duration: Duration(milliseconds: 300), curve: Curves.decelerate);
      }
    });
  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (val)=>print('Selected item $val'),
            icon: Icon(Icons.more_vert),
            itemBuilder: (context)=>List.generate(_abs.length, (index)=>PopupMenuItem(value: _abs[index],child: Text(_abs[index]),)),
          )
        ],
        bottom: TabBar(
            labelColor: Colors.red,
            unselectedLabelColor: Colors.white,
            controller: _tabController,
            isScrollable: false,
            indicatorColor: Colors.yellow,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 5.0,
            tabs:List.generate(_abs.length, (index)=>Tab(text:_abs[index],icon: Icon(Icons.android),))
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            child: Text('Drawer',style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 30.0),),
          ),
        ),
      ),
      body:PageView(
        controller: _pageController,
        children: _abs.map((str)=> TabChangePage(content: str,)).toList(),
        onPageChanged: (position){
          _tabController.index = position;
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.android,size: 30.0,color: Theme.of(context).primaryColor,),
              onPressed: (){},
            ),
            IconButton(
              icon: Icon(Icons.phone_iphone,size: 30.0,color: Theme.of(context).primaryColor,),
              onPressed: (){},
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()=>print('Add'),
        child: Icon(Icons.add,color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class TabChangePage extends StatelessWidget{

  final String content;

  TabChangePage({Key key,this.content}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Container(
        alignment: Alignment.center,
        child: Text(
          content,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 30.0
          ),
        ),
      )
    );
  }
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Demo",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
