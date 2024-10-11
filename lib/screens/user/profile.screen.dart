import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/Profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final photoUrlController = TextEditingController();
  UserData? user;

  @override
  void initState() {
    super.initState();
    UserData.get(myUid).then((user) {
      if (user == null) return;
      setState(() {
        nameController.text = user.displayName;
        this.user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          const Text("Profile"),
          if (user != null)
            UserAvatar(
              uid: user!.uid,
              width: 120,
              height: 120,
            ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          TextField(
            controller: photoUrlController,
            decoration: const InputDecoration(
              labelText: 'Photo URL',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                UserService.instance.doc(myUid).update({
                  'display_name': nameController.text,
                  'photo_url': photoUrlController.text
                });
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
