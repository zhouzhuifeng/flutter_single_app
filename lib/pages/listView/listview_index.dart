import '../../import_common.dart';
import './listview.dart';
import './scrolltview.dart';

class ListContainer extends StatefulWidget {
  @override
  _ListContainer createState() => _ListContainer();
}

class _ListContainer extends State<ListContainer>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = [
    "ListView",
    "ListView.builder",
    "ListView.Separated",
    "ScrollView",
  ];
  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      //监听滑动或者点击
      print(_tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListContainer'),
        bottom: TabBar(
            isScrollable: true,
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StaticList(1),
          StaticList(2),
          StaticList(3),
          ScrollList(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose(); // 销毁控制器
    super.dispose();
  }
}
