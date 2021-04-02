import 'package:flutter_single_app/import_common.dart';

class StaticList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget getItem(String label, int index) {
      double top = index > 1 ? 5 : 10;
      return Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.fromLTRB(10, top, 10, 5),
        decoration: BoxDecoration(
            //背景装饰
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              //卡片阴影
              BoxShadow(
                  color: Colors.black54,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0)
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipOval(
                child: Image.asset("assets/images/zz.png", fit: BoxFit.fill)),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Text(
                '可惜没有如果',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(fontSize: 14),
              ),
            ),
            Text(
              '20221-03-30',
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      );
    }

    getList() {
      List arr = [
        '应该还来得及去悔过，假如没把一切说破',
        '那一场小风波 将一笑带过',
        '在感情面前 讲什么自我',
        '要得过且过 才好过，全都怪我',
        '不该沉默时沉默 该勇敢时软弱',
        '误会自己洒脱 让我们难过',
        '可当初的你 和现在的我',
        '假如重来过，倘若那天',
        '把该说的话好好说，该体谅的不执着',
        '如果那天我，不受情绪挑拨',
        '你会怎么做，那么多如果 可能如果我',
        '可惜没如果 只剩下结果，如果早点了解',
        '那率性的你，或者晚一点',
        '遇上成熟的我，不过 oh',
      ];
      int i = 0;
      return arr.map((v) {
        i++;
        return getItem(v, i);
      }).toList();
    }

    return Expanded(
        child: Container(
      color: hex('#ebeef5'),
      child: ListView(
        children: getList(),
      ),
    ));
  }
}
