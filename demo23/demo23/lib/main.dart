import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

var cameras;
void main() async{
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraExampleHome(),
    );
  }
}

IconData getCameraLensIcon(CameraLensDirection direction){
  switch(direction) {
    case CameraLensDirection.back:
      return Icons.camera_rear;
    case CameraLensDirection.front:
      return Icons.camera_front;
    case CameraLensDirection.external:
      return Icons.camera;
  }
  throw ArgumentError('Unkonwn lens direction');
}

void logError(String code,String message) => print("Error:$code\nError Message:$message");

class CameraExampleHome extends StatefulWidget {
  @override
  CameraExampleHomeState createState() => new CameraExampleHomeState();
}

class CameraExampleHomeState extends State<CameraExampleHome> with WidgetsBindingObserver{

  CameraController controller;
  String imagePath;
  String videoPath;
  VideoPlayerController videoPlayerController;
  VoidCallback videoPlayerListener;
  bool enableAudio = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('CameraTest'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: controller!=null && controller.value.isRecordingVideo
                      ? Colors.redAccent
                      : Colors.grey,
                  width: 3.0,
                )
              ),
            ),
          ),
          _captureControlRowWidget(),
          _toggleAudioWidget(),
          Padding(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _cameraTogglesRowWidget(),
                _thumbnailWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget(){
    if(controller==null||!controller.value.isInitialized){
      return Text(
        '选择一个摄像头',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900
        ),
      );
    }else{
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  Widget _toggleAudioWidget(){
    return Padding(
      padding: EdgeInsets.only(left: 25),
      child: Row(
        children: <Widget>[
          Text('开启录音'),
          Switch(
            value: enableAudio,
            onChanged: (value){
              enableAudio = value;
              if(controller!=null) {
                onNewCameraSelected(controller.description);
              }
            },
          )
        ],
      ),
    );
  }

  Widget _thumbnailWidget(){
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            videoPlayerController == null && imagePath == null
              ? Container()
                : SizedBox(
              child: (videoPlayerController == null)
                ? Image.file(File(imagePath))
                : Container(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: videoPlayerController.value.size !=null
                      ? videoPlayerController.value.aspectRatio
                      : 1.0,
                    child: VideoPlayer(videoPlayerController),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink)
                ),
                width: 64.0,
                height: 64.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _captureControlRowWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: controller!=null &&
            controller.value.isInitialized &&
            !controller.value.isRecordingVideo
            ? onTakePictureButtonPressed
            : null,
        ),
        IconButton(
          icon: const Icon(Icons.videocam),
          color: Colors.blue,
          onPressed: controller != null &&
              controller.value.isInitialized &&
              !controller.value.isRecordingVideo
              ? onVideoRecordButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed: controller != null &&
              controller.value.isInitialized &&
              controller.value.isRecordingVideo
              ? onStopButtonPressed
              : null,
        )
      ],
    );
  }

  Widget _cameraTogglesRowWidget(){
    final List<Widget> toggles = <Widget>[];
    if(cameras.isEmpty){
      return Text('没有检测到摄像头');
    }else{
      for(CameraDescription cameraDescription in cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: controller?.description,
              value: cameraDescription,
              onChanged: controller!=null && controller.value.isRecordingVideo
                ? null
                : onNewCameraSelected,
            ),
          )
        );
      }
      return Row(children: toggles,);
    }
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text(message),));
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async{
    if(controller!=null){
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: enableAudio
    );

    controller.addListener((){
      if(mounted) setState(() {
      });
      if(controller.value.hasError){
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try{
      await controller.initialize();
    }on CameraException catch(e){
      _showCameraException(e);
    }
    if(mounted){
      setState(() {

      });
    }
  }

  // 拍照按钮点击回调
  void onTakePictureButtonPressed() {
    takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
          videoPlayerController?.dispose();
          videoPlayerController = null;
        });
        if (filePath != null) showInSnackBar('图片保存在 $filePath');
      }
    });
  }

  // 开始录制视频
  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted) setState(() {});
      if (filePath != null) showInSnackBar('正在保存视频于 $filePath');
    });
  }

  // 终止视频录制
  void onStopButtonPressed() {
    stopVideoRecording().then((_) {
      if (mounted) setState(() {});
      showInSnackBar('视频保存在: $videoPath');
    });
  }

  Future<String> startVideoRecording() async {
    if (!controller.value.isInitialized) {
      showInSnackBar('请先选择一个摄像头');
      return null;
    }

    // 确定视频保存的路径
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (controller.value.isRecordingVideo) {
      // 如果正在录制，则直接返回
      return null;
    }

    try {
      videoPath = filePath;
      await controller.startVideoRecording(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<void> _startVideoPlayer() async{
    final VideoPlayerController vcontroller =
    VideoPlayerController.file(File(videoPath));
    videoPlayerListener = (){
      if(videoPlayerController!=null && videoPlayerController.value.size!=null){
        if(mounted) setState(() {

        });
        videoPlayerController.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(true);
    await vcontroller.initialize();
    await videoPlayerController?.dispose();
    if(mounted){
      setState(() {
        imagePath = null;
        videoPlayerController = vcontroller;
      });
    }
    await vcontroller.play();
  }

  Future<String> takePicture() async{
    if(!controller.value.isInitialized){
      showInSnackBar('错误：请先选择一个相机');
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if(controller.value.isTakingPicture){
      return null;
    }

    try{
      await controller.takePicture(filePath);
    }on CameraException catch(e){
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await controller.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    await _startVideoPlayer();
  }

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state==AppLifecycleState.inactive) {
      controller?.dispose();
    }else if(state==AppLifecycleState.resumed) {
      if(controller!=null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void didUpdateWidget(CameraExampleHome oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

}