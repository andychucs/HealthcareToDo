import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets.dart';

class MdcPage extends StatelessWidget {
  final String path = 'api/getfile/mdc';
  final String type = 'mdc';
  final String title = '常见药品';
  @override
  Widget build(BuildContext context) {
    return buildTipCupertinoPageScaffold(path,type,title);
  }

}

