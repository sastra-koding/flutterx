import 'package:flutter/material.dart';
import 'package:flutterx/app_localization.dart';

// Translate function
String t(BuildContext context, String key) {
  return AppLocalizations.of(context)!.translate(key);
}
