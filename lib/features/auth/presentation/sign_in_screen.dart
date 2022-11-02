import 'package:flutter/material.dart';

import 'package:inblo_app/common_widgets/inblo_text_button.dart';
import 'package:inblo_app/common_widgets/inblo_text_field.dart';
import 'package:inblo_app/constants/text_styles.dart';

import './sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
                  "Login Account",
                  style: loginTxtStyle,
                ),
                SizedBox(height: 45),
                InbloTextField(
                  textHint: "ユーザー名",
                ),
                SizedBox(height: 24),
                InbloTextField(
                  textHint: "パスワード",
                ),
                SizedBox(height: 24),
                InbloTextButton(
                  onPressed: () {},
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
    );
  }
}
