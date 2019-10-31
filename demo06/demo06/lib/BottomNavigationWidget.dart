import 'package:demo06/pages/EmailPages.dart';
import 'package:demo06/pages/HomePages.dart';
import 'package:demo06/pages/MePages.dart';
import 'package:demo06/pages/PagesPages.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  @override
  BottomNavigationWidgetState createState() => new BottomNavigationWidgetState();
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {

  int _currentIndex = 0;
  final _BottomNavigationColor = Colors.lightBlue;
  List<Widget> list = new List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: _BottomNavigationColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            title: Text(
              'Home',
            )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.email,
              ),
              title: Text(
                'Email',
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.pages,
              ),
              title: Text(
                'Pages',
              )
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Text(
                'Me',
              )
          ),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    list..add(HomePages())
        ..add(EmailPages())
        ..add(PagesPages())
        ..add(MePages());
    super.initState();
  }

}
