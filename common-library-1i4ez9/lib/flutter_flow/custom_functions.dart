import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';

String? getFirstUrl(String? text) {
  /// Returns the first URL in the given text.
  /// The URL must start with 'http' or 'https'.
  /// If no URL is found, returns null.
  if (text == null) return null;
  final RegExp urlRegex = RegExp(r'https?:\/\/\S+');
  final Match? match = urlRegex.firstMatch(text);
  return match?.group(0);
}
