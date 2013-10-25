// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:isolate';

main() {
  ReceivePort reply = new ReceivePort();
  Isolate.spawn(runTest, reply.sendPort);
  reply.first.then((StackTrace stack) {
    print(stack);
  });
}

runTest(SendPort sendport) {
  try {
    throw 'sorry';
  } catch (e, stack) {
    try {
      sendport.send(stack);
      print("Stacktrace sent");
    } catch (e) {
      print("Stacktrace not sent");
      sendport.send(null);
    }
  }
}
