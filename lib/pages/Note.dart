import 'package:flutter/material.dart';
import '../widgets/Drawer.dart';

class Note {
  final String title;
  final String content;

  Note({required this.title, required this.content});
}

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _saveNote() {
    final String title = _titleController.text;
    final String content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      // Save the note (e.g., add it to a list or send it to a database)
      print('Note Saved: Title: $title, Content: $content');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Note saved successfully!')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in both fields before saving.')),
      );
    }
  }

  void _handleFocusManager() {
    if (FocusManager.instance.primaryFocus != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleFocusManager,
      child: Scaffold(
        appBar: AppBar(
          title: MyTitle(initTitle: "TEMP TITLE"),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: _saveNote, // Save note when the save button is pressed
            ),
          ],
        ),
        drawer: MyDrawer(
          notes: [
            Note(title: 'Note 1', content: 'Content 1'),
            Note(title: 'Note 2', content: 'Content 2'),
          ],
        ),
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
                      controller: _contentController, // Attach controller
                      decoration: InputDecoration(
                        labelText: 'Content',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 20,
                      keyboardType: TextInputType.multiline,
                      enableSuggestions: true,
                      autocorrect: false,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}

class MyTitle extends StatefulWidget {
  const MyTitle({super.key, required this.initTitle});

  final String initTitle;

  @override
  State<MyTitle> createState() {
    return _MyTitleState();
  }
}

class _MyTitleState extends State<MyTitle> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  late String _title;
  bool _isEditing = false;
  final String _noTitleFiller = "Untitled";

  @override
  void initState() {
    super.initState();
    _title = widget.initTitle;
    _textController.text = _title;

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus && _isEditing) {
        _toggleEditing();
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        if (_textController.text == "") {
          _title = _noTitleFiller;
          _textController.text = _noTitleFiller;
        } else {
          _title = _textController.text;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
      onDoubleTap: _toggleEditing,
      child:
          _isEditing
              ? TextField(
                controller: _textController,
                focusNode: _focusNode,
                autofocus: true,
                onSubmitted: (_) => _toggleEditing(),
                // decoration: const InputDecoration(border: InputBorder.none),
                style: TextStyle(fontSize: 25),
              )
              : Text(_title, style: TextStyle(fontSize: 28)),
    ));
  }
}
