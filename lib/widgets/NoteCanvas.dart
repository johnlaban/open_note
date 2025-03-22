import 'package:flutter/material.dart';

class NoteCanvas extends StatefulWidget {
  const NoteCanvas({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return NoteCanvasState();
  }
}

class NoteCanvasState extends State<NoteCanvas> {
  @override
  Widget build(BuildContext context) {
    return Container(color: const Color(0xFFFFE306));
  }
}
