import 'package:flutter/material.dart';

import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';
import 'package:inblo_app/constants/text_styles.dart';
import 'package:inblo_app/features/auth/presentation/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

enum Role { trainer, manager }

class _SignUpScreenState extends State<SignUpScreen> {
  Role? _selectedRole = Role.trainer;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
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
                          style: TextStyle(fontFamily: "Roboto", fontSize: 16),
                        ),
                        leading: Radio<Role>(
                          value: Role.trainer,
                          groupValue: _selectedRole,
                          onChanged: (Role? value) {
                            setState(() {
                              _selectedRole = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('担当者',
                            style:
                                TextStyle(fontFamily: "Roboto", fontSize: 16)),
                        leading: Radio<Role>(
                          value: Role.manager,
                          groupValue: _selectedRole,
                          onChanged: (Role? value) {
                            setState(() {
                              _selectedRole = value;
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
                  textHint: "ユーザー名", // username
                ),
                SizedBox(height: 24),
                InbloTextField(
                  textHint: "パスワードを設定", // password
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: InbloTextField(
                        textHint: "姓", // firstname
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: InbloTextField(
                        textHint: "名", // lastname
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                InbloTextField(
                  textHint: "Eメール", // email
                ),
                SizedBox(height: 24),
                InbloTextField(
                  textHint: "厩舎コード", // stable code
                ),
                SizedBox(height: 24),
                InbloTextButton(
                  onPressed: () {},
                  title: "登録", // register button
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
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
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
    );
  }
}
