import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/UserModel.dart';
import 'package:provider/provider.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              Expanded(child: _buildMenus(),)
            ],
          )
      ),
    );
  }

  Widget _buildHeader(){
    return Consumer<UserModel>(
      builder: (context,value,child){
        return GestureDetector(
          child: Container(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: 40,bottom: 20),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: ClipOval(
                    child: value.isLogin
                      ? gmAvatar(value.user.avatar_url,width: 80)
                      : Image.asset(
                        "imgs/placehold.png",
                        width: 80,
                      ),
                  ),
                ),
                Text(
                  value.isLogin
                      ? value.user.login
                      : "请先登录账号",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          onTap: (){
            if(!value.isLogin) Navigator.of(context).pushNamed("login");
          },
        );
      },
    );
  }

  Widget gmAvatar(String url,{
    double width = 30,
    double height,
    BoxFit fit,
    BorderRadius borderRadius,
  }){
    var placeholder = Image.asset(
      "imgs/placehold.png",
      width: width,
      height: height,
    );
    return ClipRRect(
      borderRadius: borderRadius??BorderRadius.circular(2),
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        placeholder: (context,url)=>placeholder,
        errorWidget: (context,url,error)=>placeholder,
      ),
    );
  }

  Widget _buildMenus(){
    return Consumer<UserModel>(
      builder: (context,userModel,child){
        var children = <Widget>[
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text("换肤"),
            onTap: () => Navigator.pushNamed(context,"themes"),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text("语言"),
            onTap: () => Navigator.pushNamed(context, "language"),
          ),
        ];
        if(userModel.isLogin){
          children.add(ListTile(
            leading: Icon(Icons.power_settings_new),
            title: Text("注销"),
            onTap: (){
              showDialog(
                  context: context,
                  builder: (ctx){
                    return AlertDialog(
                      content:Text("确认要注销吗？"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("取消"),
                          onPressed: ()=>Navigator.pop(context),
                        ),
                        FlatButton(
                          child: Text("确定"),
                          onPressed: (){
                            userModel.user = null;
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  }
              );
            },));
        }
        return ListView(
          children: children
        );
      },
    );
  }
}