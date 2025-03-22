import 'package:flutter/material.dart';
import '../widgets/Drawer.dart';

class NotePage extends StatelessWidget {
  const NotePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
      ),
      drawer: MyDrawer(notes: [Note(title: 'Note 1', content: 'Content 1'), Note(title: 'Note 2', content: 'Content 2')],),
      body: Center(
        child: SizedBox(
          width: 350,
          height: 800,
          child: Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    keyboardType: TextInputType.text, // General text input
                    textInputAction: TextInputAction.done, // Removes extra actions
                    enableSuggestions: true, // Disables suggestions
                    autocorrect: false, // Disables autocorrect
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Content',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 10, // Allows for multiline input
                    keyboardType: TextInputType.multiline, // Multiline input
                    enableSuggestions: true, // Disables suggestions
                    autocorrect: false, // Disables autocorrect
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}