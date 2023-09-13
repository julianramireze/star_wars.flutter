import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void useAsyncEffect(
  FutureOr<dynamic> Function() effect,
  FutureOr<dynamic> Function() cleanup, [
  List<Object> keys = const [],
]) {
  useEffect(() {
    Future.microtask(effect);
    return () {
      if (cleanup != null) {
        Future.microtask(cleanup);
      }
    };
  }, keys);
}
