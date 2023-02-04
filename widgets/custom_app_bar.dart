import 'package:flutter/material.dart';
import 'package:house_rent/screens/auth/pages/login_page.dart';
import 'package:house_rent/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);
  _showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget logoutButton = TextButton(
      child: const Text(
        "Logout",
        style: TextStyle(color: Colors.red),
      ),
      onPressed: () async {
        final pref = await SharedPreferences.getInstance();
        pref.clear();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const Home(username: " "),
            ),
            (route) => false);
      },
    );
    AlertDialog alert = AlertDialog(
      title: const Text("Status"),
      content: const Text("Do you want to Logout. ?"),
      actions: [cancelButton, logoutButton],
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
    _handleNavigateToLogin(BuildContext context) async {
      bool isUserLogin = false;
      final pref = await SharedPreferences.getInstance();
      isUserLogin = (pref.getBool('isUserLogin') ?? false);
      if (isUserLogin == false) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } else {
        _showAlertDialog(context);
      }
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            IconButton(
              onPressed: () {
                _handleNavigateToLogin(context);
              },
              icon: const Icon(Icons.person),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
