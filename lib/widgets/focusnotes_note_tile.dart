import 'package:flutter/material.dart';
import 'package:focusnotes/pages/note_page.dart';
import 'package:focusnotes/providers/note_provider.dart';
import 'package:provider/provider.dart';

class NoteTile extends StatefulWidget {
  final int index;
  const NoteTile({super.key, required this.index});

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    NoteProvider provider = context.read<NoteProvider>();
    return ListTile(
      onTap: () {
        provider.changeIndex(widget.index);
        alertPopUp(context, UpdatePopUp());
      },
      title: Text(provider.notes[widget.index]!.title),
      subtitle: Text(provider.notes[widget.index]!.content),
      trailing: IconButton(
        onPressed: () {
          alertPopUp(context, DeleteConfirmationPopUp(index: widget.index));
        },
        icon: Icon(Icons.cancel),
      ),
    );
  }
}
