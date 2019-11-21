import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'DialogCheckbox.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  bool withThree = false;

  Future<bool> showDeleteConfirmDialog1(BuildContext context){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder:(context){
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗？"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: ()=>Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: ()=>Navigator.of(context).pop(true),
              )
            ],
          );
        }
    );
  }

  Future<bool> showDeleteConfirmDialog2(BuildContext context){
    withThree = false;
    return showDialog<bool>(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text("提示"),
          content:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("您确定要删除当前文件吗？"),
              Row(
                children: <Widget>[
                  Text("同时删除子目录?"),
                  Checkbox(
                    value: withThree,
                    onChanged: (value){
                      setState(() {
                        withThree = !withThree;
                      });
                    },
                  )
                ],
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(),
            ),
            FlatButton(
              child: Text("确定"),
              onPressed: () => Navigator.of(context).pop(withThree),
            )
          ],
        );
      }
    );
  }

  Future<bool> showDeleteConfirmDialog3(){
    bool _withThree = false;
    return showDialog<bool>(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("提示"),
            content:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您确定要删除当前文件吗？"),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录?"),
                    DialogCheckbox(
                      value: _withThree,
                      onChange: (value){
                          _withThree = !_withThree;
                      },
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () => Navigator.of(context).pop(_withThree),
              )
            ],
          );
        }
    );
  }

  Future<bool> showDeleteConfirmDialog4(){
    bool _withThree = false;
    return showDialog<bool>(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("提示"),
            content:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您确定要删除当前文件吗？"),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录?"),
                    StatefulBuilder(
                      builder: (context,_setState){
                        return Checkbox(
                          value: _withThree,
                          onChanged: (value){
                            _setState(() {
                              _withThree = !_withThree;
                            });
                          },
                        );
                      }
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () => Navigator.of(context).pop(_withThree),
              )
            ],
          );
        }
    );
  }

  Future<bool> showDeleteConfirmDialog5(){
    bool _withThree = false;
    return showDialog<bool>(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("提示"),
            content:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您确定要删除当前文件吗？"),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录?"),
                    Builder(
                        builder: (context){
                          return Checkbox(
                            value: _withThree,
                            onChanged: (value) {
                              (context as Element).markNeedsBuild();
                              _withThree = !_withThree;
                            }
                          );
                        }
                    )
                  ],
                )
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("确定"),
                onPressed: () => Navigator.of(context).pop(_withThree),
              )
            ],
          );
        }
    );
  }

  Future<void> changeLanguage(BuildContext context) async{
    int i = await showDialog<int>(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: Text("请选择语言"),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: (){
                  Navigator.pop(context,1);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text("中文简体"),
                ),
              ),
              SimpleDialogOption(
                onPressed: (){
                  Navigator.pop(context,2);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Text("美国英语"),
                ),
              )
            ],
          );
        }
    );
    if(i!=null) {
      print("选择了：${i==1 ?'中文简体':"美国英语"}");
    }
  }

  Future<void> showListDialog(BuildContext context) async{
    int index = await showDialog<int>(
        context: context,
        builder: (context){
          var child = Column(
            children: <Widget>[
              ListTile(title: Text("请选择"),),
              Expanded(
                child: ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context,index){
                      return ListTile(
                        title: Text("$index"),
                        onTap: () => Navigator.of(context).pop(index),
                      );
                    }
                ),
              )
            ],
          );
          //return AlertDialog(content:child); //不要尝试用AlertDialog，会报错
          //return Dialog(child: child,);
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280),
              child: Material(
                child: child,
                type: MaterialType.card,
              ),
            ),
          );
        }
    );
    if(index != null) {
      print("点击了 $index");
    }
  }

  Future<int> _showModalBottomSheet(){
    return showModalBottomSheet<int>(
      context: context,
      builder: (context){
        return ListView.builder(
            itemCount: 30,
            itemBuilder: (context,index){
              return ListTile(
                title: Text("$index"),
                onTap: ()=>Navigator.of(context).pop(index),
              );
            }
        );

      }
    );
  }

  void showLoadingDialog(){
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: EdgeInsets.only(top:26),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      }
    );
  }

  Future<DateTime> _showDatePicker1(){
    var date = DateTime.now();
    return showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date,
        lastDate: date.add(
          Duration(days: 30)
        )
    );
  }

  Future<DateTime> _showDatePicker2(){
    var date = DateTime.now();
    return showCupertinoModalPopup(
        context: context,
        builder: (ctx){
          return SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: date,
              maximumDate: date.add(
                Duration(days: 30)
              ),
              onDateTimeChanged: (value){
                print(value);
              },
            ),
          );
        }
    );
  }

  PersistentBottomSheetController<int> _showBottomSheet(){
    return showBottomSheet<int>(
      context: context,
      builder: (context){
        return ListView.builder(
            itemCount: 30,
            itemBuilder: (context,index){
              return ListTile(
                title: Text("$index"),
                onTap: (){
                  print("$index");
                  Navigator.of(context).pop();
                },
              );
            }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('对话框Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("删除确认框"),
              onPressed: () async{
                bool delete = await showDeleteConfirmDialog1(context);
                if(delete == null) {
                  print("取消");
                }else{
                  print("确定");
                }
              },
            ),
            RaisedButton(
              child: Text("选择对话框"),
              onPressed: (){
                changeLanguage(context);
              },
            ),
            RaisedButton(
              child: Text("列表对话框"),
              onPressed: (){
                showListDialog(context);
              },
            ),
            RaisedButton(
                child: Text("带动画删除确认框"),
                onPressed: (){
                  showCustomDialog<bool>(context: context,
                      builder: (context){
                        return AlertDialog(title: Text("提示"),
                          content:Text("确定删除当前文件吗?"),
                          actions: <Widget>[
                            FlatButton(
                              child: Text("取消"),
                              onPressed: () {
                                Navigator.of(context).pop();
                                print("取消");
                              },
                            ),
                            FlatButton(
                              child: Text("删除"),
                              onPressed: () {
                                // 执行删除操作
                                Navigator.of(context).pop(true);
                                print("删除");
                              },
                            ),
                          ],
                        );
                      });
                }
            ),
            RaisedButton(
              //checkbox勾选不了
              child: Text("checkbox勾选不了"),
              onPressed: () async{
                bool delete = await showDeleteConfirmDialog2(context);
                if(delete == null) {
                  print("取消");
                }else{
                  print("同时删除目录：$delete");
                }
              },
            ),
            RaisedButton(
              //checkbox能勾选方案一：单独抽离出StatefulWidget
              child: Text("checkbox能勾选方案一"),
              onPressed: () async{
                bool delete = await showDeleteConfirmDialog3();
                if(delete == null) {
                  print("取消");
                }else{
                  print("同时删除目录：$delete");
                }
              },
            ),
            RaisedButton(
              //checkbox能勾选方案二：使用StatefulBuilder方法
              child: Text("checkbox能勾选方案二"),
              onPressed: () async{
                bool delete = await showDeleteConfirmDialog4();
                if(delete == null) {
                  print("取消");
                }else{
                  print("同时删除目录：$delete");
                }
              },
            ),
            RaisedButton(
              //checkbox能勾选方案三：把checkbox的context调用markNeedsBuilder方法
              child: Text("checkbox能勾选方案三"),
              onPressed: () async{
                bool delete = await showDeleteConfirmDialog5();
                if(delete == null) {
                  print("取消");
                }else{
                  print("同时删除目录：$delete");
                }
              },
            ),
            RaisedButton(
              child: Text("底部对话框"),
              onPressed: () async{
                int type = await _showModalBottomSheet();
                print(type);
              },
            ),
            RaisedButton(
              child: Text("加载对话框"),
              onPressed: (){
                showLoadingDialog();
              },
            ),
            RaisedButton(
              child: Text("Material风格日历选择"),
              onPressed: () async{
                var date = await _showDatePicker1();
                print(date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString());
              },
            ),
            RaisedButton(
              child: Text("iOS风格日历选择"),
              onPressed: (){
                _showDatePicker2();
              },
            )
          ],
        ),
      ),
    );
  }
}


Future<T> showCustomDialog<T>({
  @required BuildContext context,
  bool barrierDismissible = true,
  WidgetBuilder builder,
}){
  final ThemeData theme = Theme.of(context,shadowThemeOnly: true);
  return showGeneralDialog(context: context,
      pageBuilder:(BuildContext builderContext,Animation<double> animation,
        Animation<double> secondaryAnimation){
          final Widget pageChild = Builder(builder: builder);
          return SafeArea(
            child: Builder(builder: (BuildContext context){
              return theme != null ?Theme(data: theme,child: pageChild,):pageChild;
            },),
          );
      },
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black87,
    transitionDuration: Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions
  );
}

Widget _buildMaterialDialogTransitions(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child
){
  return ScaleTransition(
    scale: CurvedAnimation(
      parent: animation,
      curve: Curves.fastOutSlowIn
    ),
    child: child,
  );
}