import 'package:flutter/cupertino.dart';
import 'package:event_tool/model/event.dart';
import 'package:event_tool/event_tool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePageTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Event event = Event(
      title: 'An event',
      notes: 'from Even Tool',
      location: 'your position',
      startDate: DateTime.now().add(Duration(minutes: 6)),
      endDate: DateTime.now().add(Duration(minutes: 7)),
      allDay: false,
      alarmBefore: 5,
    );

    event.title = 'TEST';

    final List<String> entries = <String>['A', 'B', 'C'];
    final List<int> colorCodes = <int>[600, 500, 100];

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('看护宝'),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top:64.0,bottom: 64.0),
        child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                key: ValueKey(index),
                actionPane: SlidableDrawerActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    caption: '创建',
                    color: Colors.orangeAccent,
                    icon: CupertinoIcons.share_up,
                    onTap: ()=> EventTool.addEvent(event).then((success) {showEventDialog(context, success);})
                  )],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: '删除',
                    color: Colors.red,
                    icon: CupertinoIcons.delete,
                  )
                ],
                dismissal: SlidableDismissal(
                  child: SlidableDrawerDismissal(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(child: Text('Entry ${entries[index]}')),
                ),
              );
            }
        ),
      )
    );
  }
}

void showEventDialog(BuildContext context, bool returnStatus) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text('Test event'),
        content: Text(returnStatus ? 'Success' : 'Error'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
//Container(
//child: Padding(
//padding: const EdgeInsets.all(8.0),
//child: Center(
//child: CupertinoButton(
//child: Text('Try add event to calendar'),
////                color: Colors.orangeAccent,
//onPressed: () {
//EventTool.addEvent(event).then((success) {
//showEventDialog(context, success);
//});
//},
//)),
//),
//),