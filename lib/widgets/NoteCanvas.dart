import 'dart:ui';

import 'package:flutter/material.dart';

class NoteCanvas extends StatefulWidget {
  const NoteCanvas({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NoteCanvasState();
  }
}

class _NoteCanvasState extends State<NoteCanvas> {
  double startX = 0;
  double startY = 0;
  double endX = 0;
  double endY = 0;
  List<List<Offset>> lines = [];

  void _handlePointerDown(PointerEvent details) {
    setState(() {
      startX = details.localPosition.dx;
      startY = details.localPosition.dy;
      lines.add([Offset(startX, startY), Offset(startX, startY)]);
    });
  }

  void _handlePointerMove(PointerEvent details) {
    setState(() {
      endX = details.localPosition.dx;
      endY = details.localPosition.dy;
      lines[lines.length - 1].add(Offset(endX, endY));
    });
  }

  void _handlePointerUp(PointerEvent details) {
    endX = details.localPosition.dx;
    endY = details.localPosition.dy;
    setState(() {
      lines[lines.length - 1].add(Offset(endX, endY));
    });
  }

  @override
  Widget build(BuildContext context) {
    print("REBUILDING");
    print(lines.length);
    return Center(
      key: Key('canvas'),
      child: Listener(
        onPointerDown: _handlePointerDown,
        onPointerMove: _handlePointerMove,
        onPointerUp: _handlePointerUp,
        child: Stack(
          key: Key("lines"),
          children: [
            Container(
                key: Key("container"),
                color: Colors.white,
            ),
            for (var i = 0; i < lines.length; i++)
              RepaintBoundary(child: CustomPaint(key: Key(i.toString()), painter: Line(lines[i], i, lines.length - 1))),
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
