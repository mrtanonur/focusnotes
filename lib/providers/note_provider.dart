import 'package:flutter/material.dart';
import 'package:focusnotes/local_data_source/note_local_data_source.dart';
import 'package:focusnotes/models/note_model.dart';
import 'package:focusnotes/services/firestore_service.dart';

enum NoteStatus { initial, loaded, empty, failure }

class NoteProvider extends ChangeNotifier {
  int? noteIndex;
  List<NoteModel?> notes = [];
  final FirestoreService _firestoreService = FirestoreService();
  String? error;
  NoteStatus status = NoteStatus.initial;

  void changeIndex(int index) {
    noteIndex = index;
  }

  void add(String title, String content) async {
    NoteModel noteModel = NoteModel(title: title, content: content);
    notes.add(noteModel);
    await NoteLocalDataSource.add(noteModel);
    await _firestoreService.add(noteModel);
    notifyListeners();
  }

  void delete(NoteModel noteModel) async {
    notes.remove(noteModel);
    await NoteLocalDataSource.delete(noteModel.id);
    _firestoreService.remove(noteModel.id);
    notifyListeners();
  }

  void update(String id, String title, String content) async {
    notes[noteIndex!] = notes[noteIndex!]!.copyWith(
      title: title,
      content: content,
    );

    NoteLocalDataSource.add(notes[noteIndex!]!);
    await notes[noteIndex!]!.save();
    await _firestoreService.update(notes[noteIndex!]!);

    notifyListeners();
  }

  void readAll() {
    final List<NoteModel?> localNotes = NoteLocalDataSource.readAll();
    notes = localNotes;
  }

  Future getNotes() async {
    final response = await _firestoreService.getNotes();
    response.fold(
      (String errorMessage) {
        if (NoteLocalDataSource.readAll().isEmpty) {
          status = NoteStatus.empty;
        } else {
          status = NoteStatus.loaded;
          notes = NoteLocalDataSource.readAll();
          print("hive success");
        }
      },
      (List<NoteModel?> fetchedNotes) {
        if (fetchedNotes.isEmpty) {
          status = NoteStatus.empty;
        } else {
          notes = fetchedNotes;
          status = NoteStatus.loaded;
          print(notes.first);
          print("firebase success");
        }
      },
    );
    notifyListeners();
  }
}
