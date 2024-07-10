import 'package:flutter/material.dart';

class DraggableButtonExample extends StatefulWidget {
  @override
  _DraggableButtonExampleState createState() => _DraggableButtonExampleState();
}

class _DraggableButtonExampleState extends State<DraggableButtonExample> {
  double leftPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              Positioned(
                left: leftPosition,
                child: Draggable(
                  axis: Axis.horizontal,
                  feedback: _buildButton(),
                  childWhenDragging: Container(),
                  onDragEnd: (details) {
                    setState(() {
                      leftPosition = (details.offset.dx - 50).clamp(0.0, 200.0);
                    });
                  },
                  child: _buildButton(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Text(
          'Go Online',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Arial',
          ),
        ),
      ),
    );
  }
}