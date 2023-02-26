// import 'dart:js';

import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:driveridee/Globals/Global.dart';
import 'package:driveridee/Helpers/onPremHelpers.dart';
import 'package:driveridee/Models/UserRideRequestInfo.dart';
import 'package:driveridee/Widgets/NotificationDialogBox.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PushNotifServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeFCM(BuildContext context) async {
    // Terminated
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //display ride request information - user information who request a ride
        readUserRideRequestInformation(
            remoteMessage.data["rideRequestId"], context);
      }
    });

    //2. Foreground
    //When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      //display ride request information - user information who request a ride
      readUserRideRequestInformation(
          remoteMessage!.data["rideRequestId"], context);
    });

    //3. Background
    //When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      //display ride request information - user information who request a ride
      readUserRideRequestInformation(
          remoteMessage!.data["rideRequestId"], context);
    });
  }

  readUserRideRequestInformation(
      String userRideRequestId, BuildContext context) async {
    print("#####here######");
    var response = await OnPremMethods.getTripDetail(userRideRequestId);

    if (response != 404) {
      audioPlayer.open(Audio("sounds/music_notification.mp3"));
      audioPlayer.play();
      double originLat = double.parse(response["tripDetail"]["from"]["x"]);
      double originLng = double.parse(response["tripDetail"]["from"]["y"]);
      String originAddress = response["tripDetail"]["from"]["name"];

      double destinationLat = double.parse(response["tripDetail"]["to"]["x"]);
      double destinationLng = double.parse(response["tripDetail"]["to"]["x"]);
      String destinationAddress = response["tripDetail"]["to"]["name"];

      String userName = response["passenger"]["name"];
      String userPhone = response["passenger"]["phone"];

      UserRideRequestInformation userRideRequestDetails =
          UserRideRequestInformation();

      userRideRequestDetails.originLatLng = LatLng(originLat, originLng);
      userRideRequestDetails.originAddress = originAddress;

      // String? rideRequestId = response.snapshot.key;

      userRideRequestDetails.destinationLatLng =
          LatLng(destinationLat, destinationLng);
      userRideRequestDetails.destinationAddress = destinationAddress;

      userRideRequestDetails.userName = userName;
      userRideRequestDetails.userPhone = userPhone;

      userRideRequestDetails.rideRequestId = response["tripId"];

      userRideRequestDetails.rideRequestId = response["tripId"];
      ;
      globalRideRequestId = response["tripId"];
      ;
      showDialog(
        context: context,
        builder: (BuildContext context) => NotificationDialogBox(
          userRideRequestDetails: userRideRequestDetails,
        ),
      );
    } else {
      Fluttertoast.showToast(msg: "This Ride Request Id do not exists.");
    }
  }

  Future generateAndGetToken() async {
    String? registrationToken = await messaging.getToken();
    print("FCM Registration Token: ");
    print(registrationToken);

    FirebaseDatabase.instance
        .ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("token")
        .set(registrationToken);

    messaging.subscribeToTopic("allDrivers");
    messaging.subscribeToTopic("allUsers");
  }
}
