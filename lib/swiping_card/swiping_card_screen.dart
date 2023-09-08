import 'dart:math';

import 'package:flutter/material.dart';

class SwipingCardScreen extends StatefulWidget {
  const SwipingCardScreen({super.key});

  @override
  State<SwipingCardScreen> createState() => _SwipingCardScreenState();
}

class _SwipingCardScreenState extends State<SwipingCardScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  double posX = 0.0;
  late final AnimationController _position = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      upperBound: size.width,
      lowerBound: size.width * -1,
      value: 0.0);

  late final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _position.value += details.delta.dx;
    setState(() {});
  }

  void _onHorizontalDragEnds(DragEndDetails details) {
    setState(() {
      _position.animateTo(0, curve: Curves.bounceOut);
    });
  }

  @override
  void dispose() {
    _position.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(posX);
    return Scaffold(
      appBar: AppBar(
        title: const Text('card'),
      ),
      body: AnimatedBuilder(
        animation: _position,
        builder: (context, child) {
          final angle = _rotation
              .transform((_position.value + size.width / 2) / size.width);
          print(angle);
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onHorizontalDragEnd: _onHorizontalDragEnds,
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  child: Transform.translate(
                    offset: Offset(_position.value, 0),
                    child: Transform.rotate(
                      angle: angle * pi / 180,
                      child: Material(
                        color: Colors.red.shade100,
                        child: SizedBox(
                          height: size.height * 0.5,
                          width: size.width * 0.8,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
