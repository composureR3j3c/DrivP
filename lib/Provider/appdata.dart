import 'package:flutter/foundation.dart';
import '../Models/address.dart';

class AppData extends ChangeNotifier {
  Address? userPickUpLocation, dropOffLocation;

  void updatePickUpLocationAddress(Address userPickUpAddress) {
    userPickUpLocation = userPickUpAddress;
    notifyListeners();
  }

  void updateDropOffLocation(Address dropOffAddress) {
    dropOffLocation = dropOffAddress;
    notifyListeners();
  }
}
