import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/super_library.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/Profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          const Text("Profile"),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
            ),
          ),
          ElevatedButton(
              onPressed: () {
                UserService.instance
                    .doc(myUid)
                    .update({'display_name': nameController.text});
              },
              child: const Text('Save'))
        ],
      ),
    );
  }
}
