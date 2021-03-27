import '../../import_common.dart';

class ScrollNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Scroll Notification Demo',
        home: Scaffold(
            // appBar: AppBar(title: Text('ScrollController Demo')),
            body: NotificationListener<ScrollNotification>(
              // 添加 NotificationListener 作为父容器
              onNotification: (scrollNotification) {
                // 注册通知回调
                if (scrollNotification is ScrollStartNotification) {
                  // 滚动开始
                  print('Scroll Start');
                } else if (scrollNotification is ScrollUpdateNotification) {
                  // 滚动位置更新
                  print('Scroll Update');
                } else if (scrollNotification is ScrollEndNotification) {
                  // 滚动结束
                  print('Scroll End');
                }
                return true;
              },
              child: ListView.builder(
                itemCount: 30, // 列表元素个数
                itemBuilder: (context, index) =>
                    ListTile(title: Text("Index : $index")), // 列表项创建方法
              ),
            )));
  }
}