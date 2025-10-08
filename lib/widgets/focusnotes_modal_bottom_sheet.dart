import 'package:flutter/material.dart';
import 'package:focusnotes/l10n/app_localizations.dart';
import 'package:focusnotes/providers/note_provider.dart';
import 'package:focusnotes/utils/constants/size_constants.dart';
import 'package:focusnotes/widgets/focusnotes_textformfield.dart';
import 'package:provider/provider.dart';

class FocusNotesModalBottomSheet extends StatefulWidget {
  const FocusNotesModalBottomSheet({super.key});

  @override
  State<FocusNotesModalBottomSheet> createState() =>
      _FocusNotesModalBottomSheetState();
}

class _FocusNotesModalBottomSheetState
    extends State<FocusNotesModalBottomSheet> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _globalKey,
      autovalidateMode: AutovalidateMode.onUnfocus,
      child: Container(
        margin: EdgeInsets.only(bottom: SizeConstants.s24),
        padding: const EdgeInsets.all(SizeConstants.s24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppLocalizations.of(context)!.enterANote,
                style: TextStyle(fontSize: SizeConstants.s24),
              ),
              SizedBox(height: SizeConstants.s24),
              FocusNotesTextFormfield(
                controller: _titleController,
                hintText: AppLocalizations.of(context)!.title,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.enterATitle;
                  }
                  return null;
                },
              ),
              FocusNotesTextFormfield(
                controller: _contentController,
                hintText: AppLocalizations.of(context)!.content,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppLocalizations.of(context)!.enterAContent;
                  }
                  return null;
                },
              ),
              SizedBox(height: SizeConstants.s24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () async {
                      if (_globalKey.currentState!.validate()) {
                        context.read<NoteProvider>().add(
                          _titleController.text,
                          _contentController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              AppLocalizations.of(context)!.noteHasBeenAdded,
                            ),
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.outline,
                          ),
                        );

                        Navigator.pop(context);
                      }
                    },
                    child: Text(AppLocalizations.of(context)!.save),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.cancel),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
