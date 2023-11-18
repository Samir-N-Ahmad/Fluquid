import 'package:flutter/material.dart';

class RenderWidget extends StatefulWidget{
  const RenderWidget({super.key, required this.paths});
  final List<List<double>> paths;
  @override
  State<RenderWidget> createState()=> _RenderWidget();

}

class _RenderWidget extends State<RenderWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: RenderWindow(paths: widget.paths),);
  }

}
class RenderWindow extends CustomPainter{

    final List<List<double>> paths;

  RenderWindow({super.repaint, required this.paths});

  @override
  void paint(Canvas canvas, Size size) {

    for(List<double> postion in paths) {

    canvas.drawCircle(Offset(postion[1], postion[2]), postion[0], Paint()..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>true;
}