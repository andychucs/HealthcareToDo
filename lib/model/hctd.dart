import 'package:event_tool/model/event.dart';
import 'package:http/http.dart' as http;
import 'package:hctodo/config.dart' as config;

class Tip {
  String title;
  String content;
  String type;

  Tip({this.title, this.type, this.content});

  factory Tip.fromJson(Map<String, dynamic> json){
    return Tip(title: json['title'],type: json['type'],content: json['content']);
  }
}

class TipFiles{
  String type;
  int num;
  List<dynamic> filename;

  TipFiles({this.type,this.num,this.filename});

  factory TipFiles.fromJson(Map<dynamic, dynamic> json){
    return TipFiles(type: json['type'],num: json['num'],filename: json['filename']);
  }

}

List<String> eventName = <String>['翻身', '用药', '擦身', '便溺','漱口', '换衣','放风','用餐','点滴检查','体温测量','雾化'];
List<String> customEventName = <String>[];
List<DateTime> customStartTime = <DateTime>[];
List<DateTime> customEndTime = <DateTime>[];

class CustomEvent{
  String name;
  int count,timeInterval,timeConsuming;
  DateTime startTime;

  CustomEvent({this.name,this.count,this.startTime,this.timeConsuming,this.timeInterval});
}

List<Event> customEventList = <Event>[];

class DefaultEvent{
  String name;
  int count,timeInterval,timeConsuming;
  DateTime startTime;

  DefaultEvent({this.name,this.count,this.startTime,this.timeConsuming,this.timeInterval});
}

List<DefaultEvent> getDefaultEvent(){
  return [
  DefaultEvent(name: '翻身',count: 7,startTime: getTodayTime('08:50'),timeConsuming: 5,timeInterval: 120),
  DefaultEvent(name: '用药',count: 3,startTime: getTodayTime('08:30'),timeConsuming: 5,timeInterval: 300),
  DefaultEvent(name: '擦身',count: 3,startTime: DateTime.now(),timeConsuming: 15,timeInterval: 2880),
  DefaultEvent(name: '便溺',count: 3,startTime: getTodayTime('09:00'),timeConsuming: 15,timeInterval: 300),
  DefaultEvent(name: '漱口',count: 2,startTime: getTodayTime('07:30'),timeConsuming: 5,timeInterval: 840),
  DefaultEvent(name: '换衣',count: 2,startTime: DateTime.now(),timeConsuming: 10,timeInterval: 4320),
  DefaultEvent(name: '放风',count: 7,startTime: getTodayTime('16:00'),timeConsuming: 60,timeInterval: 1440),
  DefaultEvent(name: '用餐',count: 3,startTime: getTodayTime('08:00'),timeConsuming: 20,timeInterval: 300),
  DefaultEvent(name: '点滴检查',count: 12,startTime: DateTime.now(),timeConsuming: 1,timeInterval: 15),
  DefaultEvent(name: '体温测量',count: 15,startTime: getTodayTime('07:20'),timeConsuming: 5,timeInterval: 60),
  DefaultEvent(name: '雾化',count: 4,startTime: getTodayTime('09:30'),timeConsuming: 20,timeInterval: 180),
//  DefaultEvent(name: ,count: ,startTime: ,timeConsuming: ,timeInterval: ),
//  DefaultEvent(name: ,count: ,startTime: ,timeConsuming: ,timeInterval: ),
  ];
}

DateTime getTodayTime(String hourMinutes){
  return DateTime.parse(DateTime.now().toString().split(' ')[0]+' '+'$hourMinutes:00.000000');
}

Future fetchPosy(path) async{
  var url = config.IPUrl + path;
  print(url);
  final response = await http.get(url);
  return response.body.toString();
}