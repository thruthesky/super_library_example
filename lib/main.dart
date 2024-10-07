import 'dart:math';

import 'package:flutter/material.dart';
import 'package:super_example/chat_room.screen.dart';
import 'package:super_example/firebase_options.dart';
import 'package:super_library/custom_code/actions/index.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:super_library/custom_code/actions/super_library.dart';
import 'package:super_library/custom_code/widgets/index.dart';
import 'package:cached_network_image/cached_network_image.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SuperLibrary.instance.init(
    getDatabaseUrl: () =>
        'https://withcenter-test-4-default-rtdb.firebaseio.com',
  );

  UserService.instance.collectionName = 'users';

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Component.userListTile = (user) {
      return ListTile(
        leading: CachedNetworkImage(
          imageUrl: user.photoUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),
        title: Text(user.displayName),
        subtitle: Text(user.createdAt.toDateTime.short),
        trailing: IconButton(
          icon: const Icon(Icons.comment),
          onPressed: () {
            showGeneralDialog(
              context: context,
              pageBuilder: (_, __, ___) {
                return ChatRoomScreen(
                  otherUid: user.uid,
                );
              },
            );
          },
        ),
      );
    };
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Super Library'),
        actions: [
          AuthStateChanges(builder: (user) {
            return PopupMenuButton(itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: ListTile(
                    title: const Text('Create 10 test users'),
                    onTap: () async {
                      final String id = 'id${Random().nextInt(1000) + 9999}';

                      for (int i = 0; i < 10; i++) {
                        final String email = '$id-$i@test.com';
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: '12345a,*',
                        );
                        String uid = FirebaseAuth.instance.currentUser!.uid;
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .set({
                          'display_name': 'User-$id',
                          'created_time': FieldValue.serverTimestamp(),
                          'email': email,
                          'photo_url': 'https://picsum.photos/id/${i}0/200/300',
                        });
                        print(
                          'User $email created with uid: $uid',
                        );
                      }
                    },
                  ),
                ),
                if (user != null)
                  PopupMenuItem(
                    child: ListTile(
                      title: const Text('Sign Out'),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                    ),
                  ),
              ];
            });
          })
        ],
      ),
      body: AuthStateChanges(builder: (user) {
        if (user == null) {
          return Center(
            child: Column(
              children: [
                const Text('User is NOT signed in'),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signInAnonymously();
                  },
                  child: const Text('Sign in Anonymously'),
                ),

                /// Firebase email & password registration or login
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('Register'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          );
        }

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('UID: ${FirebaseAuth.instance.currentUser!.uid}'),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: const Text('Sign Out'),
                ),
                const SizedBox(height: 20),
                const SizedBox(
                  height: 300,
                  child: UserListView(),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
