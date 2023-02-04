// ignore_for_file: use_key_in_widget_constructors

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_rent/constant.dart' as constants;
import 'package:house_rent/screens/auth/pages/regi_page.dart';
import 'package:house_rent/screens/auth/widgets/btn_widget.dart';
import 'package:house_rent/screens/auth/widgets/herder_container.dart';
import 'package:house_rent/screens/home/home.dart';
import 'package:house_rent/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<dynamic> loginUser(email, password, BuildContext context) async {
  String uriString = constants.URISTRING;
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  if (emailValid) {
    try {
      final response = await Dio().post(uriString + 'loginUser',
          data: FormData.fromMap({"email": email, "password": password}));
      if (response.statusCode == 200) {
        Map responseBody = response.data;
        final userJson = jsonEncode(responseBody['data']);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('logindata', userJson);
        await prefs.setBool('isUserLogin', true);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Home(
                  username: "Hello," + responseBody['data']['name'],
                )));
        Fluttertoast.showToast(msg: responseBody['message']);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Unauthorized");
    }
    return;
  }

  Fluttertoast.showToast(msg: "Inalid information");

  return [];
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.only(bottom: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              HeaderContainer("Login"),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(
                        hint: "Email",
                        icon: Icons.email,
                        controller: emailController),
                    _textInput(
                        hint: "Password",
                        icon: Icons.vpn_key,
                        obsecure: true,
                        controller: passwordController),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        "Forgot Password?",
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ButtonWidget(
                      onClick: () {
                        loginUser(emailController.text, passwordController.text,
                            context);
                      },
                      btnText: "LOGIN",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Expanded(
                    //   child: Center(
                    //     child: ButtonWidget(
                    //       onClick: () {
                    //         loginUser(emailController.text,
                    //             passwordController.text, context);
                    //       },
                    //       btnText: "LOGIN",
                    //     ),
                    //   ),
                    // ),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Don't have an account ? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                          text: "Register",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RegPage(),
                                  ),
                                ),
                          style:
                              TextStyle(color: orangeColors, fontSize: 14.00),
                        ),
                      ]),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textInput({controller, hint, icon, bool obsecure = false}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        obscureText: obsecure,
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }
}
