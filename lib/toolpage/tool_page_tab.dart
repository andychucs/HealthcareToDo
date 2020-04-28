

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

class ToolPageTab extends StatelessWidget{
  final String title = '工具箱';
  final List<String> items = ['医保报销计算器','时间块模式待办事项'];


  @override
  Widget build(BuildContext context) {
    return buildTabPageScaffold(context,title,items);
  }


}