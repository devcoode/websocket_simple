import 'dart:convert';

class Task {
  String id;
  String message;
  DateTime created;

  Task({this.id, this.message, this.created});

  static Task fromMap(Map map) => Task(
      id: map['id'],
      message: map['message'],
      created: DateTime.fromMillisecondsSinceEpoch(map['created']));

  Map toMap() =>
      {'id': id, 'message': message, 'created': created.millisecondsSinceEpoch};

  String toJson() => json.encode(toMap());

  String toString() => toMap().toString();
}
