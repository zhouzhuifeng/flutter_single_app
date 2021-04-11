# flutter_single_app

### 开发工具

`Visual studio`

### 创建一个项目

`ctrl` + `shift` + `p` , 输入 `flutter` , 选择 `new application project`

### 启动项目

`flutter run`

### 打包 Android apk

`flutter build apk`

### 新建目录

-   `common` 一些工具类，如通用方法类、网络接口类、保存全局变量的静态类等
-   `models Json` 文件对应的 `Dart Model` 类会在此目录下
-   `states` 保存 `APP` 中需要跨组件共享的状态类
-   `pages` 存放所有路由页面类
-   `widgets APP` 内封装的一些 `Widget` 组件都在该目录下

#### flutter2.0 打包 apk 、连接手机调试报错

-   下载 `gradle-6.7-all.zip`文件到本地([下载地址](https://services.gradle.org/distributions/))，这里用` 6.7-all` 版本，我这里放在 D:\gradle\gradle-6.7-all.zip
-   打开 `android\gradle\wrapper\gradle-wrapper.properties` 文件，修改 `distributionUrl=https\://services.gradle.org/distributions/gradle-6.7-all.zip` 为 `distributionUrl=file\:///D:/gradle/gradle-6.7-all.zip`

### flutter 配置文件

#### 静态资源配置

列如静态资源都放在 assets 文件里, 在 pubspec.yaml 配置如下

```yaml
flutter:
  assets:

    - assets/background.jpg #挨个指定资源路径
    - assets/loading.gif #挨个指定资源路径
    - assets/result.json #挨个指定资源路径
    - assets/icons/ #子目录批量指定
    - assets/ #根目录也是可以批量指定的

    # 需要注意的是，目录批量指定并不递归，只有在该目录下的文件才可 以被包括，如果下面还有子目录的话，需要单独声明子目录下的文件。

   #对于其他资源文件的加载，我们可以通过Flutter应用的主资源Bundle 对象rootBundle，来直接访问。
   #获取result.json文件，并将其打印的过程：
    rootBundle.loadString('assets/result.json').then((msg)=>print(msg))
```

#### 第三方组件引用

[futter 包地址](https://pub.dev/packages?q=english_words)

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.0
# 自动安装 date_format
  date_format: 1.0.6
  #路径依赖
  package1:
    path: ../package1/
  date_format:
  #git依赖
   git:url: https://github.com/xxx/package2.git
```

`date_format` 包引用

```dart
import 'package:date_format/date_format.dart';
print(formatDate(DateTime(1989, 02, 21), [yyyy, '-', mm, '-', dd]));
```

#### json 序列化 Dart Model 类

#### 依赖

```yaml
dependencies:
    # Your other regular dependencies here
    json_annotation: ^4.0.0

dev_dependencies:
    # Your other dev_dependencies here
    build_runner: ^1.0.0
    json_serializable: ^4.0.0
```

#### 一次性生成

通过在我们的项目根目录下运行 `flutter packages pub run build_runner build`

#### 持续生成

使用 `_watcher_` 可以使我们的源代码生成的过程更加方便。它会监视我们项目中文件的变化，并在需要时自动构建必要的文件，我们可以通过 `flutter packages pub run build_runner watch` 在项目根目录下运行来启动 `_watcher_`

### flutter 入口

```dart

  //Material apps
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter1'),
        ),
        body: new Icon(Icons.star,color: Colors.red[500],),
      ),
    );
  }

// 非 Material apps 不包含 AppBar、标题和背景颜色-->
 Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Center(
        child: Text(
          'Hello World',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black87,
          ),
        ),
      ),
    );

//样式
new Text(
          'text',
          // 控制超出一行 ...
           maxLines: 1,
           overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.grey[500]);,
        ),

// 图片
 Widget img = Image.asset(
      'images/zz.png',
      width: 600.0,
      height: 240.0,
      fit: BoxFit.cover,
    );

 <!-- icon图标 -->
   Widget icon= Icon(
        Icons.star,
        color: Colors.red[500],
      ),

// Container
   //一个 child 属性，如果它们只包含一个子项 —— 例如 Center 和 Container
  Widget Container=  new Container(
      padding: const EdgeInsets.all(32.0),
      child: new Text('zz', softWrap: true,),
      )

   //一个 children 属性，如果它们包含多个子项 —— 例如 Row、Column、ListView 和 Stack
   Widget buttonSection = new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly, // 对齐方式 均匀分布
        children: [
          buildButtonColumn(Icons.call, 'CALL'),
          buildButtonColumn(Icons.near_me, 'ROUTE'),
          buildButtonColumn(Icons.share, 'SHARE'),
        ],
      ),
    );
