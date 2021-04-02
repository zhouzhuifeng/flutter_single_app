import '../../import_common.dart';
import 'widget_details.dart';

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GestureDetector homeIcons(IconData icon, String label, routeName) {
      Color color = Theme.of(context).primaryColor;
      return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
            border:
                Border.all(color: color, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10.0),
          ), // 圆
          width: 80.0,
          height: 80.0,
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color),
              Container(
                // margin: const EdgeInsets.only(top: 8.0),
                child: Text(
                  label,
                  style: TextStyle(
                      fontWeight: FontWeight.w400, color: hex('#000000')),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          List arr = ['ListView'];
          if (arr.contains(label)) {
            return Navigator.pushNamed(context, 'listView');
          }
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Details(label)));
        },
      );
    }

    buildRowChildren() {
      const List list = [
        {'label': 'ListView', 'routeName': 'listView', 'icon': Icons.apps},
        {'label': 'Container', 'routeName': '', 'icon': Icons.alarm},
        {'label': 'Text', 'routeName': '', 'icon': Icons.account_box},
        {'label': 'Center', 'routeName': '', 'icon': Icons.ac_unit},
        {'label': 'Flex', 'routeName': '', 'icon': Icons.access_alarms_rounded},
        {
          'label': 'wrap',
          'routeName': '',
          'icon': Icons.accessible,
        },
        {
          'label': 'Row',
          'routeName': '',
          'icon': Icons.airline_seat_legroom_normal
        },
        {'label': 'Column', 'routeName': '', 'icon': Icons.add_ic_call},
        {'label': 'Expanded', 'routeName': '', 'icon': Icons.accessibility},
        {'label': 'Pading', 'routeName': '', 'icon': Icons.ac_unit_sharp},
        {
          'label': 'ConstrainedBox',
          'routeName': '',
          'icon': Icons.accessible_sharp
        },
        {
          'label': 'BoxConstraints',
          'routeName': '',
          'icon': Icons.accessibility
        },
        {'label': 'Align', 'routeName': '', 'icon': Icons.add_call},
        {'label': 'SizedBox', 'routeName': '', 'icon': Icons.account_balance},
        {
          'label': 'Stack',
          'routeName': '',
          'icon': Icons.account_balance_wallet_outlined
        },
        {
          'label': 'Positioned',
          'routeName': '',
          'icon': Icons.account_box_rounded
        },
        {'label': 'Clip', 'routeName': '', 'icon': Icons.add},
      ];
      List<Widget> arr = [];
      list.forEach((val) {
        final label = val['label'];
        final routeName = val['routeName'];
        final icon = val['icon'];
        arr.add(homeIcons(icon, label, routeName));
      });

      return SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(20.0),
            child: Wrap(
              //水平间距
              spacing: 20.0,
              //垂直间距
              runSpacing: 10.0,
              //对齐方式
              alignment: WrapAlignment.start,
              children: arr,
            )),
      );
    }

    return buildRowChildren();
  }
}
