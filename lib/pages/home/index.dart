import '../../import_common.dart';
import './flutter_widget.dart';
import './scroll_controller.dart';
import './scroll_notification.dart';
import './dranwer.dart';
import '../login/index.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  get controller => null;

  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserModel>(context);
    Color color = Theme.of(context).primaryColor;
    if (!userModel.isLogin) {
      return LoginRoute();
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('可惜没有如果'),
        ),
        body: _buildBody(color),
        drawer: MyDrawer(), //抽屉菜单
      );
    }
  }

  Widget _buildBody(color) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        // appBar: new AppBar(
        //   title: new Text('Welcome to Flutter1'),
        // ),
        body: TabBarView(
          children: [
            HomeList(),
            ScrollNotificationWidget(),
            ScrollControllerWidget(),
          ],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: "主页",
            ),
            Tab(
              icon: Icon(Icons.rss_feed),
              text: "Notification",
            ),
            Tab(
              icon: Icon(Icons.perm_identity),
              text: "Controller",
            )
          ],
          onTap: (i) => print('$i --- onTap'),
          unselectedLabelColor: Colors.blueGrey,
          labelColor: color,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Colors.red,
        ),
      ),
    );
  }
}
