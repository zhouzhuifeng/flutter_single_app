import '../../import_common.dart';

class ToLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.width;
    // final containerHight = height - 400;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          alignment: Alignment.center,
          width: width,
          height: 400.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/goLogin.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        GestureDetector(
          //手势识别
          child: Container(
            padding: EdgeInsets.fromLTRB(40, 12, 40, 12),
            decoration: BoxDecoration(
                border: Border.fromBorderSide(BorderSide(
                    color: Colors.black87,
                    width: 1,
                    style: BorderStyle.solid))),
            child: Text('请先登录',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                    decoration: TextDecoration.none)),
          ), //红色子视图
          onTap: () => Navigator.pushNamed(context, "login"), //点击回调
        ),
      ],
    );
  }
}
