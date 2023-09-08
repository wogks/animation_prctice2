import 'package:flutter/material.dart';

class SwipingCardScreen extends StatefulWidget {
  const SwipingCardScreen({super.key});

  @override
  State<SwipingCardScreen> createState() => _SwipingCardScreenState();
}

class _SwipingCardScreenState extends State<SwipingCardScreen> {
  double posX = 0.0;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    posX += details.delta.dx;
    setState(() {});
  }

  void _onHorizontalDragEnds(DragEndDetails details) {
    setState(() {
      posX = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(posX);
    return Scaffold(
      appBar: AppBar(
        title: const Text('card'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onHorizontalDragEnd: _onHorizontalDragEnds,
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              child: Transform.translate(
                offset: Offset(posX, 0),
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
      ),
    );
  }
}
