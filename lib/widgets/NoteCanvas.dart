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
  List<RepaintBoundary> lines = [
    RepaintBoundary(
      key: Key('paint0'),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrange, width: 2),
        ),
        child: CustomPaint(
          painter: Line([], 0),
          child: SizedBox(width: 300, height: 800),
        ),
      ),
    ),
  ];

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
            lines.add(
              RepaintBoundary(
                key: Key(lines.length.toString()),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepOrange, width: 2),
                  ),
                  child: CustomPaint(
                    key: Key("paint" + (lines.length).toString()),
                    painter: Line(points, lines.length - 1),
                    child: SizedBox(width: 300, height: 800),
                  ),
                ),
              ),
            );
          });
        },
        onPanUpdate: (details) {
          setState(() {
            endX = details.localPosition.dx;
            endY = details.localPosition.dy;
            points.add(Offset(endX, endY));
            lines[lines.length - 1] = RepaintBoundary(
              key: Key((lines.length - 1).toString()),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2),
                ),
                child: CustomPaint(
                  key: Key("paint" + (lines.length - 1).toString()),
                  painter: Line(points, lines.length - 1),
                  child: SizedBox(width: 300, height: 800),
                ),
              ),
            );
          });
        },
        onPanEnd: (details) {
          endX = details.localPosition.dx;
          endY = details.localPosition.dy;
          points.add(Offset(endX, endY));
          setState(() {
            lines[lines.length - 1] = RepaintBoundary(
              key: Key((lines.length - 1).toString()),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrange, width: 2),
                ),
                child: CustomPaint(
                  key: Key("paint" + (lines.length - 1).toString()),
                  painter: Line(points, lines.length - 1),
                  child: SizedBox(width: 300, height: 800),
                ),
              ),
            );
          });
          points = [];
        },
        child: Stack(key: Key("lines"), children: lines),
      ),
    );
  }
}

class Line extends CustomPainter {
  double startX = 0;
  double startY = 0;
  double endX = 0;
  double endY = 0;
  List<Offset> points;
  int index;

  @override
  Line(this.points, this.index) : super();

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
    return true;
  }
}
