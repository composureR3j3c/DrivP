import 'dart:async';
import 'package:flutter/material.dart';
import '../Globals/Global.dart';
import '../Helpers/assistantMethods.dart';
import 'LoginScreen.dart';
import 'mainScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    fAuth.currentUser != null
        ? AssistantMethods.readCurrentOnlineUserInfo()
        : null;

    Timer(const Duration(seconds: 3), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 60, 60, 0),
                    child: Image.asset("images/logo.png"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "One Taxi Driver",
                    style: GoogleFonts.pacifico(
                      textStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            Shadow(
                              blurRadius: 16,
                              color: Colors.black54,
                              offset: Offset(0.6, 0.6),
                            )
                          ]),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
