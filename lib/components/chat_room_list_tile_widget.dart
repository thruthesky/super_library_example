import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatRoomListTileWidget extends StatefulWidget {
  const ChatRoomListTileWidget({
    super.key,
    required this.id,
    required this.name,
    required this.open,
  });

  final String? id;
  final String? name;
  final bool? open;

  @override
  State<ChatRoomListTileWidget> createState() => _ChatRoomListTileWidgetState();
}

class _ChatRoomListTileWidgetState extends State<ChatRoomListTileWidget> {
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Chat Room ID: ${widget.id}',
              ),
              Text(
                widget.name!,
              ),
              Text(
                'Open: ${widget.open?.toString()}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