```

#### State

State 初始化时会依次执行 ：构造方法 -> initState -> didChangeDependencies -> build，随后完成页面渲染。

-   构造方法是 State 生命周期的起点，Flutter 会通过调用 StatefulWidget.createState() 来创建一个 State。我们可以通过构造方法，来接收父 Widget 传递的初始化 UI 配置数据。这些配置数据，决 定了 Widget 最初的呈现效果。
-   initState，会在 State 对象被插入视图树的时候调用。这个函数在 State 的生命周期中只会被调用一次，所以我们可以在这里做一些初 始化工作，比如为状态变量设定默认值。
-   didChangeDependencies 则用来专门处理 State 对象依赖关系变化，会 在 initState() 调用结束后，被 Flutter 调用。
-   build，作用是构建视图。经过以上步骤，Framework 认为 State 已经 准备好了，于是调用 build。我们需要在这个函数中，根据父 Widget 传递过来的初始化配置数据，以及 State 的当前状态，创建一个 Widget 然后返回

    | 方法名                | 功能                                   | 调用时机                                | 调用次数 |
    | --------------------- | -------------------------------------- | --------------------------------------- | -------- |
    | 构造方法              | 接收父 widget 传递的初始化 UI 配置数据 | 创建 state 时                           | 1        |
    | initState             | 与渲染相关的初始化工作                 | 在 state 被插入试图时                   | 1        |
    | didChangeDependencies | 处理 state 对象依赖关系编号            | initState 后及 state 对象依赖关系变化时 | >=1      |
    | build                 | 构建试图                               | state 准备好数据需要渲染时              | >=1      |
    | setState              | 触发视图重构                           | 需要刷新 ui 时                          | >=1      |
    | didUpdateWidget       | 处理 widget 的配置变化                 | 父 widgetsetState 触发子 widget 重建时  | >=1      |
    | deactivate            | 组件被移除                             | 组件不可视                              | >=1      |
    | dispose               | 组件被销毁                             | 组件被永久移除                          | 1        |

### 主题色

#### 继承主题色

```dart
//通过 Theme.of(context) 对象获取需要的颜色
Theme.of(context).primaryColor
```

#### 显示隐藏元素 Offstage
`false` 显示，`true` 隐藏
```dart
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
```

#### 按钮控件

Flutter 提供了三个基本的按 钮控件，即 FloatingActionButton、FlatButton 和 RaisedButton。

```dart
FloatingActionButton(onPressed: () => print('FloatingActionButton pressed'),child: Text('Btn'),);
TextButton(onPressed: () => print('TextButton pressed'),child: Text('Btn'),);
ElevatedButton(onPressed: () => print('RaisedButton pressed'),child:Text('Btn'),);
// RaisedButton, FlatButton  弃用
```

### 布局

#### 设备的宽高

```dart
MediaQuery.of(context).size.width
MediaQuery.of(context).size.height
```

单个 `Widget` 布局： `Container` 、 `Padding` 与 `Center`

多子 `Widget` 布局： `Row` 、 `Column` 与 `Expanded` ( 主轴： `mainAxisAlignment` 与 纵轴： `crossAxisAlignment` 。)
层叠 `Widget` 布局 ： `Stack` 与 `Positioned`

-   `Stack`容器与前端中的绝对定位类似，`Stack`控件允许其子 Widget 按照创建的先后顺序进行层叠摆放，而 `Positioned`控件则用来控制这些子`Widget`的摆放位置。需要注意的是， `Positioned`控件只能在`Stack`中使用，在其他容器中使用会报错。

```dart
 Stack(
    children: <Widget>[
      Container(color: Colors.pink, width: 300, height: 300), //黄色容器
      Positioned(
        left: 18.0,
        top: 18.0,
        child: Container(
            color: Colors.green,
            width: 50,
            height: 50), //叠加在黄色容器之上的绿色控件
      ),
      Positioned(
        left: 18.0, top: 70.0,
        child: Text("Stack提供了层叠布局的容器"), //叠加在黄色容器之上的文本
      )
    ],)
```

#### Text

`

```dart
  Text(
  'text',
      // 控制超出一行 ...
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.grey  [500]),
  );
 Text(
        "Text组件的使用",
        style: TextStyle(
            // 文字颜色
            color: Color(0xfff0000),
            // none 不显示装饰线条，underline 字体下方，overline 字体上方，lineThrough穿过文字
            decoration: TextDecoration.none,
            // solid 直线，double 双下划线，dotted 虚线，dashed 点下划线，wavy 波浪线
            decorationStyle: TextDecorationStyle.solid,
            // 装饰线的颜色
            decorationColor: Colors.red,
            // 文字大小
            fontSize: 15.0,
            // normal 正常，italic 斜体
            fontStyle: FontStyle.normal,
            // 字体的粗细
            fontWeight: FontWeight.bold,
            // 文字间的宽度
            letterSpacing: 1.0,
            // 文本行与行的高度，作为字体大小的倍数（取值1~2，如1.2）
            height: 1,
            //对齐文本的水平线:
            //TextBaseline.alphabetic：文本基线是标准的字母基线
            //TextBaseline.ideographic：文字基线是表意字基线；
            //如果字符本身超出了alphabetic 基线，那么ideograhpic基线位置在字符本身的底部。
            textBaseline: TextBaseline.alphabetic),
        // 段落的间距样式
        strutStyle: StrutStyle(
          fontFamily: 'serif',
          fontFamilyFallback: ['monospace', 'serif'],
          fontSize: 20,
          height: 2,
          leading: 2.0,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          forceStrutHeight: true,
          debugLabel: 'text demo',
        ),
        // 文字对齐方式
        textAlign: TextAlign.center,
        // 文字排列方向 ltr 左到右，rtl右到左
        textDirection: TextDirection.ltr,
        // 用于选择区域特定字形的语言环境
        locale: Locale('zh_CN'),
        // 软包裹 ，文字是否应该在软断行出断行
        softWrap: false,
        // 如何处理视觉溢出:clip 剪切溢出的文本以修复其容器。ellipsis 使用省略号表示文本已溢出。fade 将溢出的文本淡化为透明。
        overflow: TextOverflow.clip,
        // 文字的缩放比例
        textScaleFactor: 1.0,
        // 文本要跨越的可选最大行数,
        maxLines: 2,
        // 图像的语义描述，用于向Andoid上的TalkBack和iOS上的VoiceOver提供图像描述
        semanticsLabel: 'text demo',
        textWidthBasis: TextWidthBasis.longestLine,
      )
```

