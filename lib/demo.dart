import 'dart:math' as math;

import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  static final String routName = "/demo";

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  Tween<double> _rotationTween;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _rotationTween = Tween(begin: 0, end:0);
    animation = _rotationTween.animate(controller)
      ..addListener(() {
        setState(() {});
      });
      // ..addStatusListener((status) {
      //   if (status == AnimationStatus.completed) {
      //     controller.reverse();
      //   } else if (status == AnimationStatus.dismissed) {
      //     controller.forward();
      //   }

    controller.repeat(min: 0,max: 1,reverse: false,period: Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      origin: Offset(0, 0),
      transform: Matrix4.skewX(0),
      child: CustomPaint(
        painter: ShapePainter(animation.value),
        child: Container(
          child:Center(child: Text("A",style:Theme.of(context).textTheme.headline1,)),
        ),
      ),
    );
  }
}

class ShapePainter extends CustomPainter {
  var sides = 4, radius = 150;
  var radian;

  ShapePainter(this.radian);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.green.shade100
      ..strokeWidth = 2.0;
    var path = Path();
    var angle = (math.pi * 2) / sides;
    Offset center = Offset(size.width / 2, size.height / 2);
    Offset startPoint = Offset(radius * math.cos(0.0), radius * math.sin(0.0));

    path.moveTo(startPoint.dx + center.dx, startPoint.dy + center.dy);

    for (int i = 1; i <= sides; i++) {
      double x = radius * math.cos(angle * i) + center.dx;
      double y = radius * math.sin(angle * i) + center.dy;
      path.lineTo(x, y);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
