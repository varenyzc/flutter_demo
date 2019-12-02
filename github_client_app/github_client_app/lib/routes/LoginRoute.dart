import 'package:fluttertoast/fluttertoast.dart';
import 'package:github_client_app/common/Git.dart';
import 'package:github_client_app/common/Global.dart';
import 'package:github_client_app/common/UserModel.dart';
import 'package:provider/provider.dart';

import '../models/index.dart';
import 'package:flutter/material.dart';

class LoginRoute extends StatefulWidget {
  @override
  LoginRouteState createState() => new LoginRouteState();
}

class LoginRouteState extends State<LoginRoute> {

  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false; //是否显示明文
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('登录'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              TextFormField(
                autofocus: _nameAutoFocus,
                controller: _unameController,
                decoration: InputDecoration(
                  labelText: "登录名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person)
                ),
                validator: (v){
                  return v.trim().isNotEmpty ? null : "需要填入登录名";
                },
              ),
              TextFormField(
                autofocus: !_nameAutoFocus,
                controller: _pwdController,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "在此输入密码",
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      pwdShow ? Icons.visibility_off : Icons.visibility
                    ),
                    onPressed: (){
                      setState(() {
                        pwdShow = !pwdShow;
                      });
                    },
                  ),
                ),
                obscureText: !pwdShow,
                validator: (v){
                  return v.trim().isNotEmpty ? null : "密码不能为空";
                },
              ),
              Padding(
                padding: EdgeInsets.only(top:25),
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 55),
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: _onLogin,
                    textColor: Colors.white,
                    child: Text("登录"),
                  ),
                ),
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
    _unameController.text = Global.profile.lastLogin;
    if(_unameController.text!=null) {
      _nameAutoFocus = false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _unameController.dispose();
    _pwdController.dispose();
  }

  @override
  void didUpdateWidget(LoginRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _onLogin() async{
    if((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      User user;
      try{
        print("1");
        user = await Git(context).login(_unameController.text, _pwdController.text);
        Provider.of<UserModel>(context,listen: false).user = user;

      }catch(e){
        if(e.response?.statusCode == 401){
          Fluttertoast.showToast(
            msg:"账号或密码错误",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM
          );
        }else{
          Fluttertoast.showToast(
              msg:e.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM
          );
        }
        print(e.toString());
      }finally{
        Navigator.of(context).pop();
      }
      if(user!=null){
        Navigator.of(context).pop();
      }
    }
  }
  showLoading(BuildContext context) {
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
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在加载，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }
}
