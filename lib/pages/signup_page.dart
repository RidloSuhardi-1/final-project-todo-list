import 'package:flutter/material.dart';
import 'package:uas_final/themes.dart';
import 'package:uas_final/widgets/card_register.dart';
import 'package:uas_final/widgets/email_fields.dart';
import 'package:uas_final/widgets/password_confirm.dart';
import 'package:uas_final/widgets/password_fields.dart';
import 'package:uas_final/widgets/remember.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController password = TextEditingController();
  TextEditingController confirm = TextEditingController();
  final _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F6FD),
      body: Container(
        margin: EdgeInsets.only(top: 100),
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'TODO',
                    style: poppinsBold.copyWith(fontSize: 40),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    'LIST',
                    style: poppinsBold.copyWith(
                        fontSize: 40, color: Color(0XFF29D8A1)),
                  ),
                ),
              ],
            ),
            emailFields(),
            passwordFields(),
            confirmPaswordFields(),
            rememberMe(),
            registerCard(),
          ],
        ),
      ),
    );
  }
}