#### ConstrainedBox

`ConstrainedBox` 用于对子组件添加额外的约束

```dart
// 实现一个最小高度为50，宽度尽可能大的红色容器。
ConstrainedBox(
  constraints: BoxConstraints(
    minWidth: double.infinity, //宽度尽可能大
    minHeight: 50.0 //最小高度为50像素
  ),
  child: Container(
      height: 5.0,
      child: redBox
  ),
)
```

#### BoxDecoration

```dart
BoxDecoration({
  Color color, //颜色
  DecorationImage image,//图片
  BoxBorder border, //边框
  BorderRadiusGeometry borderRadius, //圆角
  List<BoxShadow> boxShadow, //阴影,可以指定多个
  Gradient gradient, //渐变
  BlendMode backgroundBlendMode, //背景混合模式
  BoxShape shape = BoxShape.rectangle, //形状
})
```

#### Container

```dart
Container(
     child: Text('Container（容器）在UI框架中是一个很常见的概念，Flutter也不例外。'),
     padding: EdgeInsets.all(18.0), // 内边距
     margin: EdgeInsets.all(44.0), // 外边距
     margin: EdgeInsets.only(top: 50.0, left: 120.0), //容器外填充
    constraints: BoxConstraints.tightFor(width: 200.0, height: 150.0), //卡片大小
    decoration: BoxDecoration(//背景装饰
      gradient: RadialGradient( //背景径向渐变
          colors: [Colors.red, Colors.orange],
          center: Alignment.topLeft,
          radius: .98
      ),
      // 圆角
      borderRadius: BorderRadius.circular(10.0), // 圆角边框
      //卡片阴影
      boxShadow: [ /
        BoxShadow(
            color: Colors.black54,
            offset: Offset(2.0, 2.0),
            blurRadius: 4.0
        )
      ]
  ),
  transform: Matrix4.rotationZ(.2), //卡片倾斜变换
     //满屏宽高
     width: MediaQuery.of(context).size.width,
     height: MediaQuery.of(context).size.height,
     //自定义宽高
     width: 180.0,
     height: 240,
     alignment: Alignment.center, // 子Widget居中对齐
     decoration: BoxDecoration(
       //Container样式 color: Colors.red, // 背景色
      borderRadius: BorderRadius.circular(10.0), // 圆角边框
     ),
   )
```

#### SingleChildScrollView 给内容添加滚动

```dart
SingleChildScrollView(
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
```

#### Padding

```dart
Container(
  Padding(
      // padding: EdgeInsets.all(10),
     padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
     child:Text('is padding')
)
```

#### Wrap 流式布局

Wrap 是一个可以使子控件自动换行的控件，默认的方向是水平的

```dart
 Wrap({
    Key key,
    this.direction = Axis.horizontal,   //排列方向，默认水平方向排列
    this.alignment = WrapAlignment.start,  //子控件在主轴上的对齐方式
    this.spacing = 0.0,  //主轴上子控件中间的间距
    this.runAlignment = WrapAlignment.start,  //子控件在交叉轴上的对齐方式
    this.runSpacing = 0.0,  //交叉轴上子控件之间的间距
    this.crossAxisAlignment = WrapCrossAlignment.start,   //交叉轴上子控件的对齐方式
    this.textDirection,   //textDirection水平方向上子控件的起始位置
    this.verticalDirection = VerticalDirection.down,  //垂直方向上子控件的其实位置
    List<Widget> children = const <Widget>[],   //要显示的子控件集合
  })
```

#### Align

```dart
Align({
    Key key,
    this.alignment = Alignment.center,
    this.widthFactor,
    this.heightFactor,
    Widget child,
    // Alignment.topLeft：顶部左边
    // Alignment.topCenter：顶部中间
    // Alignment.topRight：顶部右边
    // Alignment.centerLeft：中部左边
    // Alignment.center：中部中间
    // Alignment.centerRight：中部右边
    // Alignment.bottomLeft：底部左边
    // Alignment.bottomCenter：底部中间
    // Alignment.bottomRight：底部右边

```

#### border

```dart
// 4边框
Container(
 decoration: BoxDecoration(
   border: Border.all(
      color: Colors.indigoAccent[100],
      width: 3,
      style: BorderStyle.solid)), // 圆
)
// 单边

 border: Border(
    top: BorderSide(
        color: Colors.black26,
        width: 1,
        style: BorderStyle.solid)),

// 或者
 border: Border.fromBorderSide(BorderSide(
                    color: Colors.black26,
                    width: 1,
                    style: BorderStyle.solid))

```

#### button

