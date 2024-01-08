// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

extension type SafeFuture<X>._(Future<X> _it) implements Future<X> {
  SafeFuture(FutureOr<X> computation()) : this._(Future(computation));

  SafeFuture.microtask(FutureOr<X> computation())
      : this._(Future.microtask(computation));

  SafeFuture.sync(FutureOr<X> computation()) : this._(Future.sync(computation));

  SafeFuture.value([FutureOr<X>? value]) : this._(Future.value(value));

  SafeFuture.error(Object error, [StackTrace? stackTrace])
      : this._(Future.error(error, stackTrace));

  SafeFuture.delayed(Duration duration, [FutureOr<X> computation()?])
      : this._(Future.delayed(duration, computation));

  static SafeFuture<List<X>> wait<X>(
    Iterable<Future<X>> futures, {
    bool eagerError = false,
    void cleanUp(T successValue)?,
  }) =>
      SafeFuture<List<X>>._(Future.wait<X>(futures,
          eagerError: eagerError, cleanUp: cleanUp));

  static SafeFuture<X> any<X>(Iterable<Future<X>> futures) =>
      SafeFuture<X>._(Future.any<X>(futures));

  static SafeFuture<void> forEach<X>(
    Iterable<X> elements,
    FutureOr action(T element),
  ) =>
      SafeFuture<void>._(Future.forEach<X>(elements, action));

  static SafeFuture<void> doWhile(FutureOr<bool> action()) =>
      SafeFuture<void>._(Future.doWhile(action));

  SafeFuture<R> then<R>(FutureOr<R> onValue(T value), {Function? onError}) =>
      SafeFuture<R>._(_it.then<R>(onValue, onError: onError));

  SafeFuture<X> catchError(Function onError, {bool test(Object error)?}) =>
      SafeFuture<X>._(_it.catchError(onError, test: test));

  SafeFuture<X> whenComplete(FutureOr<void> action()) =>
      SafeFuture<X>._(_it.whenComplete(action));

  Stream<X> asStream() => _it.asStream();

  SafeFuture<X> timeout(Duration timeLimit, {FutureOr<X> onTimeout()?}) =>
      SafeFuture<X>._(_it.timeout(timeLimit, onTimeout: onTimeout));
}

extension SafeFutureExtension<X> on Future<X> {
  SafeFuture<X> get safe => SafeFuture<X>._(this);
}
