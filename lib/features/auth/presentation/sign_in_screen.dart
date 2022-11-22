import 'package:flutter/material.dart';
import 'package:inblo_app/features/dashboard/presentation/main_dashboard_screen.dart';
import 'package:provider/provider.dart';

import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';
import 'package:inblo_app/constants/text_styles.dart';
import 'package:inblo_app/features/auth/providers/auth.dart';
import './sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late FocusNode _usernameFn;
  late FocusNode _passwordFn;

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    initFocus();
    super.initState();
  }

  @override
  void dispose() {
    disposeFocus();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void disposeFocus() {
    _usernameFn.dispose();
    _passwordFn.dispose();
  }

  void initFocus() {
    _usernameFn = FocusNode();
    _passwordFn = FocusNode();
  }

  bool validateForm() {
    return _form.currentState?.validate() ?? false;
  }

  void handleLogin(
    Auth authProvider,
    ScaffoldMessengerState scaffoldMessenger,
    NavigatorState contextNavigator,
  ) async {
    if (!validateForm()) {
      return;
    }

    var loginResponse = await authProvider.loginUser(
        _usernameController.text, _passwordController.text);

    scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(loginResponse.metaResponse.message)));

    if (loginResponse.metaResponse.code == 200) {
      contextNavigator.pushReplacement(
          MaterialPageRoute(builder: (ctx) => MainDashboardScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    var scaffoldMessenger = ScaffoldMessenger.of(context);
    var contextNavigator = Navigator.of(context);
    var authProvider = Provider.of<Auth>(context, listen: false);

    //focus

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: [
              Image(
                image: AssetImage("assets/images/img_login_banner.jpg"),
                fit: BoxFit.cover,
                height: height * .33,
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30),
                child: Column(children: [
                  SizedBox(height: 45),
                  Text(
                    "Login Account",
                    style: loginTxtStyle,
                  ),
                  SizedBox(height: 45),
                  InbloTextField(
                    textHint: "ユーザー名",
                    controller: _usernameController,
                    autofocus: true,
                    focusNode: _usernameFn,
                    isRequired: true,
                  ),
                  SizedBox(height: 24),
                  InbloTextField(
                    textHint: "パスワード",
                    obscureText: true,
                    enableSuggestion: false,
                    autocorrect: false,
                    controller: _passwordController,
                    isRequired: true,
                  ),
                  SizedBox(height: 24),
                  InbloTextButton(
                    onPressed: () {
                      handleLogin(
                          authProvider, scaffoldMessenger, contextNavigator);
                    },
                    title: "サインイン",
                    textStyle: TextStyleInbloButton.big,
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (ctx) => SignUpScreen()));
                    },
                    child: Text(
                      "アカウントを新規作成する",
                      style: loginCaptionBlack,
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
