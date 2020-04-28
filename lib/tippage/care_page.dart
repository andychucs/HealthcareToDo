import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets.dart';

class CarePage extends StatelessWidget {
  final String path = 'api/getfile/care';
  final String type = 'care';
  final String title = '护理小贴士';
  @override
  Widget build(BuildContext context) {
    return buildTipCupertinoPageScaffold(path,type,title);
  }
}

