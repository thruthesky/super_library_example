// Automatic FlutterFlow imports

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:firebase_database/firebase_database.dart';

class Value<T> extends StatefulWidget {
  const Value({
    super.key,
    required this.ref,
    required this.builder,
    this.initialData,
    this.onLoading,
    this.sync = true,
  });

  final DatabaseReference ref;

  final dynamic initialData;

  /// [dynamic] is the value of the node.
  /// [String] is the path of the node.
  final Widget Function(dynamic value, DatabaseReference ref) builder;
  final Widget? onLoading;

  final bool sync;

  @override
  State<Value<T>> createState() => _ValueState<T>();
}

class _ValueState<T> extends State<Value<T>> {
  @override
  Widget build(BuildContext context) {
    if (widget.sync) {
      return StreamBuilder<dynamic>(
        initialData: widget.initialData,
        stream: widget.ref.onValue.map((event) {
          return event.snapshot.value;
        }),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // log('Error; path: ${widget.ref.path}, message: ${snapshot.error}');
            return Text(
                'Error; path: ${widget.ref.path}, message: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.hasData == false) {
            // log('--> Value() -> Waiting; path: ${ref.path} connectionState: ${snapshot.connectionState}, hasData: ${snapshot.hasData}');
            return widget.onLoading ?? const SizedBox.shrink();
          }

          // value may be null.
          return widget.builder(snapshot.data as T, widget.ref);
        },
      );
    } else {
      return FutureBuilder<dynamic>(
        initialData: widget.initialData,
        future: widget.ref.once().then((event) => event.snapshot.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting &&
              snapshot.hasData == false) {
            return widget.onLoading ?? const SizedBox.shrink();
          }
          if (snapshot.hasError) {
            // log('---> Value.once() -> Error; path: ${widget.ref.path}, message: ${snapshot.error}');
            return Text('Error; ${snapshot.error}');
          }

          return widget.builder(snapshot.data as T, widget.ref);
        },
      );
    }
  }
}
