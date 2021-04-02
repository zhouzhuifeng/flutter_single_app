// import 'dart:html';

import '../../import_common.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool pwdShow = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin;

    if (_unameController.text != null && _unameController.text != '') {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
            title: Text('登录'),
            automaticallyImplyLeading: false,
            centerTitle: true),
        body: SingleChildScrollView(
            child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: h - 60),
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: hex('#303c42'),
            child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction, //开启自动校验
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 70.0, 0, 70.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(right: 20.0),
                                child: Image.asset(
                                    "assets/images/flutter-mono.png",
                                    width: 50,
                                    height: 50)),
                            Text('可惜没有如果',
                                style: TextStyle(
                                    fontSize: 30.0, color: Colors.white))
                          ],
                        ),
                      ),
                      TextFormField(
                          style: TextStyle(color: Colors.white), //输入框文字的颜色
                          autofocus: _nameAutoFocus,
                          controller: _unameController,
                          decoration: InputDecoration(
                            // labelText: "用户名或邮箱",
                            // labelStyle: TextStyle(color: hex('#444')),
                            // helperText: '辅助文本',

                            // prefixText: '头部文本',
                            // counterText: '备注文本',
                            // filled: true,
                            // fillColor: hex('#fff'),
                            errorStyle: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w700),
                            errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.red,
                                    style: BorderStyle.solid)),
                            // 边框的颜色
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xffD5D5D5),
                                    style: BorderStyle.solid)),
                            hintText: "用户名或邮箱",
                            hintStyle: TextStyle(
                              color: Color(0xB7BEB4B4),
                            ),
                            prefixIcon:
                                Icon(Icons.person, color: Color(0xffD5D5D5)),
                          ),
                          // 校验用户名（不能为空）
                          validator: (v) {
                            return v.trim().isNotEmpty ? null : '用户名不能为空';
                          }),
                      TextFormField(
                        style: TextStyle(color: Colors.white), //输入框文字的颜色
                        controller: _pwdController,
                        autofocus: !_nameAutoFocus,
                        decoration: InputDecoration(
                            focusColor: Colors.red,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xffD5D5D5),
                                    style: BorderStyle.solid)),
                            errorStyle: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.w700),
                            // labelText: "密码",
                            hintText: "您的登录密码",
                            hintStyle: TextStyle(
                              color: Color(0xB7BEB4B4),
                            ),
                            prefixIcon:
                                Icon(Icons.lock, color: Color(0xffD5D5D5)),
                            suffixIcon: IconButton(
                              icon: Icon(
                                  pwdShow
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Color(0xffD5D5D5)),
                              onPressed: () {
                                setState(() {
                                  pwdShow = !pwdShow;
                                });
                              },
                            )),
                        obscureText: !pwdShow,
                        //校验密码（不能为空）
                        validator: (v) {
                          return v.trim().isNotEmpty ? null : '密码不能为空';
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.expand(height: 40.0),
                          child: ElevatedButton(
                            // color: Theme.of(context).primaryColor,
                            onPressed: _onLogin,
                            // textColor: Colors.white,
                            child: Text(
                              '登录',
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        alignment: Alignment.topRight,
                        child: TextButton.icon(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('register'),
                            icon: Icon(
                              Icons.border_color,
                              size: 12.0,
                              color: Colors.white,
                            ),
                            label: Text('去注册')),
                      )

                      //   child: Text('注册'),
                      //   // style:
                      //   style: ButtonStyle(
                      //     shape: MaterialStateProperty.all(StadiumBorder()),
                      //   ),
                      //   onPressed: () => print('23'),

                      //   // label: Text('注册')
                      // )
                    ],
                  ),
                )),
          ),
        )));
  }

  void _onLogin() async {
    // 先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      print('登录了-------');
      // Provider.of<UserModel>(context, listen: false).user =
      //     _unameController.text;

      try {
        print(_unameController.text);
        print('object');
        Provider.of<UserModel>(context, listen: false).user =
            _unameController.text;
        //   user = await Git(context)
        //       .login(_unameController.text, _pwdController.text);
        //   // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        //   Provider.of<UserModel>(context, listen: false).user = user;
        // } catch (e) {
        //   //登录失败则提示
        //   if (e.response?.statusCode == 401) {
        //     showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
        //   } else {
        //     showToast(e.toString());
        //   }

      } finally {
        // 隐藏loading框
        Navigator.of(context).pushNamed('/');
      }
      // if (user != null) {
      //   // 返回
      //   Navigator.of(context).pop();
      // }
    }
  }
}
