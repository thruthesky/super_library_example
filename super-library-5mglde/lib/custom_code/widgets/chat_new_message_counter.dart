// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/actions/super_library.dart';

/// Display the total number of new messages of all chat rooms.
///
/// This widget rebuild when the number of new messages changes.
///
/// Counts the total new messages from `chat/settigns/<uid>/newMessageCount`
///
/// Logic:
/// 1. Returns builder parameter value if it is not null
/// 2. Next, returns ChatService.instance.newMessageBuilder, if it is not null
/// 3. Next, it won't show anything if count is 0.
/// 4. By default, it will show Badge(count) if count is not 0.
class ChatNewMessageCounter extends StatefulWidget {
  const ChatNewMessageCounter({
    super.key,
    this.width,
    this.height,
  });

  final double? width;
  final double? height;

  @override
  State<ChatNewMessageCounter> createState() => _ChatNewMessageCounterState();
}

class _ChatNewMessageCounterState extends State<ChatNewMessageCounter> {
  @override
  Widget build(BuildContext context) {
    return Value(
      ref: ChatService.instance.mySettingRef
          .child(ChatJoin.field.newMessageCount),
      builder: (value, ref) {
        final newMessageCounts = Map<String, int>.from((value ?? {}) as Map);
        final int totalCount =
            newMessageCounts.values.fold(0, (sum, element) => sum + element);

        if (totalCount == 0) {
          // By default, if no builders, it doesn't show anything
          return const SizedBox.shrink();
        }
        return Badge(
          label: Text(
            '$totalCount',
          ),
        );
      },
    );
  }
}
