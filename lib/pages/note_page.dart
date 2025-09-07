import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/providers/note_provider.dart';
import 'package:focusnotes/widgets/focusnotes_appbar.dart';
import 'package:focusnotes/widgets/focusnotes_modal_bottom_sheet.dart';
import 'package:focusnotes/widgets/focusnotes_textformfield.dart';
import 'package:provider/provider.dart';

import '../utils/constants/constants.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  void initState() {
    context.read<NoteProvider>().getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FocusnotesAppBar(
        color: Theme.of(context).colorScheme.surfaceBright,
        title: AppLocalizations.of(context)!.notes,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true, // 👈 important
            builder: (context) {
              return FocusNotesModalBottomSheet();
            },
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(SizeConstants.s24),
        child: Consumer<NoteProvider>(
          builder: (context, provider, child) {
            if (provider.status == NoteStatus.empty) {
              print("bbb");
              return Center(
                child: Text(AppLocalizations.of(context)!.thereAreNoSavedNotes),
              );
            } else if (provider.status == NoteStatus.loaded) {
              print("iniytyy");
              return ListView.separated(
                itemBuilder: (context, index) {
                  print("eee");
                  return NoteTile(index: index);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: SizeConstants.s12);
                },
                itemCount: provider.notes.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}

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

Future alertPopUp(BuildContext context, Widget widget) async {
  if (Platform.isAndroid) {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SizedBox(
            width: SizeConstants.s300,
            height: SizeConstants.s250,
            child: widget,
          ),
        );
      },
    );
  } else {
    await showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Material(child: Column(children: [widget])),
        );
      },
    );
  }
}

class DeleteConfirmationPopUp extends StatelessWidget {
  final int index;
  const DeleteConfirmationPopUp({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(AppLocalizations.of(context)!.areYouSure),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(AppLocalizations.of(context)!.yes),
              onPressed: () {
                NoteProvider provider = context.read<NoteProvider>();
                provider.delete(provider.notes[index]!);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      AppLocalizations.of(context)!.noteHasBeenDeleted,
                    ),
                    backgroundColor: Theme.of(context).colorScheme.outline,
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.no),
            ),
          ],
        ),
      ],
    );
  }
}

class UpdatePopUp extends StatefulWidget {
  const UpdatePopUp({super.key});

  @override
  State<UpdatePopUp> createState() => _UpdatePopUpState();
}

class _UpdatePopUpState extends State<UpdatePopUp> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  bool isLoading = false;

  NoteProvider? provider0;
  @override
  void initState() {
    super.initState();

    provider0 = context.read<NoteProvider>();
    final note = provider0!.notes[provider0!.noteIndex!]!;
    titleController.text = note.title;
    contentController.text = note.content;
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Column(
        children: [
          Text(AppLocalizations.of(context)!.updateYourNoteHere),
          FocusNotesTextFormfield(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enterATitle;
              }
              return null;
            },
            controller: titleController,
            hintText: AppLocalizations.of(context)!.title,
          ),
          FocusNotesTextFormfield(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return AppLocalizations.of(context)!.enterAContent;
              }
              return null;
            },
            controller: contentController,
            hintText: AppLocalizations.of(context)!.content,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  if (globalKey.currentState!.validate()) {
                    NoteProvider provider = context.read<NoteProvider>();
                    provider.update(
                      provider.notes[provider.noteIndex!]!.id,
                      titleController.text,
                      contentController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          AppLocalizations.of(context)!.noteHasBeenUpdated,
                        ),
                        backgroundColor: Theme.of(context).colorScheme.outline,
                      ),
                    );

                    Navigator.pop(context);
                  }
                },
                child: Text(AppLocalizations.of(context)!.save),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.cancel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