```dart
TextButton(
      child: Text("TextButton按钮"),
      //添加一个点击事件
      onPressed: () {},
      //设置按钮是否自动获取焦点
      autofocus: true,
      //定义一下文本样式
      style: ButtonStyle(
        //定义文本的样式 这里设置的颜色是不起作用的
        textStyle: MaterialStateProperty.all(
            TextStyle(fontSize: 18, color: Colors.red)),
        //设置按钮上字体与图标的颜色
        //foregroundColor: MaterialStateProperty.all(Colors.deepPurple),
        //更优美的方式来设置
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) {
            if (states.contains(MaterialState.focused) &&
                !states.contains(MaterialState.pressed)) {
              //获取焦点时的颜色
              return Colors.blue;
            } else if (states.contains(MaterialState.pressed)) {
              //按下时的颜色
              return Colors.deepPurple;
            }
            //默认状态使用灰色
            return Colors.grey;
          },
        ),
        //背景颜色
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          //设置按下时的背景颜色
          if (states.contains(MaterialState.pressed)) {
            return Colors.blue[200];
          }
          //默认不使用背景颜色
          return null;
        }),
        //设置水波纹颜色
        overlayColor: MaterialStateProperty.all(Colors.yellow),
        //设置阴影  不适用于这里的TextButton
        elevation: MaterialStateProperty.all(0),
        //设置按钮内边距
        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
        //设置按钮的大小
        minimumSize: MaterialStateProperty.all(Size(200, 100)),

        //设置边框
        side:
            MaterialStateProperty.all(BorderSide(color: Colors.grey, width: 1)),
        //外边框装饰 会覆盖 side 配置的样式
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
    );
```

#### 圆形头像

```dart

new ClipOval(
    child: Image.asset("assets/images/home/xingbiao.png",fit: BoxFit.fill)),

CircleAvatar(
    radius: 36.0,
    backgroundImage: AssetImage(
      "assets/images/home/xingbiao.png",
    ),


Container(
    width: 72.0,
    height: 72.0,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: DecorationImage(
        image: AssetImage(
          "assets/images/home/xingbiao.png",
        ),
      ),
    ),

```

#### ClipRRect 用于图片倒角

```dart
ClipRRect(
  borderRadius: BorderRadius.circular(8.0), //图片倒圆角
  child: Image.asset("images/zz.png", width: 80, height: 80))
```

### ListView

```dart
ListView({
  Axis scrollDirection = Axis.vertical, //列表的滚动方向
  ScrollController controller, // 控制器，与列表滚动相关，比如监听列表的滚动事件
  ScrollPhysics physics, //列表滚动至边缘后继续拖动的物理效果
  bool shrinkWrap = false, //该属性将决定列表的长度是否仅包裹其内容的长度
  EdgeInsetsGeometry padding, //列表内边距
  double    itemExtent, //子元素长度 length
  double    cacheExtent, // 预渲染区域长度，ListView会在其可视区域的两边留一个cacheExtent长度的区域作为预渲染区域
  addAutomaticKeepAlives： true//该属性表示是否将列表项（子组件）包裹在AutomaticKeepAlive 组件中；
  addRepaintBoundaries：//该属性表示是否将列表项（子组件）包裹在RepaintBoundary组件中
  List<Widget> children = const <Widget>[],
})

```

静态子项

```dart
ListView(
   scrollDirection: Axis.horizontal,
   itemExtent: 80,//item延展尺寸(宽度)
   children: <Widget>[
   //设置ListTile组件的标题与图标
   //ListTile是Flutter提供的用于快速构建列表项元素的一个小组件单元，
       ListTile(leading: Icon(Icons.map), title: Text('Map')),
       ListTile(leading: Icon(Icons.mail), title: Text('Mail')),
       ListTile(leading: Icon(Icons.message), title: Text('Message')),
       // 或者自己的widget     Container(color: Colors.red),
    ]
)
```

#### ListView.builder

适用于子 Widget 比较 多的场景。这个构造函数有两个关键参数

-   itemBuilder，是列表项的创建方法。当列表滚动到相应位置时， ListView 会调用该方法创建对应的子 Widget。
-   itemCount，表示列表项的数量，如果为空，则表示 ListView 为无限 列表。

````dart
ListView.builder(
    itemCount: 100, //元素个数
    itemExtent: 50.0, //列表项高度
    itemBuilder: (BuildContext context, int index) => ListTile(title: Text("title     $index"), subtitle: Text("body $index")) );
    ```

#### ListView.separated 分割线

```dart
 ListView.separated(
      itemCount: 100,
      separatorBuilder: (BuildContext context, int index) => index %2 == 0
          ? Divider(color: Colors.green)
          : Divider(
              color: Colors.red), //index为偶数，创建绿色分割线；index为奇数，则创建红色分割线
      itemBuilder: (BuildContext context, int index) => ListTile(
          title: Text("title $index"),
          subtitle: Text("body $index")) //创建子Widget  )
````

### 导航 Tabs

#### 底部导航

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ListContainer')),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: TabBarView(
            children: [
              StaticList(),
              ScrollList(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(
                text: 'Listview',
              ),
              Tab(
                text: 'Scrollview',
              ),
            ],
            onTap: (i) => print('$i --- onTap'),
            unselectedLabelColor: Colors.blueGrey,
            // labelColor: color,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.red,
          ),
        ),
      ),
    );
  }

```

#### 顶部部导航

```dart
class ListContainer extends StatefulWidget {
  @override
  _ListContainer createState() => _ListContainer();
}

class _ListContainer extends State<ListContainer>
    with SingleTickerProviderStateMixin {
  TabController _tabController; //需要定义一个Controller
  List tabs = [
    "ListView",
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
            controller: _tabController,
            tabs: tabs.map((e) => Tab(text: e)).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          StaticList(),
          ScrollList(),
        ],
      ),
    );
  }
}

