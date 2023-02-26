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
    http.Response httpResponse = await http.post(
      Uri.parse(url),
      body: jsonEncode(Body),
      headers: header,
    );
    return httpResponse;
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
    http.Response httpResponse = await http.post(
      Uri.parse(url),
      body: jsonEncode(Body),
      headers: header,
    );
    return httpResponse;
  }

  static Future<dynamic> getTripDetail(String tripId) async {
    String url = "$premUrl/ride-app/getTrip?tripId=$tripId";
    String key =
        "Qq87PGWPscPQfzlCz4ralI7JtrGcZ6ymYxjGxxHOmTKsBPCxXxSDlZr5jjidQzi117kdaCggXtw8HQ9fS2CEsMdavclyeO4uN4D1Ymm4OTnzlGPeFFT5PPN1JEPWSS7w";
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': key,
    };

    http.Response httpResponse = await http.get(
      Uri.parse(url),
      headers: header,
    );
    if (httpResponse.statusCode == 200) {
      return jsonDecode(httpResponse.body);
    } else {
      return 404;
    }
  }
}
