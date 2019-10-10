import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hctodo/generated/i18n.dart';
import 'app.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:ui' as ui;

void main() {
//  final _sysLng = ui.window.locale.languageCode;
//  print(_sysLng);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  return runApp(CupertinoApp(
      localizationsDelegates: [
        S.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      localeResolutionCallback:
          S.delegate.resolution(fallback: new Locale("zh", "CN")),
      home: MyApp()));
}
