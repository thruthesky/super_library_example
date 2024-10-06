import 'package:flutter/material.dart';
import 'package:super_example/firebase_options.dart';
import 'package:super_library/custom_code/actions/index.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:super_library/custom_code/actions/super_library.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SuperLibrary.instance.init(
    databaseURL: 'https://withcenter-test-4-default-rtdb.firebaseio.com',
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
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Super Library'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ValueListView(
                    query: ChatService.instance.messagesRef('roomId'),
                    builder: (snapshot, fetchMore) {
                      return ListView.separated(
                        itemCount: snapshot.docs.length,
                        separatorBuilder: (context, index) => const Divider(),
                        itemBuilder: (context, index) {
                          fetchMore(index);
                          final DataSnapshot doc = snapshot.docs[index];

                          return ListTile(
                            title: Text(doc.key!),
                            subtitle: Text(doc.value.toString()),
                          );
                        },
                      );
                    }),
              ),
              TextField(
                controller: textController,
                decoration: const InputDecoration(
                  hintText: 'Enter message',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await chatSendMessage(
                    'senderUid',
                    'receiverUid',
                    'roomId',
                    textController.text,
                  );
                },
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
