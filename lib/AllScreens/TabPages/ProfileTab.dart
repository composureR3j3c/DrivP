import 'package:driveridee/AllScreens/SplashScreen.dart';
import 'package:driveridee/AllScreens/home.dart';
import 'package:driveridee/Globals/Global.dart';
import 'package:driveridee/Helpers/onPremHelpers.dart';
import 'package:flutter/material.dart';

import '../../Models/driversData.dart';
import '../../Widgets/info_design_ui.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
            // Home(),
            //name
            Container(
              padding: EdgeInsets.fromLTRB(22, 22, 22, 32),
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    onlineDriverData.name!,
                    style: const TextStyle(
                      fontSize: 45.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    //  titleStarsRating +
                    "Driver",
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    width: 200,
                    child: Divider(
                      color: Colors.white,
                      height: 2,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 38.0,
            ),

            //phone
            InfoDesignUIWidget(
              textInfo: onlineDriverData.phone!,
              iconData: Icons.phone_iphone,
            ),

            //email
            InfoDesignUIWidget(
              textInfo: onlineDriverData.email!,
              iconData: Icons.email,
            ),

            InfoDesignUIWidget(
              textInfo: onlineDriverData.car_color! +
                  " " +
                  onlineDriverData.car_model! +
                  " " +
                  onlineDriverData.car_number!,
              iconData: Icons.car_repair,
            ),

            const SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                child: const Text(
                  "Sign Out",
                ),
                onPressed: () async {
                  var res = OnPremMethods.premLoginOut(onlineDriverData.phone!);
                  if (res != 404) {
                    onlineDriverData = DriverData();
                    fAuth.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => const MySplashScreen()));
                  }
                },
              ),
            )
          ])),
    );
  }
}
