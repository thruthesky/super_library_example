import 'package:common_library/custom_code/widgets/index.dart';
import 'package:flutter/material.dart';

class CommonSafeAreaScreen extends StatefulWidget {
  static const String routeName = '/CommonSafeArea';
  const CommonSafeAreaScreen({super.key});

  @override
  State<CommonSafeAreaScreen> createState() => _CommonSafeAreaScreenState();
}

class _CommonSafeAreaScreenState extends State<CommonSafeAreaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CommonSafeArea'),
      ),
      body: SafeArea(
        top: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('CommonSafeArea'),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
              const SafeBottomArea(),
            ],
          ),
        ),
      ),
    );
  }
}
