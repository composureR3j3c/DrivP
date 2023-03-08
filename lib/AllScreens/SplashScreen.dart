import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../Globals/Global.dart';
import 'LoginScreen.dart';
import 'mainScreen.dart';
import 'package:google_fonts/google_fonts.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  final _storage = const FlutterSecureStorage();
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      var logdName = await _storage.read(key: "name");
      if (onlineDriverData.id != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const MainScreen()));
      } else if (logdName != null) {
        onlineDriverData.name = await _storage.read(key: "name");
        onlineDriverData.lname = await _storage.read(key: "lname");
        onlineDriverData.id = await _storage.read(key: "id");
        onlineDriverData.phone = await _storage.read(key: "phone");
        onlineDriverData.email = await _storage.read(key: "email");
        onlineDriverData.car_model = await _storage.read(key: "car_model");
        onlineDriverData.car_color = await _storage.read(key: "car_color");
        onlineDriverData.car_number = await _storage.read(key: "car_number");
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
