import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'pages/Note.dart';
import 'widgets/Drawer.dart';

void main() {
  debugRepaintRainbowEnabled = true;
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OpenNote',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'OpenNote',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 196, 20, 231),
      ),
      drawer: MyDrawer(
        notes: [
          Note(title: 'Note 1', content: 'Content 1'),
          Note(title: 'Note 2', content: 'Content 2'),
        ],
      ),
      drawerEnableOpenDragGesture: false,
      body: Center(child: Text('Hello World!')),
    );
  }
}
