import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_rent/models/best_offer.dart';
import 'package:house_rent/screens/auth/pages/login_page.dart';
import 'package:house_rent/screens/details/success.dart';

import 'package:house_rent/utils/color.dart';
import 'package:house_rent/widgets/about.dart';
import 'package:house_rent/widgets/content_intro.dart';
import 'package:house_rent/constant.dart' as constants;
import 'package:house_rent/widgets/details_app_bar.dart';
import 'package:house_rent/widgets/house_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Details extends StatelessWidget {
  final BestOffer house;
  final peopleController = TextEditingController();
  String uriString = constants.URISTRING;

  Details({
    Key? key,
    required this.house,
  }) : super(key: key);

  void clearText() {
    peopleController.clear();
  }

  Future<bool> _getSp() async {
    final pref = await SharedPreferences.getInstance();
    return (pref.getBool('isUserLogin') ?? false);
  }

  Future<String> _getUser() async {
    final pref = await SharedPreferences.getInstance();
    return (pref.getString('logindata') ?? "");
  }

  _showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget confirmButton = TextButton(
      child: const Text(
        "Confirm",
        style: TextStyle(color: Colors.orange),
      ),
      onPressed: () async {
        String userJson = await _getUser();
        Map<String, dynamic> userJsonDecoded = jsonDecode(userJson);
        final userid = userJsonDecoded["id"];
        final roomId = house.id;
        final nop = peopleController.text;

        final prepareData = {
          "uid": userid,
          "rid": roomId,
          "no_pop": nop,
        };
        try {
          final response = await Dio()
              .post(uriString + 'booking', data: FormData.fromMap(prepareData));

          if (response.statusCode == 200) {
            Map<String, dynamic> responseBody = response.data;
            Fluttertoast.showToast(msg: responseBody['message']);
            clearText();
            Navigator.pop(context);
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const Success(),
            ));
          }
        } catch (e) {
          Fluttertoast.showToast(msg: "Something Went Wrong");
        }
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Status"),
      content: const Text("Are you sure to confirm this booking ?"),
      actions: [
        cancelButton,
        confirmButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsAppBar(house: house),
            const SizedBox(height: 20),
            ContentIntro(house: house),
            const SizedBox(height: 20),
            HouseInfo(house: house),
            const SizedBox(height: 20),
            About(house: house),
            FutureBuilder(
              future: _getSp(),
              builder: (context, snapshot) => snapshot.data == true
                  ? Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20, right: 20, top: 30),
                          child: Column(
                            // mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              _textInput(
                                hint: "No of people",
                                icon: Icons.people,
                                controller: peopleController,
                                inputType: TextInputType.number,
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(left: 23.0),
                          child: const Text(
                            "Cash payment only*",
                            style: TextStyle(
                              color: Colors.orangeAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    )
                  : Container(),
            ),
            FutureBuilder<bool>(
              future: _getSp(),
              builder: (context, snapshot) => snapshot.data == true
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: orangeColors,
                        ),
                        child: InkWell(
                          onTap: () {
                            String people = peopleController.text;
                            // ignore: unnecessary_null_comparison
                            int peopleCount = people != ""
                                ? int.parse(peopleController.text)
                                : 0;
                            if (peopleCount > 0) {
                              _showAlertDialog(context);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "No of People Required");
                            }
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: const Text(
                                'Book Now',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ),
                    )
                  : Center(
                      child: RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Already a member ? ",
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: "Login",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ))
                                  },
                            style: TextStyle(
                                color: orangeColors, fontSize: 14.00)),
                      ]),
                    )),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _textInput({
    controller,
    hint,
    icon,
    bool obsecure = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.only(left: 10),
      child: TextFormField(
        obscureText: obsecure,
        keyboardType: inputType,
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
