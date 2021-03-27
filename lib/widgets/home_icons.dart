import '../import_common.dart';

class HomeIcons extends StatelessWidget {
  final IconData icon;
  final String label;
  final String routeName;
  HomeIcons(
    this.label,
    this.icon,
    this.routeName,
  ) : super();
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return GestureDetector(
      child: Container(
        width: 20.0,
        height: 20.0,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            Container(
              // margin: const EdgeInsets.only(top: 8.0),
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () => print("Tap $routeName"),
    );
  }
}
