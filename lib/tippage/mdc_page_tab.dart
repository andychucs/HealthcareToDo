import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hctodo/model/hctd.dart';
import 'package:hctodo/tippage/tip_detail_page.dart';

class MdcPageTab extends StatelessWidget {
  Future<String> loadAsset(BuildContext context) async {
    return await DefaultAssetBundle.of(context).loadString('assets/tips.md');
  }

  Card makeCard(Tip tip,BuildContext context) => Card(
    child: InkWell(
      splashColor: Colors.blue.withAlpha(30),
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(builder: (context){
          return TipDetailWidget(tip);
        }));
      },
      child: Container(
        width: 300,
        height: 80,
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 8,
                child: Center(
                    child: Text(
                      tip.title,
                      style: TextStyle(fontSize: 20),
                    ))),
            Expanded(flex: 2, child: Icon(CupertinoIcons.forward))
          ],
        ),
      ),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color.fromARGB(150, 220, 220, 220),
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            largeTitle: Text('常见药品'),
          ),
          SliverSafeArea(
            top: false,
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
                    child: makeCard(getTips()[index],context),
                  );},
                childCount: getTips().length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
//navigationBar: CupertinoNavigationBar(
//        middle: Text('常见药品'),
//      ),
//      child: SafeArea(
//        child: ListView.builder(
//            itemCount: getTips().length,
//            itemBuilder: (context, index) {
//              return Padding(
//                padding: const EdgeInsets.only(left: 20,right: 20,top: 5),
//                child: makeCard(getTips()[index],context),
//              );
//            }),
//      ),
List getTips() {
  return [
    Tip(
        title: '阿司匹林',
        type: 'medicine',
        content:
        '''1. 镇痛、解热可缓解轻度或中度的疼痛，如头痛、牙痛、 神经痛、肌肉痛及月经痛，也用于感冒、流感等退热。本品仅能缓解症状，不能治疗引起疼痛、发热的病因，故需同时应用其他药物参因治疗。
2. 消炎、抗风湿阿司匹林为治疗风湿热的首选药物，用药后可解热、减轻炎症，使关节症状好转，血沉下降，但不能去除风湿的基本病理改变，也不能预防心脏损害及其他合并症。如已有明显心肌炎，一般都主张先用肾上腺皮质激素，在风湿症状控制之后、停用激素之前，加用本品治疗，以减少停用激素后引起的反跳现象。
3. 关节炎除风湿性关节炎外， 本品也用于治疗类风湿性关节炎，可改善症状，为进一步治疗创造条件。此外，本品用于骨关节炎、强直性脊椎炎、幼年型关节炎以及其他非风湿性炎症的骨骼肌肉疼痛，也能缓解症状。
4. 抗血栓本品对血小板聚集有抑制作用，阻止血栓形成， 临床可用于预防暂时性脑缺血发作、心肌梗塞、心房颤动、人工心脏瓣膜、动静脉瘘或其他手术后的血栓形成。也可用于治疗不稳定型心绞痛。
5. 皮肤粘膜淋巴结综合症(川崎病)
患川崎病的患儿应用阿斯匹林，目的是减少炎症反应和预防血管内血栓的形成。'''),
    Tip(
        title: '布洛芬',
        type: 'medicine',
        content:
        '''本品的镇痛、抗炎作用机制尚未完全明确，可能是通过抑制前列腺素或其他刺激性弟质的合成而在炎症组织局部发挥作用。本品适用于解热、减轻轻度至中度疼痛，如关节痛、神经痛、肌肉痛、头痛、偏头痛、痛经、牙痛、感冒及流感症状。'''),
    Tip(
        title: '克林霉素',
        type: 'medicine',
        content:
        '''抗菌谱与林可霉素相同。主要用于厌氧菌（包括脆弱拟杆菌、产气荚膜杆菌、放线菌等）引起的腹腔和妇科感染（常需与氨基糖苷类联合以消除需氧病原菌）。还用于敏感的革兰阳性菌引起的呼吸道、关节和软组织、骨组织、胆道等感染及败血症、心内膜炎等。本品是金黄色葡萄球菌骨髓炎的首选治疗药物。'''),
    Tip(
        title: '阿莫西林',
        type: 'medicine',
        content:
        '''抗菌谱与氨苄西林相同，微生物对本品和氨苄西林有完全的交叉耐药性。本品口服吸收良好。服用同量药物，本品的血清药浓度比氨苄西林者高约一倍。 常用于敏感菌 所致的呼吸道、尿路和胆道感染以及伤寒等。'''),
    Tip(
        title: '头孢拉定',
        type: 'medicine',
        content:
        '''抗菌性能类似头孢氨苄，对金黄色葡萄球菌、溶血性链球菌、肺炎链球菌、大肠杆菌、奇异变形杆菌、肺炎克雷白杆菌、流感嗜血杆菌等有抗菌作用。用于呼吸道、泌尿道、皮肤和软组织等部位的敏感菌感染，注射剂也用于败血症和骨感染。'''),
    Tip(
        title: '乙酰螺旋霉素',
        type: 'medicine',
        content:
        '''抗菌谱与红霉素近似，对葡萄球菌、化脓性链球菌、肺炎链球菌、脑膜炎球菌、淋球菌、白喉杆菌、支原体、梅毒螺旋体等有抗菌作用。适用于上述敏感菌所致的扁桃体炎、支气管炎、肺炎、咽炎、中耳炎、皮肤和软组织感染、乳腺炎、胆囊炎、猩红热、牙科和眼科感染等。'''),
    Tip(
        title: '阿奇霉素',
        type: 'medicine',
        content:
        '''本品的抗菌谱与红霉素相近，作用较强，对流感嗜血杆菌、淋球菌的作用比红霉素强4倍；对军团菌强2倍；对绝大多数革兰阴性菌的MIC＜1μg／ml，对梭状芽胞杆菌的作用也比红霉素强，在应用于金黄色葡萄球菌感染中也比红霉素有效。此外，本品对弓形体（Toxoplasma）、梅毒螺旋体也有良好的杀灭作用。本品的口服生物利用度约为40％，分布容积为23L／kg，消除率为10ml／（min·kg），半衰期约41小时，体内的血浓度高于红霉素。临床应用于敏感微生物所致的呼吸道、皮肤和软组织'''),
    Tip(
        title: '谷维素',
        type: 'medicine',
        content: '''用于镇静助眠，如神经官能症、月经前期紧张症、更年期综合征的辅助治疗。 '''),
    Tip(
        title: '那格列奈片',
        type: 'medicine',
        content:
        '''本品可以单独用于经饮食和运动不能有效控制高血糖的2型糖尿病病人。也可用于使用二甲双胍不能有效控制高血糖的2型糖尿病病人，采用与二甲双胍联合应用，但不能替代二甲双胍。'''),
    Tip(
        title: '盐酸氨溴索',
        type: 'medicine',
        content: '''适用于急、慢性呼吸道疾病（如急、慢性支气管炎、支气管哮喘，支气管扩张，肺结核等）引起的痰液粘稠，咳痰困难。'''),
    Tip(
        title: '右旋糖酐铁',
        type: 'medicine',
        content: '''用于明确原因的慢性失血、营养不良、妊娠、儿童发育期等引起的缺铁性贫血。'''),
    Tip(
        title: '拉米夫定（贺普丁）',
        type: 'medicine',
        content: '''适用于乙型肝炎病毒复制的慢性乙型肝炎。 '''),
    Tip(
        title: '硝苯地平片',
        type: 'medicine',
        content: '''1. 心绞痛：变异型心绞痛；不稳定型心绞痛；慢性稳定型心绞痛。
2. 高血压（单独或与其它降压药合用）。'''),
    Tip(
        title: '多潘立酮片',
        type: 'medicine',
        content: '''用于消化不良、腹胀、嗳气、恶心、呕吐、腹部胀痛。'''),
    Tip(
        title: '盐酸环丙沙星片',
        type: 'medicine',
        content:
        '''用于敏感菌引起的 1.泌尿生殖系统感染，包括单纯性、复杂性尿路感染、细菌性前列腺炎、淋病奈瑟菌尿道炎或宫颈炎（包括产酶株所致者）。 2.呼吸道感染，包括敏感革兰阴性杆菌所致支气管感染急性发作及肺部感染。 3.胃肠道感染，由志贺菌属、沙门菌属、产肠毒素大肠埃希菌、亲水气单胞菌、副溶血弧菌等所致。 4.伤寒。 5.骨和关节感染。 6.皮肤软组织感染。 7.败血症等全身感染。 '''),
    Tip(
        title: '枸橼酸莫沙必利片',
        type: 'medicine',
        content:
        '''本品为消化道促动力剂，主要用于功能性消化不良伴有胃灼热、嗳气、恶心、呕吐、早饱、上腹胀等消化道症状；也可用于胃食管反流性疾病、糖尿病性胃轻瘫及部分胃切除患者的胃功能障碍。'''),
    Tip(
        title: '硫酸沙丁胺醇片',
        type: 'medicine',
        content:
        '''用于缓解支气管哮喘或喘息型支气管炎伴有用于缓解过敏性鼻炎有关的症状，如喷嚏、流涕和鼻痒以及眼部瘙痒和烧灼感。也用于缓解慢性荨麻疹及其他过敏性皮肤病的症状。支气管痉挛的病症。'''),
    Tip(
        title: '氯雷他定片',
        type: 'medicine',
        content:
        '''用于缓解过敏性鼻炎有关的症状，如喷嚏、流涕和鼻痒以及眼部瘙痒和烧灼感。也用于缓解慢性荨麻疹及其他过敏性皮肤病的症状。  '''),
    Tip(
        title: '酚麻美敏片（泰诺）',
        type: 'medicine',
        content:
        '''本品具有解热镇痛、消除鼻部充血；镇咳和抗过敏作用，用于感冒和上呼吸道过敏，能缓解因感冒引起的鼻黏膜肿胀、流涕、流泪、打喷嚏、头痛、咽喉痛、发炎、咳嗽等症状。 '''),
    Tip(
        title: '甲硝唑片',
        type: 'medicine',
        content:
        '''用于治疗肠道和肠外阿米巴病（如阿米巴肝脓肿、胸膜阿米巴病等）。还可用于治疗阴道滴虫病、小袋虫病和皮肤利什曼病、麦地那龙线虫感染等。目前还广泛用于厌氧菌感染的治疗。'''),
    Tip(
        title: '阿托品',
        type: 'medicine',
        content:
        '''在临床上的用途主要是：(1)抢救感染中毒性休克：成人每次1～2mg，小儿0.03～0.05mg/kg，静注，每15～30分钟1次，2～3次后如情况不见好转可逐渐增加用量，至情况好转后即减量或停药。(2)治疗锑剂引起的阿-斯综合征：发现严重心律紊乱时，立即静注1～2mg(用5%～25%葡萄糖液10～20ml稀释)，同时肌注或皮下注射1mg，15～30分钟后再静注1mg。如病人无发作，可根据心律及心率情况改为每3～4小时皮下注射或肌注1mg，48小时后如不再发作，可逐渐减量，最后停药。(3)治有机磷农药中毒：①与解磷定等合用时：对中度中毒，每次皮下注射0.5～1mg，隔30～60分钟1次；对严重中毒，每次静注1～2mg，隔15～30分钟一次，至病情稳定后，逐渐减量并改用皮注。②单用时：对轻度中毒，每次皮下注射0.5～1mg，隔30～120分钟1次；对中度中毒，每次皮下注射1～2mg，隔15～30分钟1次；对重度中毒，即刻静注2～5mg，以后每次1～2mg，隔15～30分钟1次，根据病情逐渐减量和延长间隔时间。(4)缓解内脏绞痛：包括胃肠痉挛引起的疼痛、肾绞痛、胆绞痛、胃及十二指肠溃疡，每次皮下注射0.5mg。(5)用为麻醉前给药：皮下注射0.5mg，可减少麻醉过程中支气管粘液分泌，预防术后引起肺炎，并可消除吗啡对呼吸的抑制。(6)用于眼科：可使瞳孔放大，调节功能麻痹，用于角膜炎、虹膜睫状体炎。用1%～3%眼药水滴眼或眼膏涂眼。滴时按住内眦部，以免流入鼻腔吸收中毒。 '''),
    Tip(
        title: '地塞米松片',
        type: 'medicine',
        content:
        '''主要用于过敏性与自身免疫性炎症性疾病。如结缔组织病，严重的支气管哮喘，皮炎等过敏性疾病，溃疡性结肠炎，急性白血病，恶性淋巴瘤等。此外，本药还用于某些肾上腺皮质疾病的诊断——地塞米松抑制试验。'''),
    Tip(
        title: '华素片',
        type: 'medicine',
        content:
        '''慢性咽喉炎、慢性牙周炎、牙龈炎、复发性口腔溃疡、创伤性口腔溃疡、白色念珠菌性口炎和摩烂型扁平苔癣等。慢性口腔溃疡1周为1疗程。慢性咽炎等2～4周为1疗程。'''),
//    Tip(title: '',type: 'medicine',content: ''''''),
//    Tip(title: '看护流程', content: ''''''),
//    Tip(title: '急救的基本物品', content: ''''''),
  ];
}
