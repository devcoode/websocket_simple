import 'dart:async';

import 'package:jaguar/jaguar.dart';
import 'model.dart';

final tasks = <String, Task>{};

final pub = StreamController<Task>();

final Stream<Task> sub = pub.stream.asBroadcastStream();

main() async {
  final server = Jaguar(port: 10000);

  server.post('/task', (ctx) async {
    final task = await ctx.bodyAsJson(convert: Task.fromMap);
    tasks[task.id] = task;
    pub.add(task);
  });
  server.ws('/changes', onConnect: (ctx, ws) {
    StreamSubscription subscription = sub.listen((Task task) {
      ws.add(task.toJson());
    });
    ws.done.then((_) {
      subscription.cancel();
    });
  });

  server.log.onRecord.listen(print);

  await server.serve(logRequests: true);
}
