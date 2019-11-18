import 'package:demo14/CartModel.dart';
import 'package:demo14/ChangeNotifierProvider.dart';
import 'package:demo14/Consumer.dart';
import 'package:flutter/material.dart';

import 'Item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProviderRoute()
    );
  }
}


class ProviderRoute extends StatefulWidget {
  @override
  ProviderRouteState createState() => new ProviderRouteState();
}

class ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProviderTest'),
      ),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(builder: (context){
            return Column(
              children: <Widget>[
                Builder(builder: (context){
                  var cart = ChangeNotifierProvider.of<CartModel>(context);
                  return Text("总价：${cart.totalPrice}");
                },),
                Consumer<CartModel>(
                  builder: (context,cart)=>Text("Consumer总价:${cart.totalPrice}"),
                ),
                Builder(builder: (context){
                  print("RaisedButton build"); //在后面优化部分会用到
                  return RaisedButton(
                    child: Text("添加商品"),
                    onPressed: () {
                  //给购物车中添加商品，添加后总价会更新
                      ChangeNotifierProvider.of<CartModel>(context,listen: false).add(Item(20.0, 1));
                    },
                  );
                },),
                Builder(builder: (context){
                  print("RaisedButton build");
                  return RaisedButton(
                    child: Text("删除商品"),
                    onPressed: (){
                      ChangeNotifierProvider.of<CartModel>(context).remove();
                    },
                  );
                },),
              ],
            );
          },
        ),
      ),
    ));
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
  void didUpdateWidget(ProviderRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}