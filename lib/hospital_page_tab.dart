import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hctodo/model/hctd.dart';
import 'package:hctodo/toolpage/tool_page_tab.dart';


class Province {
  int code;
  String name;
  List<String> cities;
  Province({this.code,this.name,this.cities});
}

class Item{
  Hospital hospital;
  bool isExpanded = false;
  
  Item({this.hospital,this.isExpanded});

}

class HospitalPageTab extends ToolPageTab {

  static List<Province> _provinces = [
    Province(name: '北京市',cities: ['朝阳区','海淀区','丰台区','东城区',
        '西城区','昌平区', '宣武区','房山区','崇文区','石景山区','门头沟区','通州区',
        '大兴区','顺义区','怀柔区','密云县','平谷区','延庆县'],code: 11),
    Province(name: '上海市',cities: ['浦东新区','徐汇区','长宁区', '闸北区', '虹口区',
      '杨浦区', '闵行区', '宝山区', '黄浦区', '奉贤区', '静安区', '卢湾区', '普陀区',
      '崇明县', '青浦区', '嘉定区', '金山区', '松江区'],code: 31),
    Province(name: '福建省',cities: ['福州市', '泉州市', '南平市', '厦门市',
      '漳州市', '三明市', '龙岩市', '莆田市', '宁德市'],code: 35),
    Province(name: '甘肃省',cities: ['兰州市', '天水市', '陇南地区', '平凉市',
      '定西地区', '庆阳市', '武威市', '酒泉市', '白银市', '张掖市', '临夏回族自治州',
      '甘南藏族自治州', '金昌市', '嘉峪关市'],code: 62),
    Province(name: '重庆市',code: 50,cities: ['未定义']),
    Province(name: '天津市',code: 12,cities: ['未定义']),
    Province(name: '河南省',code: 41,cities: ['未定义']),
    Province(name: '湖北省',code: 42,cities: ['未定义']),
    Province(name: '安徽省',code: 34,cities: ['未定义']),
    Province(name: '新疆维吾尔自治区',code: 65,cities: ['未定义']),
    Province(name: '江苏省',code: 32,cities: ['未定义']),
    Province(name: '广东省',code: 44,cities: ['未定义']),
    Province(name: '山东省',code: 37,cities: ['未定义']),
    Province(name: '辽宁省',code: 21,cities: ['未定义']),
    Province(name: '河北省',code: 13,cities: ['未定义']),
    Province(name: '四川省',code: 51,cities: ['未定义']),
    Province(name: '黑龙江省',code: 23,cities: ['未定义']),
    Province(name: '山西省',code: 14,cities: ['未定义']),
    Province(name: '湖南省',code: 43,cities: ['未定义']),
    Province(name: '陕西省',code: 61,cities: ['未定义']),
    Province(name: '浙江省',code: 33,cities: ['未定义']),
    Province(name: '云南省',code: 53,cities: ['未定义']),
    Province(name: '吉林省',code: 22,cities: ['未定义']),
    Province(name: '广西壮族自治区',code: 45,cities: ['未定义']),
    Province(name: '江西省',code: 36,cities: ['未定义']),
    Province(name: '内蒙古自治区',code: 15,cities: ['未定义']),
    Province(name: '贵州省',code: 52,cities: ['未定义']),
    Province(name: '海南省',code: 46,cities: ['未定义']),
    Province(name: '青海省',code: 63,cities: ['未定义']),
    Province(name: '宁夏回族自治区',code: 64,cities: ['未定义']),
    Province(name: '西藏自治区',code: 54,cities: ['未定义']),
  ];

  final String title = '医院信息库';

  final List<String> items = [for(var i in _provinces) i.name];


}

class ProvinceHospital extends StatefulWidget{
  final name;

  final rank = '三级';

  const ProvinceHospital({Key key, this.name}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProvinceHospital();
}

class _ProvinceHospital extends State<ProvinceHospital>{

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.grey[200],
      child: FutureBuilder(
        future: fetchPosy('hospital?province=${widget.name}&rank=${widget.rank}'),
        builder: (context,snapshot){
//          print('data:${snapshot.data}');
//          print('connectionState:${snapshot.connectionState}');
          if(snapshot.hasData){
            var hospitalsJson = snapshot.data;
            final jsonMap = json.decode(hospitalsJson);
            Hospitals hospitalList = Hospitals.fromJson(jsonMap);
//            print('content:${hospitalList.hospitals.length}');
            List<Item> items = [for(var i in hospitalList.hospitals) Item(hospital: i,isExpanded: false)];
            return CustomScrollView(
                    slivers: <Widget>[
                      CupertinoSliverNavigationBar(
                        largeTitle: Text(widget.name),
                      ),
                      SliverSafeArea(
                        top: false,
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (BuildContext context, int index){
                              return Padding(
                                padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
                                child: hospitalCard(items[index].hospital, context),
                              );
                            },
                            childCount: items.length,
                          ),
                        ),
                      ),
                    ],
                  );
          } else if(snapshot.hasError){
            return Text(snapshot.error);
          }
          return Center(child: CupertinoActivityIndicator());
        },
      ),
    );

  }
}

class HospitalDetail extends StatelessWidget{
  final Hospital data;

  const HospitalDetail({Key key, this.data}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(data.name),
      ),
      child: SafeArea(child: Markdown(data: data.toMarkdown()),),
    );
  }

}

class HospitalSearch extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HospitalSearch();

}

class _HospitalSearch extends State<HospitalSearch>{
  TextEditingController _textController;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return CupertinoPageScaffold(
        backgroundColor: Colors.grey[200],
        navigationBar: CupertinoNavigationBar(
          middle: Text('医院查询'),
        ),
        child: SafeArea(
          child: Center(
            child: Card(
              color: Colors.white,
              child: Container(
                height: 500,
                width: 300,
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 200,
                      child: CupertinoTextField(
                        controller: _textController,
                        placeholder: '输入医院名',
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        CupertinoButton(
                          color: Colors.blueAccent,
                          child: Text('省份'),
                          onPressed: null,
                        ),
                        CupertinoButton(color: Colors.blueAccent,child: Text('城市'), onPressed: null),
                        CupertinoButton(color: Colors.blueAccent,child: Text('等级'), onPressed: null),
                      ],
                    ),
                    CupertinoButton(color: Colors.blueAccent,child: Text('查询'), onPressed: null),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}

Card hospitalCard(Hospital data,BuildContext context) => Card(
  child: InkWell(
    splashColor: Colors.blue.withAlpha(30),
    onTap: () {
      Navigator.of(context).push(CupertinoPageRoute(builder: (context){
        return HospitalDetail(data: data,);
      }));
    },
    child: Container(
      width: 300,
      height: 80,
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Center(
            child: Text(
              data.name,
              style: TextStyle(fontSize: 20),
            )),
      ),
    ),
  ),
);