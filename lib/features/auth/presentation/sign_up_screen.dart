import 'package:flutter/material.dart';

import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';
import 'package:inblo_app/constants/text_styles.dart';
import 'package:inblo_app/features/auth/presentation/sign_in_screen.dart';
import 'package:inblo_app/features/auth/providers/auth.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

enum Role {
  manager(1),
  trainer(2);

  final int roleNum;
  const Role(this.roleNum);
}

class _SignUpScreenState extends State<SignUpScreen> {
  late Role _selectedRole = Role.trainer;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _stableCodeController = TextEditingController();

  final _form = GlobalKey<FormState>();

  bool _loadIndicator = false;

  bool validateForm() {
    return _form.currentState?.validate() ?? false;
  }

  void _registerUser(BuildContext context, Auth auth) async {
    if (!validateForm()) {
      return;
    }
    setState(() {
      _loadIndicator = true;
    });
    var loginResponse = await auth.registerUser(
      _usernameController.text,
      _passwordController.text,
      _firstNameController.text,
      _lastNameController.text,
      _emailController.text,
      _selectedRole.roleNum,
      _stableCodeController.text,
    );
    setState(() {
      _loadIndicator = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(loginResponse.metaResponse.message),
      ),
    );

    if (loginResponse.metaResponse.code == 201) {
      resetFields();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignInScreen()));
    }
  }

  void resetFields() {
    _usernameController.clear();
    _passwordController.clear();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _selectedRole = Role.trainer;
    _stableCodeController.clear();
  }

  @override
  void initState() {
    _selectedRole = Role.trainer;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    Auth auth = Provider.of<Auth>(context, listen: false);

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
                    "Register",
                    style: loginTxtStyle,
                  ),
                  SizedBox(height: 15),
                  // Role Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "役割は？",
                        style: loginCaptionGrey,
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text(
                            '調教師',
                            style:
                                TextStyle(fontFamily: "Roboto", fontSize: 16),
                          ),
                          leading: Radio<Role>(
                            value: Role.trainer,
                            groupValue: _selectedRole,
                            onChanged: (Role? value) {
                              setState(() {
                                if (value != null) _selectedRole = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          title: const Text('担当者',
                              style: TextStyle(
                                  fontFamily: "Roboto", fontSize: 16)),
                          leading: Radio<Role>(
                            value: Role.manager,
                            groupValue: _selectedRole,
                            onChanged: (Role? value) {
                              setState(() {
                                if (value != null) _selectedRole = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  // end of Role Selection
                  SizedBox(height: 24),
                  InbloTextField(
                    textHint: "ユーザー名",
                    controller: _usernameController, // username
                    isRequired: true,
                  ),
                  SizedBox(height: 24),
                  InbloTextField(
                    textHint: "パスワードを設定",
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestion: false,
                    controller: _passwordController, // password
                    isRequired: true,
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: InbloTextField(
                          textHint: "姓", // firstname
                          controller: _firstNameController,
                          isRequired: true,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: InbloTextField(
                          textHint: "名", // lastname
                          controller: _lastNameController,
                          isRequired: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  InbloTextField(
                    textHint: "Eメール", // email
                    inputType: TextInputType.emailAddress,
                    controller: _emailController,
                    isRequired: true,
                  ),
                  SizedBox(height: 24),
                  InbloTextField(
                    textHint: "厩舎コード", // stable code
                    controller: _stableCodeController,
                    isRequired: true,
                  ),
                  SizedBox(height: 24),
                  InbloTextButton(
                    onPressed: () => _registerUser(context, auth),
                    title: "登録", // register button
                    textStyle: TextStyleInbloButton.big,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "既にアカウントをお持ちの方？", // already have an account?
                        style: loginCaptionGrey,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => SignInScreen()));
                        },
                        child: Text(
                          "ログイン", // goto sign-in screen
                          style: loginCaptionBlack,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 32),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _stableCodeController.dispose();
    super.dispose();
  }
}
