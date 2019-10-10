import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class TipsPageTab extends StatelessWidget {
  Future<String> loadAsset(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/tips.md');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAsset(context),
      builder: (context, snapshot) {
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('小贴士'),
          ),
          child: SafeArea(
            child: Container(
              child: Markdown(
                data: snapshot.data,
              ),
            ),
          ),
        );
      },
    );
  }
//      CupertinoPageScaffold(
//      navigationBar: CupertinoNavigationBar(
//        middle: Text('小贴士'),
//      ),
//      child: FutureBuilder(
//        future: loadAsset(context),
//        builder: (context,snapshot){
//          return Padding(
//            padding: const EdgeInsets.only(top:70.0),
//            child: Markdown(data: snapshot.data,),
//          );
//        },
//      )
//      Markdown(data: _markdownData,)
//    );
}
