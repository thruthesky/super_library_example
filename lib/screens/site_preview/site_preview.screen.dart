import 'package:flutter/material.dart';
import 'package:super_library/custom_code/actions/super_library.dart';

class SitePreviewScreen extends StatefulWidget {
  static const String routeName = '/SitePreview';
  const SitePreviewScreen({super.key});

  @override
  State<SitePreviewScreen> createState() => _SitePreviewScreenState();
}

class _SitePreviewScreenState extends State<SitePreviewScreen> {
  final textController = TextEditingController();

  SitePreviewData? data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SitePreview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text("SitePreview"),
            TextField(
              controller: textController,
            ),
            ElevatedButton(
                onPressed: () async {
                  data = await loadSitePreview(text: textController.text);
                  setState(() {});
                },
                child: Text("Submit")),
            SizedBox(height: 20),
            if (data != null)
              SitePreview(
                data: data!,
              ),
          ],
        ),
      ),
    );
  }
}
