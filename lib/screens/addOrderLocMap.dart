import 'package:flutter/material.dart';
import 'package:foodfinder/providerData/locationData.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:provider/provider.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late loc.LocationData _currentLocation;
  late String searchAddr;
  String? _resultAddress;
  List<Marker> myMarker = [];
  late GoogleMapController _googleMapController;
  loc.Location location = loc.Location();

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  getSetAddress(lati, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lati, long);
    Placemark placeMark = placemarks[0];
    String? name = placeMark.name;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    String address =
        "$name, $subLocality, $locality, $administrativeArea $postalCode, $country";

    Provider.of<AddressData>(context, listen: false)
        .updateOrCoordinates(LatLng(lati, long));
    Provider.of<AddressData>(context, listen: false).updateOrAddress(address);
    setState(() {
      _resultAddress = address;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              zoomControlsEnabled: false,
              markers: Set.from(myMarker),
              onMapCreated: (controller) => _googleMapController = controller,
              initialCameraPosition: CameraPosition(
                target: LatLng(28.197372, 83.971508),
                zoom: 14,
              ),
              onTap: _handleTap,
            ),
            Positioned(
              top: 30.0,
              right: 15.0,
              left: 15.0,
              child: Container(
                height: 50.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.green),
                child: TextField(
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                  decoration: InputDecoration(
                      hintText: 'Enter Address',
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 15.0, left: 15.0),
                      suffixIcon: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.search),
                        onPressed: searchAndNavigate,
                        iconSize: 30.0,
                      )),
                  onChanged: (val) {
                    setState(() {
                      searchAddr = val;
                    });
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2.0,
                    shape: StadiumBorder(),
                    primary: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                  ),
                  onPressed: () {
                    _sendAddressBack(context);
                  },
                  child: Text(
                    'SET LOCATION',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            ////here goes get current loction
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () {
            getCurrentLocation();
          },
          child: const Icon(Icons.location_searching),
        ),
      ),
    );
  }

  searchAndNavigate() async {
    try {
      List<Location> locations = await locationFromAddress(searchAddr);
      Location lok = locations[0];
      _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lok.latitude, lok.longitude),
          zoom: 18.0,
          bearing: 45.0,
        ),
      ));
    } catch (e) {
      print("Error occured: $e");
    }
  }

  Future<bool> _requestPop() {
    if (_resultAddress != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: Text('Discard your changes?'),
          content: Text(''),
          actions: <Widget>[
            TextButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('DISCARD'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  _handleTap(LatLng tappedPoint) {
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
          draggable: true,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          onDragEnd: (dragEndPosition) {
            print(dragEndPosition);
          }));
      //Converting LatLng to Address
      getSetAddress(tappedPoint.latitude, tappedPoint.longitude);
    });
  }

  void _sendAddressBack(BuildContext context) {
    if (_resultAddress != null) {
      Navigator.pop(context);
    }
  }

  ///////////////////////USER CURRENT LOCATION
  getCurrentLocation() async {
    bool _serviceEnabled;
    loc.PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == loc.PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != loc.PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await location.getLocation();
    LatLng curretPos =
        LatLng(_currentLocation.latitude!, _currentLocation.longitude!);
    _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: curretPos, zoom: 18.0)));

    if (mounted) {
      setState(() {
        myMarker = [];
        myMarker.add(Marker(
            markerId: MarkerId(curretPos.toString()),
            position: curretPos,
            draggable: true,
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
            onDragEnd: (dragEndPosition) {
              print(dragEndPosition);
            }));

        //Converting LatLng to Address
        getSetAddress(_currentLocation.latitude, _currentLocation.longitude);
      });
    }
  }
}
