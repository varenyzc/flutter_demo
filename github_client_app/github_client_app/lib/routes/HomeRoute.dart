import 'package:cached_network_image/cached_network_image.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/common/Git.dart';
import 'package:github_client_app/common/UserModel.dart';
import 'package:github_client_app/models/index.dart';
import 'package:github_client_app/widgets/MyDrawer.dart';
import 'package:github_client_app/widgets/RepoItem.dart';
import 'package:provider/provider.dart';

class HomeRoute extends StatefulWidget {
  @override
  HomeRouteState createState() => new HomeRouteState();
}

class HomeRouteState extends State<HomeRoute> {
  GlobalKey key = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Github App"),
      ),
      body: _buildBody(),
      drawer: MyDrawer(),
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
  void didUpdateWidget(HomeRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  Widget _buildBody(){
    UserModel userModel = Provider.of<UserModel>(context);
    if(!userModel.isLogin) {
      return Center(
        child: RaisedButton(
          child: Text("登录"),
          onPressed: () => Navigator.of(context).pushNamed("login"),
        ),
      );
    }else{
      return InfiniteListView<Repo>(
        onRetrieveData: (int page,List<Repo> items,bool refresh) async{
          var data = await Git(context).getRepos(
            refresh: refresh,
            queryParameters: {
              'page':page,
              'page_size':20,
            }
          );
          items.addAll(data);
          return data.length == 20;
        },
        itemBuilder: (List list,int index,BuildContext ctx){
          return RepoItem(list[index]);
        },
      );
    }

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
}