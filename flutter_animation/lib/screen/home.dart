import 'package:flutter/material.dart';
import 'package:flutter_animation/widget/cat.dart';
import 'dart:math';

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<Home> with TickerProviderStateMixin {
  int _counter = 0;
  Animation<double> catAnimations;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    super.initState();
    catController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    catAnimations = Tween(begin: -30.0, end: -80.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));

    boxController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    boxAnimation = Tween(begin: pi * 0.60, end: pi * 0.65).animate(
        CurvedAnimation(parent: boxController, curve: Curves.easeInOut));

    boxController.forward();
    boxController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
  }

  onTap() {
    if (catController.isCompleted) {
      catController.reverse();
      boxController.forward();
    } else {
      catController.forward();
      boxController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Animations"),
      ),
      body: GestureDetector(
        child: Center(
            child: Stack(
          children: <Widget>[
            buildCatAnimation(),
            buildContainer(),
            buildLeftFlap(),
            buildRightFlap()
          ],
          overflow: Overflow.visible,
        )),
        onTap: onTap,
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimations,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimations.value,
          left: 0.0,
          right: 0.0,
        );
      },
      child: Cat(),
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.amber,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
          );
        },
      ),
      left: 6.0,
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 6.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 125.0,
          color: Colors.amber,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
          );
        },
      ),
    );
  }

  Widget buildContainer() {
    return Container(
      height: 200.0,
      width: 200.0,
      color: Colors.amber,
    );
  }
}
