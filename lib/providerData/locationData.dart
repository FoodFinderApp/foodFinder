import 'package:flutter/material.dart';
import 'package:foodfinder/models/addressModels.dart';
import 'package:foodfinder/models/deliveryBoyModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressData extends ChangeNotifier {
  AddressLoc orderLocation = AddressLoc();
  //AddressLoc restaurantLocation = AddressLoc();
  AddressLoc restaurantLocation = AddressLoc(
      homeTitle: 'damside_Restaurant',
      placeDetails: 'someWhere near',
      orderId: 'damview2',
      latitude: 28.199416,
      longitude: 83.970150);
  DeliveryBoyModel boyCurrent = DeliveryBoyModel(
      id: '#37',
      name: 'BaBu Bhai',
      contact: '9834612389',
      latitude: 28.199416,
      longitude: 83.970150);

  void updateOrCoordinates(LatLng loc) async {
    orderLocation.latitude = loc.latitude;
    orderLocation.longitude = loc.longitude;
    notifyListeners();
  }

  void updateOrAddress(String adr) {
    orderLocation.currentAddress = adr;
  }

  void updateOrHomeTitle(String home) {
    orderLocation.homeTitle = home;
    notifyListeners();
  }

  void locationOrDirection(String dir) {
    orderLocation.placeDetails = dir;
    notifyListeners();
  }

  void locationOrPhone(String ph) {
    orderLocation.phNumber = ph;
    notifyListeners();
  }

  void updateOrderLocationAddress(AddressLoc orderAddress) {
    orderLocation = orderAddress;
    notifyListeners();
  }

  void updateRestaurantLocationAddress(AddressLoc restaurantAddress) {
    restaurantLocation = restaurantAddress;
    notifyListeners();
  }
}
