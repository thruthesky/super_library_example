// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart' hide Text;
import 'package:html/parser.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// A widget that displays a preview of a website.
class SitePreview extends StatefulWidget {
  const SitePreview({
    super.key,
    this.width,
    this.height,
    required this.url,
    this.maxLinesOfDescription,
    this.debug,
    this.displayError,
  });

  final double? width;
  final double? height;
  final String url;
  final int? maxLinesOfDescription;
  final bool? debug;
  final bool? displayError;

  @override
  State<SitePreview> createState() => _SitePreviewState();
}

class _SitePreviewState extends State<SitePreview> {
  String? previewUrl;
  String? siteName;
  String? title;
  String? description;
  String? imageUrl;

  String? previousUrl;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    // debug('--> _SitePreviewState.initState() begins');
  }

  void loadPreview() async {
    errorMessage = null;
    String? firstLink = getFirstUrl(widget.url);
    debug('-> loadPreview() begin with: firstLink: $firstLink');
    if (firstLink == null) {
      debug('firstLink is null');
      return;
    }
    debug('-> firstLink: $firstLink');
    // log('-> firstLink: $firstLink');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString(firstLink);
    // log('-> Using cached data: $data');
    if (data != null) {
      /// [parts] is a list of strings that are separated by '||'
      final List<String> parts = data.split('||');
      if (parts.length == 4) {
        setState(() {
          previewUrl = firstLink;
          siteName = parts[0];
          title = parts[1];
          description = parts[2];
          imageUrl = parts[3];
        });
        return;
      }
    }

    final dio = Dio();
    Response response;
    try {
      response = await dio.get(firstLink);
    } catch (e) {
      debug('dio.get($firstLink) Error: $e');
      errorMessage = e.toString();
      setState(() {});
      rethrow;
    }
    dynamic res = response.data;
    if (res == null) {
      debug('Result from dio.post($firstLink) is null');
      return;
    }
    String html = res.toString();

    final Document doc = parse(html);

    previewUrl = firstLink;
    title = getOGTag(doc, 'og:title') ?? getTag(doc, 'title');
    description =
        getOGTag(doc, 'og:description') ?? getMeta(doc, 'description');
    imageUrl = getOGTag(doc, 'og:image');
    siteName = getOGTag(doc, 'og:site_name') ?? getTag(doc, 'title');

    setState(() {});

    await prefs.setString(
      firstLink,
      '$firstLink||$siteName||$title||$description||$imageUrl',
    );
  }

  @override
  Widget build(BuildContext context) {
    debug('SitePreview.build() with: prev: $previewUrl vs new: ${widget.url}');
    if (previousUrl != widget.url) {
      previousUrl = widget.url;
      loadPreview();
      return const SizedBox.shrink();
    }

    if (errorMessage != null) {
      if (widget.displayError == true)
        return Text(errorMessage!);
      else
        return SizedBox.shrink();
    }

    if (previewUrl == null || previewUrl!.isEmpty) {
      debug('previewUrl is null or empty');
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrlString(previewUrl!)) {
          await launchUrlString(previewUrl!);
        } else {
          throw 'Could not launch $previewUrl';
        }
      },
      child: Container(
        /// [imageUrl] are sometimes smaller than the length of the [description] and leads to
        /// inconsistent design of the [UrlPreview] in [ChatViewScreen] and [ForumChatViewScreen]
        /// [BoxConstraints] to make it a single width and consistent design

        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null && imageUrl!.isNotEmpty) ...[
              CachedNetworkImage(
                imageUrl: imageUrl!,
                // Don't show
                errorWidget: (context, url, error) {
                  debug(
                      "Not showing an image preview because there's a problem with the url: $imageUrl");
                  return const SizedBox.shrink();
                },
              ),
              const SizedBox(height: 8),
            ],
            if (title != null && title!.isNotEmpty) ...[
              Text(
                title!,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (description != null && description!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                description!.length > 100
                    ? '${description!.substring(0, 90)}...'
                    : description!,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade800),
                maxLines: widget.maxLinesOfDescription,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  void debug(String message) {
    if (widget.debug == true) {
      log('[🐶] $message');
    }
  }

  String? getOGTag(Document document, String parameter) {
    final metaTags = document.getElementsByTagName("meta");
    if (metaTags.isEmpty) return null;
    for (var meta in metaTags) {
      if (meta.attributes['property'] == parameter) {
        return meta.attributes['content']?.replaceAll('\n', " ");
      }
    }
    return null;
  }

  String? getTag(Document document, String tag) {
    final metaTags = document.getElementsByTagName(tag);
    if (metaTags.isEmpty) return null;
    for (var meta in metaTags) {
      return meta.text.replaceAll('\n', " ");
    }
    return null;
  }

  String? getMeta(Document document, String parameter) {
    final metaTags = document.getElementsByTagName("meta");
    if (metaTags.isEmpty) return null;
    for (var meta in metaTags) {
      if (meta.attributes['name'] == parameter) {
        return meta.attributes['content']?.replaceAll('\n', " ");
      }
    }
    return null;
  }
}
