import 'package:flutter/material.dart';

//https://www.codenong.com/cs106417937/
class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>  with SingleTickerProviderStateMixin{
  Duration duration = Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    scaleController = AnimationController(vsync: this, duration: duration);
    scale = Tween<double>(begin: 0.8, end: 1.0).animate(scaleController);
    scaleController.repeat(reverse: true);
  }

  Widget getAnimation0() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 200,
      height: 300,
      child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          //当内容有变化的时候就会触发动画
          child: Container(
            key: UniqueKey(),
            padding: EdgeInsets.all(12),
            color: Colors.red,
            child: Text(
              'content',
            ),
          ),
          // 丰富的动画控制
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: animation,
                child: child,
              ),
            );
          }),
    );
  }

  Widget getTweenAnimation() {
    return TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(seconds: 5),
        builder: (context, double value, widget) {
          return Opacity(
            opacity: value,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          );
        });
  }

  late AnimationController scaleController;
  late Animation<double> scale;

  @override
  void dispose() {

    scaleController?.dispose();
    super.dispose();
  }

  Widget getChiAnimation() {
    return Container(
      child: AnimatedContainer(
        width: 200,
        height: 200,
        padding: EdgeInsets.all(10),
        duration: duration,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: ScaleTransition(
          scale: scale,
          child: Text("ScaleTransition"),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation"),
      ),
      body: Column(
        children: [
          getAnimation0(),
          getTweenAnimation(),
          getChiAnimation(),
          Text("ddd22dd"),
          // Text(data)
        ],
      ),
    );
  }
}
