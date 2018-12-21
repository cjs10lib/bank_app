import 'dart:math' as math;
import 'package:flutter/material.dart';

class OptionsFAB extends StatefulWidget {
  @override
  _OptionsFABState createState() => _OptionsFABState();
}

class _OptionsFABState extends State<OptionsFAB> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 55.0,
          width: 55.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.5, 1.0, curve: Curves.easeOut)),
            child: FloatingActionButton(
                mini: true,
                heroTag: 'loan',
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.move_to_inbox),
                tooltip: 'Request Loan',
                onPressed: () =>
                    Navigator.of(context).pushNamed('/loan-order')),
          ),
        ),
        Container(
          height: 55.0,
          width: 55.0,
          alignment: FractionalOffset.topCenter,
          child: ScaleTransition(
            scale: CurvedAnimation(
                parent: _controller,
                curve: Interval(0.0, 0.5, curve: Curves.easeOut)),
            child: FloatingActionButton(
                mini: true,
                heroTag: 'withdrawal',
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(Icons.credit_card),
                tooltip: 'Request Withdrawal',
                onPressed: () =>
                    Navigator.of(context).pushNamed('/withdrawal-order')),
          ),
        ),
        FloatingActionButton(
            heroTag: 'options',
            tooltip: 'Transaction Options',
            backgroundColor: Theme.of(context).primaryColor,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.rotationZ(_controller.value * 0.75),
                  child: Icon(Icons.add));
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            }),
      ],
    );
  }
}
