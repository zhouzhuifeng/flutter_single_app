import '../../import_common.dart';

class StaticList extends StatefulWidget {
  final int currrentNum;
  StaticList(this.currrentNum);
  @override
  _StaticList createState() => _StaticList(currrentNum);
}

class _StaticList extends State<StaticList> {
  final int currrentNum;
  _StaticList(this.currrentNum);
  ScrollController _controller;
  bool isToTop = false;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(() {
      // print('_controller.offset   ${_controller.offset}');
      //为控制器注册滚动监听方法
      if (_controller.offset > 200) {
        //如果ListView已经向下滚动了1000，则启用Top按钮
        setState(() {
          isToTop = true;
          // print(isToTop);
        });
      } else if (_controller.offset < 80) {
        //如果ListView向下滚动距离不足300，则禁用Top按钮
        setState(() {
          isToTop = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color iscolor = Provider.of<ThemeModel>(context).theme;
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
      '把该说的话好好说，该体谅的不执着',
      '如果那天我，不受情绪挑拨',
      '你会怎么做，那么多如果 可能如果我',
      '可惜没如果 只剩下结果，如果早点了解',
      '那率性的你，或者晚一点',
      '遇上成熟的我，不过 oh',
    ];

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
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(
                left: 8.0,
              ),
              child: Text(
                label,
                style: TextStyle(fontSize: 12.0),
              ),
            )),
            Text(
              '2021-03-30',
              style: TextStyle(color: Colors.black54, fontSize: 12.0),
            )
          ],
        ),
      );
    }

    List<Widget> getList() {
      int i = 0;
      return arr.map((v) {
        i++;
        return getItem(v, i);
      }).toList();
    }

    // ListView.builder
    Widget isBuilderList() {
      return Expanded(
          child: ListView.builder(
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              controller: _controller,
              itemExtent: 50.0,
              itemCount: arr.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                  leading: Icon(
                    index % 2 == 0 ? Icons.music_note : Icons.queue_music,
                    color: iscolor,
                  ),
                  title: Text(
                    arr[index],
                    style: TextStyle(
                        color: index == 0 ? Colors.red : Colors.black),
                  ),
                  trailing: Icon(
                    Icons.headset_mic_sharp,
                    color: iscolor,
                  ),
                  // subtitle: Text('zz'),
                  onTap: () => print('ListView.builder'))));
    }

    // ListView.separated
    Widget isSeparated() {
      return ListView.separated(
          itemBuilder: (BuildContext context, int index) =>
              ListTile(title: Text(arr[index])),
          separatorBuilder: (BuildContext context, int index) => index % 2 == 0
              ? Divider(color: Colors.green)
              : Divider(
                  color: Colors.red,
                ),
          itemCount: arr.length);
    }

    Map obj = {
      1: Expanded(
          child: Container(
        color: hex('#ebeef5'),
        child: ListView(children: getList()),
      )),
      2: Column(
        children: [
          isBuilderList(),
          Offstage(
              offstage: !isToTop, //这里控制 true  false 布尔值
              child: FloatingActionButton(
                onPressed: (isToTop
                    ? () {
                        if (isToTop) {
                          _controller.animateTo(.0,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.ease); //做一个滚动到顶部的动画
                        }
                      }
                    : null),
                child: Text("Top"),
              )),
        ],
      ),
      3:isSeparated()
    };
    //1  ListView
    // if (currrentNum == 1) {
    //   curr = Expanded(
    //       child: Container(
    //     color: hex('#ebeef5'),
    //     child: ListView(children: getList()),
    //   ));
    // } else {
    //   curr = Column(
    //     children: [
    //       isBuilderList(),
    //       Offstage(
    //           offstage: !isToTop, //这里控制 true  false 布尔值
    //           child: FloatingActionButton(
    //             onPressed: (isToTop
    //                 ? () {
    //                     if (isToTop) {
    //                       _controller.animateTo(.0,
    //                           duration: Duration(milliseconds: 200),
    //                           curve: Curves.ease); //做一个滚动到顶部的动画
    //                     }
    //                   }
    //                 : null),
    //             child: Text("Top"),
    //           )),
    //     ],
    //   );

    //   // 2.ListView.builder

    // }
    return obj[currrentNum];
    // 回到顶部
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
