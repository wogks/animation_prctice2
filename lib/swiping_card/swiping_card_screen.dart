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
  late final AnimationController _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      upperBound: size.width,
      lowerBound: size.width * -1,
      value: 0.0);

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _animationController.value += details.delta.dx;
    setState(() {});
  }

  void _onHorizontalDragEnds(DragEndDetails details) {
    setState(() {
      _animationController.animateTo(0, curve: Curves.bounceOut);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(posX);
    return Scaffold(
      appBar: AppBar(
        title: const Text('card'),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: GestureDetector(
                  onHorizontalDragEnd: _onHorizontalDragEnds,
                  onHorizontalDragUpdate: _onHorizontalDragUpdate,
                  child: Transform.translate(
                    offset: Offset(_animationController.value, 0),
                    child: Material(
                      color: Colors.red.shade100,
                      child: SizedBox(
                        height: size.height * 0.5,
                        width: size.width * 0.8,
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
