import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets.dart';

class AidPage extends StatelessWidget {
  final String path = 'api/getfile/aid';
  final String type = 'aid';
  final String title = '急救知识';
  @override
  Widget build(BuildContext context) {
    return buildTipCupertinoPageScaffold(path,type,title);
  }

}