```

#### Tab

```dart
 Tab({
  Key key,
  this.text, // 菜单文本
  this.icon, // 菜单图标
  this.child, // 自定义组件样式
})
```

### MaterialApp

```dart
MaterialApp({
  Key key,
  title = '', // 设备用于为用户识别应用程序的单行描述
  home, // 应用程序默认路由的小部件,用来定义当前应用打开的时候，所显示的界面
  color, // 在操作系统界面中应用程序使用的主色。
  theme, // 应用程序小部件使用的颜色。
  routes = const <String, WidgetBuilder>{}, // 应用程序的顶级路由表
  navigatorKey, // 在构建导航器时使用的键。
  initialRoute, // 如果构建了导航器，则显示的第一个路由的名称
  onGenerateRoute, // 应用程序导航到指定路由时使用的路由生成器回调
  onUnknownRoute, // 当 onGenerateRoute 无法生成路由(initialRoute除外)时调用
  navigatorObservers = const <NavigatorObserver>[], // 为该应用程序创建的导航器的观察者列表
  builder, // 用于在导航器上面插入小部件，但在由WidgetsApp小部件创建的其他小部件下面插入小部件，或用于完全替换导航器
  onGenerateTitle, // 如果非空，则调用此回调函数来生成应用程序的标题字符串，否则使用标题。
  locale, // 此应用程序本地化小部件的初始区域设置基于此值。
  localizationsDelegates, // 这个应用程序本地化小部件的委托。
  localeListResolutionCallback, // 这个回调负责在应用程序启动时以及用户更改设备的区域设置时选择应用程序的区域设置。
  localeResolutionCallback, //
  supportedLocales = const <Locale>[Locale('en', 'US')], // 此应用程序已本地化的地区列表
  debugShowMaterialGrid = false, // 打开绘制基线网格材质应用程序的网格纸覆盖
  showPerformanceOverlay = false, // 打开性能叠加
  checkerboardRasterCacheImages = false, // 打开栅格缓存图像的棋盘格
  checkerboardOffscreenLayers = false, // 打开渲染到屏幕外位图的图层的棋盘格
  showSemanticsDebugger = false, // 打开显示框架报告的可访问性信息的覆盖
  debugShowCheckedModeBanner = true, // 在选中模式下打开一个小的“DEBUG”横幅，表示应用程序处于选中模式
})
```

### Scaffold

```dart
Scaffold({
  key,
  appBar, // 标题栏
  body,  // 用于显示当前界面主要内容的Widget
  floatingActionButton, // 一个悬浮在body上的按钮，默认显示在右下角
  floatingActionButtonLocation, // 用于设置floatingActionButton显示的位置
  floatingActionButtonAnimator, // floatingActionButton移动到一个新的位置时的动画
  persistentFooterButtons, // 多状态按钮
  drawer, // 左侧的抽屉菜单
  endDrawer, //  右'侧的抽屉菜单
  bottomNavigationBar,// 底部导航栏。
  bottomSheet, // 显示在底部的工具栏
  backgroundColor,// 内容的背景颜色
  resizeToAvoidBottomInset = true, // 控制界面内容 body 是否重新布局来避免底部被覆盖，比如当键盘显示的时候，重新布局避免被键盘盖住内容。
  primary = true,// Scaffold是否显示在页面的顶
```

### AppBar

```dart
AppBar({
  Key key,
  this.leading, //导航栏最左侧Widget，常见为抽屉菜单按钮或返回按钮。
  this.automaticallyImplyLeading = true, //如果leading为null，是否自动实现默认的leading按钮
  this.title,// 页面标题
  this.actions, // 导航栏右侧菜单
  this.bottom, // 导航栏底部菜单，通常为Tab按钮组
  this.elevation = 4.0, // 导航栏阴影
  this.centerTitle, //标题是否居中
  this.backgroundColor,
  ...   //其它属性见源码注释
})
```

#### flutter 用户交互事件

-   第一类是原始的指针事件（Pointer Event），即原生开发中常见的 触摸事件，表示屏幕上触摸（或鼠标、手写笔）行为触发的位移行 为；

    -   手指接触屏幕 `PointerDownEvent`
    -   手指在屏幕上移动 `PointerMoveEvent`
    -   手指抬起 `PointerUpEvent`
    -   触摸取消 `PointerCancelEvent`

````dart
    Listener(
               child: Container(
                 color: Colors.red, //背景色红色
                 width: 300, height: 300,
               ),
               onPointerDown: (event) => print("down "), //手势按下回调
               onPointerMove: (event) => print("move "), //手势移动回调
               onPointerUp: (event) => print("up $event"), //手势抬起回调
             )
    ```

*   第二类则是手势识别 `GestureDetector`（Gesture Detector），表示多个原始指针事件 的组合操作，如点击、双击、长按等，是指针事件的语义化封装。

    -   点击 `onTap`
    -   双击 `onDoubleTap`
    -   长按 `onLongPress`
    -   拖拽 `onPanUpdate`
    -   缩放 `onScaleUpdate`

``` dart
  //红色container坐标
  double _top = 0.0;
  double _left = 0.0;
Stack(
      //使用Stack组件去叠加视图，便于直接控制视图坐标
      children: <Widget>[
        Positioned(
          top: _top,
          left: _left,
          child: GestureDetector(
            //手势识别
            child: Container(color: Colors.red, width: 50, height: 50), //红色子视图
            onTap: () => print("Tap"), //点击回调
            onDoubleTap: () => print("Double Tap"), //双击回调
            onLongPress: () => print("Long Press"), //长按回调
            onPanUpdate: (e) {
              //拖动回调
              setState(() {
                //更新位置
                _left += e.delta.dx;
                _top += e.delta.dy;
              });
            },
          ),
        )
      ],
    );

  // 尽管父容器也监 听了点击事件，但Flutter只响应了子容器的点击事件
   GestureDetector(
      onTap: () => print('Parent tapped'), //父视图的点击回调
      child: Container(
        color: Colors.pinkAccent,
        child: Center(
          child: GestureDetector(
            onTap: () => print('Child tapped'), //子视图的点击回调
            child: Container(
              color: Colors.blueAccent,
              width: 200.0,
              height: 200.0,
            ),
          ),
        ),
      ),
    );
````

### 组件传递数据 InheritedWidget、Notification、EventBus

| 方式            | 数据流动方式 | 适用场景     |
| --------------- | ------------ | ------------ |
| 属性传值        | 父到子       | 简单数据传递 |
| InheritedWidget | 父到子       | 跨层数据传递 |
| Notification    | 子到父       | 状态通知     |
| EventBus        | 发布订阅     | 消息批量同步 |

`InheritedWidget` 、 `Notification` 依赖父子 widget 树， `eventBus` 用以跨页面事件通知

#### InheritedWidget

InheritedWidget 是 Flutter 中的一个功能型 Widget，适用于在 Widget 树中共 享数据的场景。通过它，我们可以高效地将数据在 Widget 树中进行跨层 传递。

```dart
class ShareDataWidget extends InheritedWidget {
  ShareDataWidget({@required this.data, Widget child}) : super(child: child);
  final int data; //需要在子树中共享的数据，保存点击次数
  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }
  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget old) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return old.data != data;
  }
}
class _TestWidget extends StatefulWidget {
  @override
  __TestWidgetState createState() => new __TestWidgetState();
}

