import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? colorAnimation;
  Animation? sizeAnimation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    colorAnimation =
        ColorTween(begin: Colors.blue, end: Colors.yellow).animate(controller!);
    sizeAnimation = Tween<double>(begin: 30.0, end: 100.0).animate(controller!);
    controller!.addListener(() {
      setState(() {});
    });
    controller!.repeat();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animation Demo"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: colorAnimation!.value,
            shape: BoxShape.circle,
          ),
          height: sizeAnimation!.value,
          width: sizeAnimation!.value,
        ),
      ),
    );
  }
}
