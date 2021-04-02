import '../../import_common.dart';

class Details extends StatefulWidget {
  final String title;
  Details(this.title);
  @override
  _Details createState() => _Details(title);
}

class _Details extends State<Details> {
  final String title;
  _Details(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          '$title 详情页面',
          style: TextStyle(
              fontSize: 18,
              color: Provider.of<ThemeModel>(context, listen: false).theme),
        ),
      ),
    );
  }
}
