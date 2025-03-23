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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onPanStart: (details) {
          setState(() {
            startX = details.localPosition.dx;
            startY = details.localPosition.dy;
            points.add(Offset(startX, startY));
          });
        },
        onPanUpdate: (details) {
      
          setState(() {
            endX = details.localPosition.dx;
            endY = details.localPosition.dy;
            points.add(Offset(endX, endY));
          });
        },
        onPanEnd: (details) {
          setState(() {
            endX = details.localPosition.dx;
            endY = details.localPosition.dy;
            points.add(Offset(endX, endY));
          });
        },
        child: Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.deepOrange, width: 2)),
          child: CustomPaint(
            painter: Line(points),
            child: SizedBox(width: 300, height: 800),
          ),
        ),
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


  @override
  Line(this.points) : super();

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black
          ..strokeWidth = 4
          ..strokeCap = StrokeCap.round;
    // canvas.drawPoints(PointMode.polygon, [Offset(x, y)], paint);
    // setPoints(points, canvas, paint);
    for (int i = 0; i < points.length - 1; i++) {
      // await Future.delayed(const Duration(seconds: 2), (){});
      canvas.drawLine(points[i], points[i + 1], paint);
      
    }
    canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    // canvas.drawVertices(Vertices(VertexMode.triangleFan, [Offset(x, y)]), BlendMode.color, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    print('repaint');
    return true;
  }
}
