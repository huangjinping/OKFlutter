import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_plugin/my_plugin.dart';
import 'package:okflutter/CameraApp.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String changeMethod = "com.okflutter.changeMethod";
  String changeMethodPlugin = "getPlatformVersion";
  File? _image1;
  late File userFile;

  final _picker = ImagePicker();
  CameraController? controller;

  void onClick() {
    try {
      const methodChannel = MethodChannel("com.okflutter.connection");
      methodChannel.setMethodCallHandler((call) async {
        print("object-=====");
        print(call.arguments.toString());
      });
      methodChannel.invokeMapMethod(changeMethod, {"meg": "1"});
    } catch (e) {}
  }

  void onClick1() async {
    var myPlugin = MyPlugin();
    var temp = await myPlugin.getPlatformVersion();
    print("object${temp}");
  }

  Widget getImageView(File? imgw) {
    if (imgw != null) {
      return Image.file(imgw, width: 150, height: 105);
    }
    return Column();
  }

  void onCameraLib() async {
    print("onCameraLib");
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CameraApp();
    }));
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void _logError(String code, String? message) {
    // ignore: avoid_print
    print('Error: $code${message == null ? '' : '\nError Message: $message'}');
  }

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void onCamara() async {
    print("onCamara");
    int index = 1;
    // //创建picker对象，用于调用摄像机拍照或者录像
    // final pickedFile = await picker.pickImage(
    //   imageQuality: 60,
    //   maxWidth: 1280,
    //   maxHeight: 1920,
    //   source: ImageSource.camera,
    //   preferredCameraDevice:
    //       index == 3 ? CameraDevice.front : CameraDevice.rear,
    // );
    final picker = ImagePicker();

    final XFile? photo = await picker.pickImage(source: ImageSource.gallery);
    print("=================");
    if (photo != null) {
      File _Timage = File(photo.path); //创建文件对像
      setState(() {
        _image1 = _Timage;
      });
    }

    // try {
    // final XFile? pickedFile =
    //     await _picker.pickImage(source: ImageSource.camera);

    // } catch (e) {
    //   print(e);
    //
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(50),
              child: GestureDetector(onTap: onClick, child: Text("操作内部插件")),
            ),
            Container(
              margin: EdgeInsets.all(50),
              child: GestureDetector(onTap: onClick1, child: Text("操作外部插件")),
            ),
            Container(
              child: GestureDetector(onTap: onCamara, child: Text("打开1照相机")),
            ),
            Container(
              child:
                  GestureDetector(onTap: onCameraLib, child: Text("imageLib")),
            ),
            getImageView(_image1)
          ],
        ));
  }
}