class __TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用。
    //如果build中没有依赖InheritedWidget，则此回调不会被调用。
    print("Dependencies change");
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  _InheritedWidgetTestRouteState createState() =>
      new _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        //使用ShareDataWidget
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: _TestWidget(), //子widget中依赖ShareDataWidget
            ),
            ElevatedButton(
              child: Text("Increment"),
              //每点击一次，将count自增，然后重新build,ShareDataWidget的data将被更新
              onPressed: () => setState(() => ++count),
            )
          ],
        ),
      ),
    );
  }
}

```

#### Notification

通知（Notification）是 `Flutter` 中一个重要的机制，在 `widget` 树中，每一个节点都可以分发通知，通知会沿着当前节点向上传递，所有父节点都可以通过 `NotificationListener` 来监听通知。 `Flutter` 中将这种由子向父的传递通知的机制称为通知冒泡（Notification Bubbling）。通知冒泡和用户触摸事件冒泡是相似的，但有一点不同：通知冒泡可以中止，但用户触摸事件不行

```dart
class CustomNotification extends Notification {
  CustomNotification(this.msg);
  final String msg;
}

class CustomChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //按钮点击时分发通知
      onPressed: () => CustomNotification("Hi").dispatch(context),
      child: Text("Fire Notification"),
    );
  }
}

class NotificationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationWidget> {
  String _msg = "通知：";
  @override
  Widget build(BuildContext context) {
    //监听通知
    return NotificationListener<CustomNotification>(
        onNotification: (notification) {
          setState(() {
            _msg += notification.msg + "  ";
          });
          return true; // 阻止冒泡
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Text(_msg), CustomChild()],
        ));
  }
}
```

#### EventBus

事件总线是在 Flutter 中实现跨组件通信的机制。它遵循发布/订阅模式， 允许订阅者订阅事件，当发布者触发事件时，订阅者和发布者之间可以 通过事件进行交互。发布者和订阅者之间无需有父子关系，甚至非 Widget 对象也可以发布/订阅

```dart
import 'package:event_bus/event_bus.dart';
import 'dart:async';
class CustomEvent {
  String msg;
  CustomEvent(this.msg);
}
EventBus eventBus = new EventBus();
class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>_FirstPageState();
}
class _FirstPageState extends State<FirstPage> {
  String msg = "通知：";
  StreamSubscription subscription;
  @override
  void initState() {
    //监听CustomEvent事件，刷新UI
    subscription = eventBus.on<CustomEvent>().listen((event) {
      print(event);
        setState(() {
          msg += event.msg;
        });
    });
    super.initState();
  }
  dispose() {
    subscription.cancel();//State销毁时，清理注册
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("First Page"),),

      body:Text(msg),
        floatingActionButton: FloatingActionButton(onPressed: ()=>Navigator.push(context,MaterialPageRoute(builder: (context) => SecondPage()))),
    );
  }
}
class SecondPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page"),),
      body: ElevatedButton (
          child: Text('Fire Event'),
          // 触发CustomEvent事件
          onPressed: ()=> eventBus.fire(CustomEvent("hello"))
      ),
    );
  }
}
```

### 状态管理 Provider

-   `Provider` 的升级版 `ChangeNotifierProvider` 为子 `Widget` 提供读的 能力，还要提供写的能力，
-   如果只需要为子 `Widget` 提供读能力，直接使 用 `Provider` 即可。
-   `MultiProvider` 实现多个数据资源的共享
-   `notifyListeners()` //通知听众刷新

```dart
//单状态
Provider(
  create: (_) => MyModel()，
  child: ...
)

