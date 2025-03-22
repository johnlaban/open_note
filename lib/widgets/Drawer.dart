import 'package:flutter/material.dart';
import '../pages/Note.dart';

class Note {
  final String title;
  final String content;

  Note({required this.title, required this.content});
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key, required this.notes});

  final List<Note> notes;

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 195, 212, 230),
                ),
                child: const Text('Open Note', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
              ),
            ),
            ListTile(
              title: Text("Home Page", style: TextStyle(fontWeight: FontWeight.bold)),
              style: ListTileStyle.drawer,
              onTap:
                  () => Navigator.of(context).pushNamedAndRemoveUntil(
                    '/',
                    (Route<dynamic> route) => false,
                  ),
            ),
            for (var note in widget.notes)
              ListTile(
                title: Text(note.title),
                style: ListTileStyle.drawer,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NotePage()),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
