import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jaguar_resty/jaguar_resty.dart';

import 'model.dart';

main() async {
  int count = 0;
  globalClient = http.IOClient();

  WebSocket ws = await WebSocket.connect('ws://localhost:10000/changes');
  ws.listen((final data) {
    if (data is String) {
      Task task = Task.fromMap(json.decode(data));
      print(task);
    }
  });

  for (int i = 0; i < 10; i++) {
    count++;
    await post('http://localhost:10000/task').json(Task(
            id: count.toString(),
            message: 'Msg $count',
            created: DateTime.now())
        .toMap()).go();
  }
}