//多状态
MultiProvider(
  providers: [
  Provider<Something>(create: (_) => Something()),
  ChangeNotifierProvider<Example>(create: (_) => Example()),

  //如果是已经有实例化的对象适用 ChangeNotifierProvider.value 构造函数
  final zz = new ZZ()
  ChangeNotifierProvider.value(value: zz)
  ]，
  child: someWidget，
)
```

#### State 获取状态 （ 读取一个值）

读取一个值最简单的方式就是使用 BuildContext 上的扩展属性(由 provider 注入)。

-   context.watch<T>()， 一方法使得 widget 能够监听泛型 T 上发生的改变。
-   context.read<T>()，直接返回 T，不会监听改变。
-   context.select<T， R>(R cb(T value))，允许 widget 只监听 T 上的一部分(R)。
-   或者使用 Provider.of<T>(context) 这一静态方法，它的表现类似 watch ，而在你为 listen 参数传入 false 时(如 Provider.of<T>(context，listen: false) )，它的表现类似于

    read。

```dart

// 1. 通过 Provider.of<T>(context)
  Provider.of<UserModel>(context, listen: false).user
  Provider.of<UserModel>(context).user= 'asdfsda'

// 2. 通过 buider ， builder 3个参数， context, model( porpvider<t,p>的两个类型,t，p) ，child
Consumer<CounterModel>(
         // builder 3个参数， context ，model，child
        builder: (context, CounterModel counter, child) => FloatingActionButton(
          onPressed: counter.increment,
          child: child,
        ),

```

#### Consumer

`Provider` 可以精确地控制 UI 刷新粒度，而 这一切是基于 `Consumer` 实现的。 `Consumer` 使用了 `Builder` 模式创建 `UI` ， 收到更新通知就会通过 `builder` 重新构建 `Widget` ，不会更新 `builder` 中的 child。

```dart
class CounterModel with ChangeNotifier {
  int _count = 0;
  int get counter => _count;

  void increment() {
    _count++;
    notifyListeners(); //通知听众刷新
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider.value(value: 30.0),
          Provider<String>(create: (_) => 'aa'),
          ChangeNotifierProvider<CounterModel>(create: (_) => CounterModel()),
          // ChangeNotifierProvider.value(value: CounterModel())
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: HomePage()));
  }
}

class ConsumerTabPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      // Consumer2  后面加个数据2 porpvider<t,p> 的t，p
      body: Consumer2<CounterModel, double>(
        // builder 3个参数， context, model( porpvider<t,p>的两个类型,t，p) ，child
          builder: (context, CounterModel counter1, double textSize, _) => Text(
              'Counter: ${counter1.counter}',
              style: TextStyle(fontSize: textSize))),
      floatingActionButton: Consumer<CounterModel>(
         // builder 3个参数， context ，model，child
        builder: (context, CounterModel counter, child) => FloatingActionButton(
          onPressed: counter.increment,
          child: child,
        ),
        child: TestIcon(),
      ),
    );
  }
}
```

### 路由管理

在 Flutter 中，页面之间的跳转是通过 Route 和 Navigator 来管理的：

-   Route 是页面的抽象，主要负责创建对应的界面，接收参数，响应 Navigator 打开和关闭；
-   Navigator 则会维护一个路由栈管理 Route，Route 打开即入栈， Route 关闭即出栈，还可以直接替换栈内的某一个 Route。

而根据是否需要提前注册页面标识符，Flutter 中的路由管理可以分为两 种方式：

#### 路由生成钩子(构建路由才生效)

```dart
MaterialApp(
  ... //省略无关代码
  onGenerateRoute:(RouteSettings settings){
	  return MaterialPageRoute(builder: (context){
		   String routeName = settings.name;
       // 如果访问的路由页需要登录，但当前未登录，则直接返回登录页路由，
       // 引导用户登录；其它情况则正常打开路由。
     }
   );
  }
);
```

#### 基本路由。无需提前注册，在页面切换时需要自己构造页面实例。

    -   类中第一个参数为 context 的静态方法都对应一个 Navigator 的实例方法， 比如

```dart
// Navigator.push(BuildContext context, Route route)等价于Navigator.of(context).push(Route route)
 Navigator.push(context,MaterialPageRoute(builder: (context) => SecondPage()))
 Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProviderTabPage2())

```

#### 命名路由。需要提前注册页面标识符，在页面切换时通过标识符直 接打开新的路由。

```dart
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation',
      //路由表
      routes: {
        "second_page": (context) => SecondPage(),
        "third_page": (context) => ThirdPage()
      },
      //路由异常页面
      onUnknownRoute: (RouteSettings setting) =>
          MaterialPageRoute(builder: (context) => UnknownPage()),
      home: FirstPage(),
    );
  }
}
....
 ElevatedButton( child: Text('命名路由'), onPressed: () => Navigator.pushNamed(context, "second_page"))
```

#### 构建路由传参，参数回传

```dart

 Navigator.push<String>(context,  MaterialPageRoute(builder: (BuildContext context){
    return new ThirdPage(title:"请输入昵称");//传入参数title

  })).then( (String result){// 接收回传参数

   //处理代码

  });
// 回传参数
  Navigator.pop(context,"携带参数");
