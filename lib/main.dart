import 'import_common.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
import './pages/login/index.dart';
import './pages/login/register.dart';
import './pages/home/index.dart';
// import './pages/theme/index.dart';

void main() => Global.init().then((e) => runApp(MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeModel()),
        ChangeNotifierProvider.value(value: UserModel()),
        // ChangeNotifierProvider.value(value: LocaleModel()),
      ],
      child: Consumer<ThemeModel>(
        builder: (BuildContext context, themeModel, Widget child) {
          print(Provider.of<ThemeModel>(context, listen: false).theme);
          print('Provider.of<ThemeModel>(context, listen: false).theme');
          return MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light, //明暗模式为暗色
              primarySwatch: themeModel.theme,
            ),
            title: '可惜没有如果',
            // onGenerateTitle: (context) {324
            //   return '可惜没有如果';
            // },
            // home: HomeRoute(),
            // 注册路由表
            routes: <String, WidgetBuilder>{
              "/": (context) => HomeRoute(),
              "login": (context) => LoginRoute(),
              "register": (context) => RegisterRoute(),
            //   "themes": (context) => ThemeChangeRoute(),
            },
          );
        },
      ),
    );
  }
}
