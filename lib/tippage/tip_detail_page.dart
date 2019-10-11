import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hctodo/model/hctd.dart';

class TipDetailWidget extends StatelessWidget{
  final Tip tip;
  const TipDetailWidget(this.tip);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(tip.title),
      ),
      child: SafeArea(child: Markdown(data: tip.content,)),
    );
  }
}