// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_rent/constant.dart' as constants;
import 'package:house_rent/utils/color.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart' as http;
import 'package:house_rent/screens/auth/widgets/btn_widget.dart';
import 'package:house_rent/screens/auth/widgets/herder_container.dart';

Future<dynamic> createUser(
    name, email, phone, password, BuildContext context) async {
  String uriString = constants.URISTRING;
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  final bool phoneValid = RegExp(r"^[0-9]{10}").hasMatch(phone);
  final bool nameValid = RegExp(r"^[a-zA-Z ]+").hasMatch(name);

  if (emailValid && phoneValid && nameValid) {
    final response = await Dio().post(uriString + 'addUser',
        data: FormData.fromMap({
          "fullname": name,
          "email": email,
          "phone": phone,
          "password": password
        }));
    if (response.statusCode == 200) {
      Map responseBody = response.data;
      Navigator.pop(context);
      Fluttertoast.showToast(msg: responseBody['message']);
    }
    return;
  }

  Fluttertoast.showToast(msg: "Inalid information");

  return [];
}

class RegPage extends StatefulWidget {
  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          children: <Widget>[
            HeaderContainer("Register"),
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(
                        controller: nameController,
                        hint: "Fullname",
                        icon: Icons.person),
                    _textInput(
                        controller: emailController,
                        hint: "Email",
                        icon: Icons.email),
                    _textInput(
                        controller: phoneController,
                        hint: "Phone Number",
                        icon: Icons.call),
                    _textInput(
                        controller: passwordController,
                        obsecure: true,
                        hint: "Password",
                        icon: Icons.vpn_key),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          btnText: "REGISTER",
                          onClick: () {
                            createUser(
                                nameController.text,
                                emailController.text,
                                phoneController.text,
                                passwordController.text,
                                context);
                          },
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Already a member ? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "Login",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {Navigator.pop(context)},
                            style: TextStyle(
                                color: orangeColors, fontSize: 14.00)),
                      ]),
                    )
                  ],
                ),
              ),
            )
          ],
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
