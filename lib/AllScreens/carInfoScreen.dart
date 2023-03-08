import 'package:driveridee/AllScreens/SplashScreen.dart';
import 'package:driveridee/AllScreens/mainScreen.dart';
import 'package:driveridee/Globals/Global.dart';
import 'package:driveridee/Helpers/onPremHelpers.dart';
import 'package:driveridee/Widgets/DropDown.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Widgets/ProgressDialog.dart';

class CarInfo extends StatefulWidget {
  CarInfo({Key? key}) : super(key: key);

  @override
  State<CarInfo> createState() => _CarInfoState();
}

class _CarInfoState extends State<CarInfo> {
  TextEditingController carModelTextEditingController = TextEditingController();

  TextEditingController carNumberTextEditingController =
      TextEditingController();

  TextEditingController carColorTextEditingController = TextEditingController();
  final _storage = const FlutterSecureStorage();
  validateForm() {
    if (carNumberTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter Car Number.");
    } else if (carModelTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter Car Model.");
    } else if (carColorTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter Car Color.");
    } else {
      saveCarInfoNow();
    }
  }

  saveCarInfoNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing, Please wait...",
          );
        });

    String userId = currentFirebaseUser!.uid;

    if (userId != null) {
      Map CarInfoMap = {
        "car_color": carColorTextEditingController.text.trim(),
        "car_model": carModelTextEditingController.text.trim(),
        "car_number": carNumberTextEditingController.text.trim(),
      };

      DatabaseReference reference =
          FirebaseDatabase.instance.ref().child("drivers");
      reference.child(userId).child("Car_details").set(CarInfoMap);

      Fluttertoast.showToast(msg: "Car details has been registered.");
      var response = await OnPremMethods.createUseronPrem(
          onlineDriverData.name!,
          onlineDriverData.lname!,
          onlineDriverData.phone!,
          onlineDriverData.email!,
          currentFirebaseUser!.uid,
          onlineDriverData.pw!,
          carColorTextEditingController.text.trim(),
          carModelTextEditingController.text.trim(),
          carNumberTextEditingController.text.trim(),
          "econ");

      onlineDriverData.name = response["profile"]["fname"];
      onlineDriverData.lname = response["profile"]["lname"];
      onlineDriverData.phone = response["profile"]["phone"];
      onlineDriverData.email = response["profile"]["email"];
      onlineDriverData.id = response["profile"]["deviceId"];
      onlineDriverData.car_model = response["carDetails"]["carBrand"];
      onlineDriverData.car_color = response["carDetails"]["carColor"];
      onlineDriverData.car_number = response["carDetails"]["plateNo"];

      await _storage.write(key: "name", value: onlineDriverData.name);
      await _storage.write(key: "lname", value: onlineDriverData.lname);
      await _storage.write(key: "phone", value: onlineDriverData.phone);
      await _storage.write(key: "email", value: onlineDriverData.email);
      await _storage.write(key: "id", value: onlineDriverData.id);
      await _storage.write(key: "car_model", value: onlineDriverData.car_model);
      await _storage.write(key: "car_color", value: onlineDriverData.car_color);
      await _storage.write(
          key: "car_number", value: onlineDriverData.car_number);

      print("response");
      print(response);
      if (response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Account has been Created.");
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(msg: "Account has not been Created.");
        Navigator.pop(context);
      }
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Car details has not been registered.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 22.0,
            ),
            Image.asset(
              "images/taxi.png",
              width: 390.0,
              height: 250.0,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22, 22, 22, 32),
              child: Column(
                children: [
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    "Enter car Detail",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Brand-Bold",
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  TextField(
                    controller: carModelTextEditingController,
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                      labelText: "Car Model",
                      hintText: "Car Model",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  TextField(
                    controller: carNumberTextEditingController,
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                      labelText: "Car Number",
                      hintText: "Car Number",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                  TextField(
                    controller: carColorTextEditingController,
                    style: const TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                      labelText: "Car Color",
                      hintText: "Car Color",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  DropdownButtonType(),
                  SizedBox(
                    height: 40.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      validateForm();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreenAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(17.0),
                      child: Row(
                        children: [
                          const Text(
                            "NEXT",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                            ),
                          ),
                          Icon(Icons.arrow_forward,
                              color: Colors.white, size: 26.0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