```

#### 命名路由 传参，回调参数回传

```dart

 ElevatedButton(
       child: Text('命名路由（参数&回调）'),
       onPressed: () =>
           Navigator.pushNamed(context, "third_page", arguments: "Hey")
               .then((msg) { // 接收回传的路由参数
         setState(() {
           _msg = msg;
         });
       }),
  )

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 接收路由参数
    String msg = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
      ),
      body: Column(
        children: <Widget>[
          Text('Message from first screen: $msg'),
          ElevatedButton(
              child: Text('back'),
              //回传路由参数
              onPressed: () => Navigator.pop(context, "Hi"))
        ],
      ),
    );
  }
}
```

#### 路由返回携带一个参数

```dart
 Navigator.pop(context, "Hi")

```

### 适配不同分辨率的手机

#### OrientationBuilder 或 MediaQueryData 获取手机是横屏还是竖屏

```dart
@override Widget build(BuildContext context) {
  //orientation =landscape横屏,portrait 竖 屏
  return Scaffold( //使用OrientationBuilder的builder模式感知屏幕旋转
        body: OrientationBuilder( builder: (context, orientation) { //根据屏幕旋转方向返回不同布局行为
            return orientation == Orientation.portrait ? _buildVerticalLayout() : _buildHorizontalLayout(); }, ),
         );
 }

 //使用MediaQueryData提供的orientation方法：
 if(MediaQuery.of(context).orientation == Orientation.portrait) {
   //dosth
 }
```

#### SystemChrome 固定手机的专项（横屏或竖屏）

```dart
SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
```

### dart

#### 类

```dart
// 类
class Point {
  num x, y;
   static num factor = 0;
   //语法糖，等同于在函数体内：this.x = x;this.y = y;
   Point(this.x,this.y);
   void printInfo() => print('($x, $y)');
  static void printZValue() => print('$factor');

}
  var p = new Point(100,200);
  // new 关键字可以省略 p.printInfo(); // 输出(100, 200);
    Point.factor = 10;
    Point.printZValue(); // 输出10

class Point {
  num x, y, z;
   Point(this.x, this.y) : z = 0; // 初始化变量z    相当于  Point(x,y,z){this.x = x; this.y=y; this.z = 0;}
   Point.bottom(num x) : this(x, 0); // 重定向构造函数
   void printInfo() => print('($x,$y,$z)');
 }
   var p = Point.bottom(100); p.printInfo(); // 输出(100,0,0)

// 类继承
1.extends （继承父类）

2. implements （接口实现）  // 成员变量,函数需要重新声明

3.width （混合） class Coordinate with Point { }

class Vector {
   num x, y;
    Vector(this.x, this.y);
    // 自定义相加运算符，实现向量相加
     Vector operator +(Vector v) => Vector(x + v.x, y + v.y);
     // 覆写相等运算符，判断向量相等
     bool operator == (dynamic v) => x == v.x && y == v.y;
}
final x = Vector(3, 3);
final y = Vector(2, 2);
final z = Vector(1, 1)

// operator是Dart的关键字，与运算符一起使用，表示一个类成员运算符函 数。在理解时，我们应该把operator和运算符作为整体，看作是一个成 员函数名
print(x == (y + z)); // 输出true
```

#### final const

const 是已知的具体常量，final 是未知的，运算后才知道

#### 字符串中加入变量

```dart
print('${this.x}${this.y}${this.z}') 简写 print('($x,$y,$z)')
```

#### 多行字符串拼接 '''

```dart
'''
今天不错
年轻人
'''
```

#### dart 经典列子

```dart

class Meta {
  double price;
  String name;
  //成员变量初始化语法糖
  Meta(this.name, this.price);
}

class Item extends Meta{
  Item(name, price) : super(name, price);
  //重载+运算符，将商品对象合并为套餐商品
  Item operator+(Item item) => Item(name + item.name, price + item.price);
}

abstract class PrintHelper {
  printInfo() => print(getInfo());
  getInfo();
}

//with表示以非继承的方式复用了另一个类的成员变量及函数
class ShoppingCart extends Meta with PrintHelper{
  DateTime date;
  String code;
  List<Item> bookings;
  //以归纳合并方式求和
  double get price => bookings.reduce((value, element) => value + element).price;
  //默认初始化函数，转发至withCode函数
  ShoppingCart({name}) : this.withCode(name:name, code:null);
  //withCode初始化方法，使用语法糖和初始化列表进行赋值，并调用父类初始化方法
  ShoppingCart.withCode({name, this.code}) : date = DateTime.now(), super(name,0);

  //??运算符表示为code不为null，则用原值，否则使用默认值"没有"
  @override
  getInfo() => '''
     购物车信息:
     -----------------------------
       用户名: $name
       优惠码: ${code??"没有"}
       总价: $price
       Date: $date
     -----------------------------
     ''';
}

void main() {
  ShoppingCart.withCode(name:'张三', code:'123456')
  ..bookings = [Item('苹果',10.0), Item('鸭梨',20.0)]
  ..printInfo();

  ShoppingCart(name:'李四')
  ..bookings = [Item('香蕉',15.0), Item('西瓜',40.0)]
  ..printInfo();
}
```

#### 安装包

在 `pubspec.yaml` 文件里 的 `dependencies` 下写上要安装的包名及版本号如： `english_words: ^3.1.0` , 重新启动 `flutter` 就会自动安装

> 注意点：包名前面不要多空格，否则安装失败
