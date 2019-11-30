import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/io.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:WebSocketRoute()
    );
  }
}

//文件操作
class FileOperationRoute extends StatefulWidget {

  FileOperationRoute({Key key}):super(key:key);

  @override
  FileOperationRouteState createState() => new FileOperationRouteState();
}

class FileOperationRouteState extends State<FileOperationRoute> {

  int _counter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FileOperationRoute'),
      ),
      body: Center(
        child: Text("点击了$_counter次"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readCounter().then((int value){
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async{
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/counter.txt');
  }
  Future<int> _readCounter() async{
    try{
      File file = await _getLocalFile();
      String counters = await file.readAsStringSync();
      return int.parse(counters);
    }on FileSystemException{
      return 0;
    }
  }

  Future<Null> _incrementCounter() async{
    setState(() {
      _counter++;
    });
    await (await _getLocalFile()).writeAsStringSync("$_counter");
  }

}

//通过HttpClient发起HTTP请求
class HttpTestRoute extends StatefulWidget {
  @override
  HttpTestRouteState createState() => new HttpTestRouteState();
}

class HttpTestRouteState extends State<HttpTestRoute> {

  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HttpTest'),
      ),
      body: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("获取百度首页"),
                onPressed: _loading?null:() async{
                  setState(() {
                    _loading = true;
                    _text = "正在请求...";
                  });
                  try{
                    /*HttpClient httpClient = new HttpClient();
                    HttpClientRequest request = await httpClient.getUrl(Uri.parse("https://www.baidu.com"));
                    request.headers.add("user-agent", "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                    HttpClientResponse response = await request.close();
                    _text = await response.transform(utf8.decoder).join();
                    httpClient.close();*/
                    Dio dio = new Dio();
                    Response response = await dio.get("http://www.baidu.com");
                    _text = await response.toString();
                    print(response.headers);
                  }catch(e){
                    _text = "请求失败:$e";
                  }finally{
                    setState(() {
                      _loading = false;
                    });
                  }
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width-50,
                child: Text(_text.replaceAll(RegExp(r"\s"), "")),
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
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(HttpTestRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

//使用Dio开源库进行HTTP请求
class DioHttpTestRoute extends StatefulWidget {
  @override
  DioHttpTestRouteState createState() => new DioHttpTestRouteState();
}

class DioHttpTestRouteState extends State<DioHttpTestRoute> {
  
  Dio _dio = new Dio();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DioHttpTest'),
      ),
      body: FutureBuilder(
        future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            Response response = snapshot.data;
            if(snapshot.hasError){
              return Text(snapshot.error.toString());
            }

            return ListView(
              children: response.data.map<Widget>((e)=>ListTile(title: Text(e["full_name"]))).toList(),
            );
          }
          return CircularProgressIndicator();
        },
      ),
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
  void didUpdateWidget(DioHttpTestRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}

//WebSocket
class WebSocketRoute extends StatefulWidget {
  @override
  WebSocketRouteState createState() => new WebSocketRouteState();
}

class WebSocketRouteState extends State<WebSocketRoute> {

  TextEditingController _controller = new TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Form(
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Send a message'),
              ),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (context,snapshot){
                if(snapshot.hasError) {
                  _text = "网络不通";
                }else if(snapshot.hasData) {
                  _text = "echo:"+snapshot.data;
                }
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Text(_text),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage(){
    if(_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    channel = new IOWebSocketChannel.connect('ws://echo.websocket.org');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    channel.sink.close();
    super.dispose();
  }

  @override
  void didUpdateWidget(WebSocketRoute oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
}