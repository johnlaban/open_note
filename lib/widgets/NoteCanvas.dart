import 'dart:ui';

import 'package:flutter/material.dart';

class NoteCanvas extends StatefulWidget {
  const NoteCanvas({super.key});

  @override
  State<StatefulWidget> createState() {
    return NoteCanvasState();
  }
}

class NoteCanvasState extends State<NoteCanvas> {
  double startX = 0;
  double startY = 0;
  double endX = 0;
  double endY = 0;
  List<Offset> points = [];
  List<List<Offset>> lines = [];

  @override
  Widget build(BuildContext context) {
    print("REBUILDING");
    return Center(
      key: Key('canvas'),
      child: GestureDetector(
        key: Key('GestureDetector'),
        onPanStart: (details) {
          setState(() {
            startX = details.localPosition.dx;
            startY = details.localPosition.dy;
            points.add(Offset(startX, startY));
            lines.add([Offset(startX, startY), Offset(startX, startY)]);
          });
        },
        onPanUpdate: (details) {
          setState(() {
            endX = details.localPosition.dx;
            endY = details.localPosition.dy;
            points.add(Offset(endX, endY));
            lines[lines.length - 1].add(Offset(endX, endY));
          });
        },
        onPanEnd: (details) {
          endX = details.localPosition.dx;
          endY = details.localPosition.dy;
          points.add(Offset(endX, endY));
          setState(() {
            lines[lines.length - 1].add(Offset(endX, endY));
          });
          points = [];
        },
        child: Stack(
          key: Key("lines"),
          children: [
            RepaintBoundary(
              child: Container(
                key: Key("container"),
                color: Colors.white,
              ),
            ),
            for (var i = 0; i < lines.length; i++)
              RepaintBoundary(child: CustomPaint(key: Key(i.toString()), painter: Line(lines[i], i, lines.length - 1))),
            // CustomPaint(key: Key((lines.length - 1).toString()), painter: Line(lines[lines.length - 1], lines.length - 1, lines.length - 1)),
          ],
        ),
      ),
    );
  }
}

class Line extends CustomPainter {
  List<Offset> points;
  int currentLine;
  int index;

  @override
  Line(this.points, this.index, this.currentLine) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round;
    // for (var i = 0; i < points.length - 1; i++) {
    //   canvas.drawLine(points[i], points[i + 1], paint);
    // }
    var now = new DateTime.now();
    print("paint: " + index.toString() + " " + now.toString());
    canvas.drawPoints(PointMode.lines, points, paint);
    // canvas.drawLine(PointMode.points, points, paint);
    // canvas.drawVertices(Vertices(VertexMode.triangleFan, [Offset(x, y)]), BlendMode.color, paint);
  }

  @override
  bool shouldRepaint(covariant Line oldDelegate) {
    // print(oldDelegate.points.length.toString() + '---');
    // print(points.length);
    var now = new DateTime.now();
    print("repaint: " + index.toString() + " " + now.toString());
    // print('---');
    // return oldDelegate.points.length != points.length;
    print(index.toString() + " " + currentLine.toString());
    return index == currentLine;
    return true;
  }
}
