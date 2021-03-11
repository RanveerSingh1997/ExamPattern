import 'dart:math' as math;

import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  static final String routName = "/demo";

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  Animation<double> transAnimation;
  AnimationController controller;
  Animation<double> _rotationTween;
  bool completed = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(min: 0, max: 1, reverse: false, period: Duration(seconds: 1));
    transAnimation = CurvedAnimation(parent: controller, curve: Interval(.7, 1,curve:Curves.ease));
    _rotationTween = CurvedAnimation(parent: controller, curve: Interval(0,.7,curve:Curves.decelerate));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOut);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {

         setState(() {
           completed = !completed;
         });
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:FloatingActionButton(
        child:Icon(Icons.add),
        onPressed:(){
             if(!controller.isCompleted){
               controller.forward();
             }else{
               controller.reverse();
             }
        },
      ),
      body: Center(
        child: ScaleTransition(
          scale: transAnimation,
          child: RotationTransition(
            turns: _rotationTween,
            child: AnimatedContainer(
              duration:Duration(seconds:1),
              height: completed ? MediaQuery.of(context).size.height : 400,
              width: completed ? MediaQuery.of(context).size.width : 400,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(completed ? 0 : 10)),
              child: Center(
                  child: Text(
                "A",
                style: Theme.of(context).textTheme.headline1,
              )),
            ),
          ),
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
