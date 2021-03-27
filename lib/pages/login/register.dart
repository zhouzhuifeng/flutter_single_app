import '../../import_common.dart';

class RegisterRoute extends StatefulWidget {
  @override
  _RegisterRouteState createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  bool _checkboxSelected = false; //维护复选框状态
  bool pwdShow = false;
  GlobalKey _formKey = new GlobalKey<FormState>();
  bool _nameAutoFocus = true;

  @override
  void initState() {
    // 自动填充上次登录的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text != null) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('注册')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction, //开启自动校验
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                      style: TextStyle(color: Colors.black87), //输入框文字的颜色
                      autofocus: _nameAutoFocus,
                      controller: _unameController,
                      decoration: InputDecoration(
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
                                color: Color(0xBD9B9494),
                                style: BorderStyle.solid)),
                        hintText: "用户名或邮箱",
                        hintStyle: TextStyle(
                          color: Color(0xBD9B9494),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.blue),
                      ),
                      // 校验用户名（不能为空）
                      validator: (v) {
                        return v.trim().isNotEmpty ? null : '用户名不能为空';
                      }),
                  TextFormField(
                    style: TextStyle(color: Colors.black87), //输入框文字的颜色
                    controller: _pwdController,
                    autofocus: !_nameAutoFocus,
                    decoration: InputDecoration(
                        focusColor: Colors.red,
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color(0xBD9B9494),
                                style: BorderStyle.solid)),
                        errorStyle: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w700),
                        // labelText: "密码",
                        hintText: "您的登录密码",
                        hintStyle: TextStyle(
                          color: Color(0xBD9B9494),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.blue),
                        suffixIcon: IconButton(
                          icon: Icon(
                              pwdShow ? Icons.visibility : Icons.visibility_off,
                              color: Colors.blue),
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
                    padding: EdgeInsets.only(top: 25.0),
                    child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Checkbox(
                            value: _checkboxSelected,
                            activeColor: Colors.blue, //选中时的颜色
                            onChanged: (value) {
                              setState(() {
                                _checkboxSelected = value;
                              });
                            },
                          ),
                          Text('本人已阅读并且同意',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14.0)),
                          Text('《可惜没有如果》',
                              style: TextStyle(
                                  color: Colors.red[400], fontSize: 14.0)),
                          Text('相关规定',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14.0)),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ConstrainedBox(
                      constraints: BoxConstraints.expand(height: 40.0),
                      child: ElevatedButton(
                        // color: Theme.of(context).primaryColor,
                        onPressed: _onLogin,
                        // textColor: Colors.white,
                        child: Text(
                          '注册',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  void _onLogin() async {
    // 先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      print('注册了-------');
      // showLoading(context);
      // User user;
      Provider.of<UserModel>(context, listen: false).user =
          _unameController.text;
      if (!_checkboxSelected) {
        return showToast('请先勾选同意协议');
      }
      howAlertDialog(context);
      // try {
      //   print(_unameController.text);
      //   Provider.of<UserModel>(context, listen: false).user =
      //       _unameController.text;
      //   //   user = await Git(context)
      //   //       .login(_unameController.text, _pwdController.text);
      //   //   // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
      //   //   Provider.of<UserModel>(context, listen: false).user = user;
      //   // } catch (e) {
      //   //   //登录失败则提示
      //   //   if (e.response?.statusCode == 401) {
      //   //     showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
      //   //   } else {
      //   //     showToast(e.toString());
      //   //   }
      // } finally {
      //   // 隐藏loading框
      //   Navigator.of(context).pop();
      // }
      // if (user != null) {
      //   // 返回
      //   Navigator.of(context).pop();
      // }
    }
  }
}

howAlertDialog(BuildContext context) {
  //设置按钮
  Widget okButton = TextButton(
    child: Text("确定"),
    onPressed: () {
      Navigator.of(context).pushNamed('login');
    },
  );

  //设置对话框
  AlertDialog alert = AlertDialog(
    title: Center(
        child: Text(
      "系统提示",
      style: TextStyle(color: Colors.black87),
    )),
    content: Text("注册成功！", style: TextStyle(color: Colors.green)),
    actions: [
      okButton,
    ],
  );

  //显示对话框
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
