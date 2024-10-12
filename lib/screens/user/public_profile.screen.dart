import 'package:flutter/material.dart';
import 'package:super_example/screens/chat/chat_room.screen.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class PublicProfileScreen extends StatefulWidget {
  static const String routeName = '/PublicProfile';
  const PublicProfileScreen({super.key, required this.uid});

  final String uid;

  @override
  State<PublicProfileScreen> createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  UserData? user;

  @override
  void initState() {
    super.initState();
    UserData.get(widget.uid).then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PublicProfile'),
      ),
      body: Column(
        children: [
          const Text("PublicProfile"),
          UserAvatar(uid: widget.uid),
          if (user != null) Text(user!.displayName),
          Wrap(
            children: [
              ElevatedButton(
                onPressed: () {
                  showGeneralDialog(
                    context: context,
                    pageBuilder: (_, __, ___) {
                      return ChatRoomScreen(
                        roomId: widget.uid,
                      );
                    },
                  );
                },
                child: const Text('Chat'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Block'),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Report'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
