import 'dart:convert';

import 'package:driveridee/Globals/Global.dart';
import 'package:http/http.dart' as http;

class OnPremMethods {
  static Future<dynamic> premAcceptReject(
      String? tripId, String deriverID, String status) async {
    String url = "$premUrl/ride-app/driverStatus";
    String key =
        "Qq87PGWPscPQfzlCz4ralI7JtrGcZ6ymYxjGxxHOmTKsBPCxXxSDlZr5jjidQzi117kdaCggXtw8HQ9fS2CEsMdavclyeO4uN4D1Ymm4OTnzlGPeFFT5PPN1JEPWSS7w";
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': key,
    };

    Map Body = {"tripId": tripId, "driverId": deriverID, "status": status};
    try {
      http.Response httpResponse = await http.post(
        Uri.parse(url),
        body: jsonEncode(Body),
        headers: header,
      );
      return httpResponse;
    } catch (e) {
      return e;
    }
  }

  static Future<dynamic> premOnlineOffline(
      String deriverID, double lat, double lon, String status) async {
    String url = "$premUrl/ride-app/set";
    String key =
        "Qq87PGWPscPQfzlCz4ralI7JtrGcZ6ymYxjGxxHOmTKsBPCxXxSDlZr5jjidQzi117kdaCggXtw8HQ9fS2CEsMdavclyeO4uN4D1Ymm4OTnzlGPeFFT5PPN1JEPWSS7w";
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': key,
    };

    Map Body = {
      "type": "driver",
      "id": deriverID,
      "location": {"x": lat, "y": lon},
      "state": status
    };
    try {
      http.Response httpResponse = await http.post(
        Uri.parse(url),
        body: jsonEncode(Body),
        headers: header,
      );
      print("Succ Host" + httpResponse.body.toString());
      return httpResponse;
    } catch (e) {
      print("Host Excep " + e.toString() + "Hostend");
      return e;
    }
  }

  static Future<dynamic> getTripDetail(String tripId) async {
    String url = "$premUrl/ride-app/getTrip?tripId=$tripId";
    String key =
        "Qq87PGWPscPQfzlCz4ralI7JtrGcZ6ymYxjGxxHOmTKsBPCxXxSDlZr5jjidQzi117kdaCggXtw8HQ9fS2CEsMdavclyeO4uN4D1Ymm4OTnzlGPeFFT5PPN1JEPWSS7w";
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': key,
    };
    try {
      http.Response httpResponse = await http.get(
        Uri.parse(url),
        headers: header,
      );
      if (httpResponse.statusCode == 200) {
        return jsonDecode(httpResponse.body);
      } else {
        return 404;
      }
    } catch (e) {
      return e;
    }
  }


  static Future<dynamic> createUseronPrem(String fname, String lname,
      String phone, String email, String deviceId, String pw, String color,String model,String plate ) async {
    String url = "$premUrl/ride-app/register";
    String key =
        "Qq87PGWPscPQfzlCz4ralI7JtrGcZ6ymYxjGxxHOmTKsBPCxXxSDlZr5jjidQzi117kdaCggXtw8HQ9fS2CEsMdavclyeO4uN4D1Ymm4OTnzlGPeFFT5PPN1JEPWSS7w";
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': key,
    };

    Map Body = {
      "type": "Driver",
      "fname": fname,
      "lname": lname,
      "phone": phone,
      "email": email,
      "deviceId": deviceId,
      "pw": pw,
      "color":color,
      "model":model,
      "plate":plate
    };
    http.Response httpResponse = await http.post(
      Uri.parse(url),
      body: jsonEncode(Body),
      headers: header,
    );
    return httpResponse;
  }
}
