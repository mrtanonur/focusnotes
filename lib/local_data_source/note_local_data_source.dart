import 'package:focusnotes/models/note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteLocalDataSource {
  static Box<NoteModel>? box;

  static Future openBox() async {
    box = await Hive.openBox("note");
  }

  static Future add(NoteModel noteModel) async {
    await box!.put(noteModel.id, noteModel);
  }

  static Future delete(String id) async {
    await box!.delete(id);
  }

  static read(NoteModel noteModel) {
    return box!.get(noteModel.id);
  }

  static List<NoteModel?> readAll() {
    return box!.values.toList();
  }

  static NoteModel find(String id) {
    return box!.values.toList().firstWhere((note) => note.id == id);
  }

  static Future clear() async {
    box!.clear();
  }
}
