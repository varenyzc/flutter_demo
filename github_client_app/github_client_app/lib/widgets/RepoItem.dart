import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:github_client_app/models/index.dart';
import 'package:github_client_app/widgets/MyIcons.dart';

class RepoItem extends StatefulWidget {

  RepoItem(this.repo):super(key:ValueKey(repo.id));

  final Repo repo;
  @override
  RepoItemState createState() => new RepoItemState();
}

class RepoItemState extends State<RepoItem> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Material(
        color: Colors.white,
        shape: BorderDirectional(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: .5,
          )
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 0.0,bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(
                dense: true,
                leading: gmAvatar(
                  widget.repo.owner.avatar_url,
                  width: 25.0,
                  borderRadius: BorderRadius.circular(12)
                ),
                title: Text(
                  widget.repo.owner.login,
                  textScaleFactor: .9,
                ),
                trailing: Text(widget.repo.language??""),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        (widget.repo.fork
                          ? widget.repo.full_name
                          : widget.repo.name),
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontStyle: widget.repo.fork
                          ? FontStyle.italic : FontStyle.normal,
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8,bottom: 12),
                      child: widget.repo.description == null
                        ? Text(
                        "没有描述",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700]
                        ),
                      ):Text(
                        widget.repo.description,
                        maxLines: 3,
                        style: TextStyle(
                          height: 1.15,
                          color: Colors.blueGrey[700],
                          fontSize: 13
                        ),
                      ),
                    )
                  ],
                ),
              ),
              _buildBottom()
            ],
          ),
        ),
      ),
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

  Widget _buildBottom(){
    const paddingWidth = 10;
    return IconTheme(
      data: IconThemeData(
        color: Colors.grey,
        size: 15
      ),
      child: DefaultTextStyle(
        style: TextStyle(color:Colors.grey,fontSize: 12),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Builder(builder: (context){
            var children = <Widget>[
              Icon(Icons.star),
              Text(" "+widget.repo.stargazers_count.toString().padRight(paddingWidth)),
              Icon(Icons.info_outline),
              Text(" "+widget.repo.open_issues_count.toString().padRight(paddingWidth)),
              Icon(MyIcons.fork),
              Text(" "+widget.repo.forks_count.toString().padRight(paddingWidth)),
              Icon(Icons.access_time),
              Text(" "+widget.repo.updated_at.split("T")[0].toString().padRight(paddingWidth))
            ];

            if(widget.repo.fork){
              children.add(Text(" Forked".padRight(paddingWidth)));
            }
            if(widget.repo.private == true) {
              children.addAll(<Widget>[
                Icon(Icons.lock),
                Text(" private".padRight(paddingWidth))
              ]);
            }
            return Row(children: children,);
          },),
        ),
      ),
    );
  }
}

