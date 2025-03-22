import 'package:flutter/material.dart';
import 'pages/Note.dart';
import 'widgets/Drawer.dart';

void main() {
  runApp(const MainApp());
}

// class Note {
//   final String title;
//   final String content;

//   Note({
//     required this.title,
//     required this.content,
//   });
// }

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
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OpenNote'),
      ),
      drawer: MyDrawer(notes: [Note(title: 'Note 1', content: 'Content 1'), Note(title: 'Note 2', content: 'Content 2')],),
      drawerEnableOpenDragGesture: false,
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}

// class MyDrawer extends StatefulWidget {
//   const MyDrawer({
//     super.key,
//     required this.notes,
//   });

//   final List<Note> notes;

//   @override
//   State<MyDrawer> createState() => _MyDrawerState();
// }

  
// class _MyDrawerState extends State<MyDrawer> {

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           SizedBox(
//             height: 100,
//             child: DrawerHeader(
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(255, 195, 212, 230),
//               ),
//               child: const Text('Drawer Header'),
//             ),
//           ),
//           ListTile(
//             title: Text("Home Page"),
//             onTap:() => Navigator.pop(context),
//           ),
//           for (var note in widget.notes) ListTile(
//             title: Text(note.title),
//             onTap: () {
//               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Note_Page()));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
