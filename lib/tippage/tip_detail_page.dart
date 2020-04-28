import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hctodo/model/hctd.dart';

class TipDetailWidget extends StatelessWidget{
  final String filename;
  final String type;
  const TipDetailWidget(this.filename, this.type);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(filename.toString().substring(0,filename.toString().length - 3)),
      ),
      child: FutureBuilder(
        future: fetchPosy('api/tips/$type/$filename'),
        builder: (context,snapshot){
          print('data:${snapshot.data}');
          print('connectionState:${snapshot.connectionState}');
          if(snapshot.hasData){
            var tipJson = snapshot.data;
            final jsonMap = json.decode(tipJson);
            Tip tip = Tip.fromJson(jsonMap);
            print('content:${tip.content}');
            return SafeArea(child: Markdown(data: tip.content,));
          } else if(snapshot.hasError){
            return Text(snapshot.error);
          }
          return CupertinoPageScaffold(
              child: Center(child: CupertinoActivityIndicator())
          );
        },
      ),
    );
  }
}
