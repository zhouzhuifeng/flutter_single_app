import '../../import_common.dart';

class ThemeChangeRoute extends StatefulWidget {
  @override
  _ThemeChangeRoute createState() => _ThemeChangeRoute();
}

class _ThemeChangeRoute extends State<ThemeChangeRoute> {
  @override
  Widget build(BuildContext context) {
    print(
        '-----------------------------================ ${Provider.of<ThemeModel>(context, listen: true).theme}  aa');
    List<Widget> arr = Global.themes.map<Widget>((e) {
      return Consumer<ThemeModel>(
        // builder 3个参数， context ，model，child
        builder: (context, ThemeModel themeModel, child) => GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
            child: Container(
              color: e,
              height: 40,
            ),
          ),
          onTap: () {
            //主题更新后，MaterialApp会重新build
            themeModel.theme = e;
          },
        ),
      );
    }).toList();

    arr.add(Padding(
      padding: EdgeInsets.all(30),
      child: ElevatedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(0, 60)),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          '返回',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    ));
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('主题色'),
          // automaticallyImplyLeading: false,
          // actions: <Widget>[
          //   new IconButton( // action button
          //     padding: EdgeInsets.only(right: 20),
          //     icon: new Icon(Icons.person),
          //     onPressed: (){
          //     //  print('33333333')
          //     },
          //   ),
          // ],
        ),
        body: ListView(children: arr)
        //显示主题色块

        //  ListView(
        //  Global.themes.map<Widget>((e) {
        //   return GestureDetector(
        //     child: Padding(
        //       padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        //       child: Container(
        //         color: e,
        //         height: 40,
        //       ),
        //     ),
        //     onTap: () {
        //       //主题更新后，MaterialApp会重新build
        //       print(Provider.of<UserModel>(context, listen: true).user);
        //       print(Provider.of<ThemeModel>(context, listen: true).theme);
        //       Provider.of<ThemeModel>(context, listen: true).theme = e;
        //       print(Provider.of<ThemeModel>(context, listen: true).theme);
        //     },
        //   );
        // }).toList(),
        // )
        // Container(234
        //   height: 50.0,
        //   width: 100.0,
        //   color: Colors.green,
        // )
        );
  }
}
