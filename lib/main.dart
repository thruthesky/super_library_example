import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:super_example/components/chat_room_list_tile_widget.dart';
import 'package:super_example/screens/chat/chat_room.list.screen.dart';
// import 'package:super_example/chat_room.screen.dart';
import 'package:super_example/firebase_options.dart';
import 'package:super_example/screens/user/custom.user_list_view.screen.dart';
import 'package:super_example/screens/user/custom_component.user_list_view.screen.dart';
import 'package:super_example/screens/user/horizontal.custom_component.user_list_view.screen.dart';
import 'package:super_example/screens/user/horizontal.user_list_view.screen.dart';
import 'package:super_example/screens/user/user_list_view.screen.dart';
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
    debug: true,
  );

  UserService.instance.collectionName = 'users';

  Component.userListTile = (user) => CustomTile(user: user);
  Component.chatRoomListTile = (join) => ChatRoomListTileWidget(
        roomId: join.roomId,
        name: join.name,
        iconUrl: join.iconUrl,
        displayName: join.displayName,
        photoUrl: join.photoUrl,
        group: join.group,
        single: join.single,
        open: join.open,
        lastMessageAt: join.lastMessageAt,
        lastMessageDeleted: join.lastMessageDeleted,
        lastText: join.lastText,
        lastUrl: join.lastUrl,
        lastProtocol: join.lastProtocol,
        unreadMessageCount: join.unreadMessageCount,
      );

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

  StreamSubscription? userSubscription;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(uid)
                        .set({
                      'display_name': 'Anonymous $uid',
                      'created_time': FieldValue.serverTimestamp(),
                      'photo_url': 'https://picsum.photos/id/123/200/300',
                    });
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
                UserAvatar(
                  uid: myUid,
                  width: 48,
                  height: 48,
                ),
                Text('UID: ${FirebaseAuth.instance.currentUser!.uid}'),
                ElevatedButton(
                  onPressed: () async {
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
                  child: const Text('Create 10 test users'),
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        showGeneralDialog(
                          context: context,
                          pageBuilder: (context, a1, a2) {
                            return const ChatRoomListScreen();
                          },
                        );
                      },
                      child: const Text('Chat Rooms'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Sign Out'),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () => showGeneralDialog(
                          context: context,
                          pageBuilder: (_, __, ___) {
                            return const UserListViewScreen();
                          },
                        ),
                    child: const Text('Default User List View')),
                ElevatedButton(
                    onPressed: () => showGeneralDialog(
                          context: context,
                          pageBuilder: (_, __, ___) {
                            return const HorizontalUserListViewScreen();
                          },
                        ),
                    child: const Text('Horizontal User List View')),
                ElevatedButton(
                    onPressed: () => showGeneralDialog(
                          context: context,
                          pageBuilder: (_, __, ___) {
                            return const CustomUserListViewScreen();
                          },
                        ),
                    child: const Text('Custom User List View')),
                ElevatedButton(
                  onPressed: () => showGeneralDialog(
                    context: context,
                    pageBuilder: (_, __, ___) {
                      return const CustomComponentUserListViewScreen();
                    },
                  ),
                  child:
                      const Text('Custom Component User List View - Vertical'),
                ),
                ElevatedButton(
                  onPressed: () => showGeneralDialog(
                    context: context,
                    pageBuilder: (_, __, ___) {
                      return const HorizontalCustomComponentUserListViewScreen();
                    },
                  ),
                  child: const Text(
                      'Custom Component User List View - Horizontal'),
                ),
                ElevatedButton(
                  onPressed: () => showGeneralDialog(
                    context: context,
                    pageBuilder: (_, __, ___) {
                      return const ChatRoomListScreen();
                    },
                  ),
                  child: const Text('My chat room list view'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
