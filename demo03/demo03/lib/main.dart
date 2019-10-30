import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    title:"导航demo",
    home: new FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("导航页面"),),
      body: Center(
        child: RaisedButton(
          child: Text("下一页"),
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(
              builder: (context)=>new SecondScreen()
            ));
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second"),),
      body: Center(
        child: RaisedButton(
          child: Text("back"),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
