import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    UserService.instance.myDoc.get().then((doc) {
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data != null) {
          setState(() {
            nameController.text = data['display_name'];
            photoUrlController.text = data['photo_url'];
          });
        }
      }
    });
    // UserData.get(myUid, cache: false).then((user) {
    //   dog(user);
    //   if (user == null) return;
    //   setState(() {
    //     nameController.text = user.displayName;
    //     this.user = user;
    //   });
    // });
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
          Text('MyUid: $myUid'),
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
                UserService.instance.doc(myUid).set({
                  'display_name': nameController.text,
                  'photo_url': photoUrlController.text
                }, SetOptions(merge: true));
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
