import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlayCompleted = false; // 标记视频是否播放完成
  Timer? _progressRefreshTimer;

  @override
  void initState() {
    super.initState();
    // 初始化视频控制器（支持本地/网络视频）
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        'https://www.cloudglobalpay.com/181a8.mp4',
      ),
      // 本地视频示例：VideoPlayerController.asset('assets/videos/test.mp4'),
    );

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      // 监听视频播放进度
      _controller.addListener(_videoProgressListener);
      _controller.play(); // 自动播放核心代码
      setState(() {});

      _progressRefreshTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (_controller.value.isPlaying && !_isPlayCompleted) {
          setState(() {}); // 触发重建，更新进度条
        }
      });
    });

    // 监听视频播放完成事件
    _controller.setLooping(false); // 禁止循环播放
  }

  /// 视频进度监听（核心：禁止快进）
  void _videoProgressListener() {
    final currentPosition = _controller.value.position;
    final duration = _controller.value.duration;

    // 1. 检测视频是否播放完成
    if (currentPosition >= duration && !_isPlayCompleted) {
      _isPlayCompleted = true;
      _controller.pause(); // 播放完成后暂停
      // Fluttertoast.showToast(
      //   msg: "视频已完成",
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.CENTER,
      //   timeInSecForIosWeb: 1,
      //   backgroundColor: Colors.black54,
      //   textColor: Colors.white,
      //   fontSize: 16.0,
      // );
    }
  }


  Widget _buildCustomProgressBar() {
    final currentPosition = _controller.value.position;
    final duration = _controller.value.duration;

    if (duration == Duration.zero || currentPosition > duration) {
      return const Slider(value: 0, min: 0, max: 1, onChanged: null);
    }

    return Slider(
      value: currentPosition.inMilliseconds.toDouble(),
      min: 0,
      max: duration.inMilliseconds.toDouble(),
      onChanged: (value) {
        final newPosition = Duration(milliseconds: value.toInt());
        if (newPosition <= currentPosition) {
          _controller.seekTo(newPosition);
        }
      },
      activeColor: Colors.blue,
      inactiveColor: Colors.grey,
    );
  }


  //
  // /// 自定义进度条（禁止快进）
  // Widget _buildCustomProgressBar() {
  //   var stream = _controller.position.asStream();
  //
  //   return StreamBuilder<Duration?>(
  //     stream: stream,
  //     builder: (context, snapshot) {
  //       final position = snapshot.data ?? Duration.zero;
  //       final duration = _controller.value.duration;
  //
  //       print("$position====duration=======$duration");
  //       return Slider(
  //         value: position.inMilliseconds.toDouble(),
  //         min: 0,
  //         max: duration.inMilliseconds.toDouble(),
  //         onChanged: (value) {
  //           // 核心逻辑：禁止快进（只能拖动到当前位置或更前，不能往后）
  //           // final newPosition = Duration(milliseconds: value.toInt());
  //           // if (newPosition <= position) {
  //           //   _controller.seekTo(newPosition);
  //           // }
  //         },
  //         activeColor: Colors.blue,
  //         inactiveColor: Colors.grey,
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    // 释放资源
    // _controller.removeListener(_videoProgressListener);
    // _controller.dispose();
    // super.dispose();
    _progressRefreshTimer?.cancel();
    _controller.removeListener(_videoProgressListener);
    if (_controller.value.isPlaying) {
      _controller.pause();
    }
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('禁止快进视频播放')),
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                // 视频播放区域
                Container(
                  height: 200,
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
                // 控制栏
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      // 自定义进度条（禁止快进）
                      _buildCustomProgressBar(),
                      // 播放/暂停按钮
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            iconSize: 40,
                            onPressed: () {
                              setState(() {
                                // 重置完成标记（重新播放时）
                                if (_isPlayCompleted) {
                                  _isPlayCompleted = false;
                                  _controller.seekTo(Duration.zero);
                                }
                                // 播放/暂停切换
                                _controller.value.isPlaying
                                    ? _controller.pause()
                                    : _controller.play();
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // 加载中
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
