import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String content;

  NoteModel({String? id, required this.title, required this.content})
    : id = id ?? const Uuid().v4();

  NoteModel copyWith({String? id, String? title, String? content}) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
    );
  }

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json["id"],
      title: json["title"],
      content: json["content"],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "title": title, "content": content};
  }
}
