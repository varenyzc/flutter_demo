Future<String> mockNetworkData() async{
  return Future.delayed(Duration(seconds: 2),()=>"我是从互联网上获取到的数据");
}