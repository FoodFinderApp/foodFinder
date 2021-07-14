import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodfinder/AllWidgets/dialog.dart';
import 'package:foodfinder/AllWidgets/disDuration.dart';
import 'package:foodfinder/assistance/directions_repository.dart';
import 'package:foodfinder/models/addressModels.dart';
import 'package:foodfinder/models/deliveryBoyModel.dart';
import 'package:foodfinder/models/directions_model.dart';
import 'package:foodfinder/providerData/locationData.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LiveMapScreen extends StatefulWidget {
  //final BoyLocationApi api = BoyLocationApi();
  @override
  _LiveMapScreenState createState() => _LiveMapScreenState();
}

class _LiveMapScreenState extends State<LiveMapScreen> {
  late DeliveryBoyModel deliveryBoy;

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(28.209376, 83.967466),
    zoom: 14.5,
  );

  //StreamSubscription subscription;
  late GoogleMapController _googleMapController;
  late AddressLoc orderPos;
  late AddressLoc restPos;
  Directions? _info;
  Set<Marker> _markers = {};

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  // Future<Uint8List> getMarker() async {
  //   ByteData byteData =
  //       await DefaultAssetBundle.of(context).load("assets/icons/delivery.png");
  //   return byteData.buffer.asUint8List();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   widget.api.getCurrentLocation().then((data) async {
  //     Uint8List imageData = await getMarker();
  //     setState(() {
  //       deliveryBoy = data;
  //       // if (_markers.contains(MarkerId(deliveryBoy.id))) {
  //       //   _markers.remove(MarkerId(deliveryBoy.id));
  //       // }
  //       _markers.add(
  //         Marker(
  //           markerId: MarkerId('${deliveryBoy.id}'),
  //           position: LatLng(deliveryBoy.latitude, deliveryBoy.longitude),
  //           icon: BitmapDescriptor.fromBytes(imageData),
  //         ),
  //       );
  //     });
  //   });
  // }

  void _onMapCreated(GoogleMapController controller) async {
    _googleMapController = controller;
    final Uint8List imageData =
        await getBytesFromAsset("assets/icons/deliveryBoy.png", 120);
    //final Uint8List imageData = await getMarker();
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('${deliveryBoy.id}'),
          position: LatLng(deliveryBoy.latitude!, deliveryBoy.longitude!),
          icon: BitmapDescriptor.fromBytes(imageData),
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId('${orderPos.orderId}'),
          infoWindow: InfoWindow(
              title: '${orderPos.homeTitle}',
              snippet: '${orderPos.placeDetails}'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: LatLng(orderPos.latitude!, orderPos.longitude!),
        ),
      );
      // _markers.add(Marker(
      //   markerId: MarkerId('${finalPos.placeId}'),
      //   infoWindow: InfoWindow(
      //       title: '${finalPos.placeId}', snippet: '${finalPos.placeDetails}'),
      //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      //   position: LatLng(finalPos.latitude, finalPos.longitude),
      // ));
    });
    _getDirectionDetails();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    //subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orderPos = Provider.of<AddressData>(context, listen: false).orderLocation;
    restPos =
        Provider.of<AddressData>(context, listen: false).restaurantLocation;
    deliveryBoy = Provider.of<AddressData>(context, listen: false).boyCurrent;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: const Text(
            'Your Food is on the Way',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              initialCameraPosition: _initialCameraPosition,
              markers: _markers,
              onMapCreated: _onMapCreated,
              polylines: {
                if (_info != null)
                  Polyline(
                    polylineId: const PolylineId('overview_polyline'),
                    color: Colors.red,
                    width: 5,
                    points: _info!.polylinePoints!
                        .map((e) => LatLng(e.latitude, e.longitude))
                        .toList(),
                  ),
              },
            ),
            if (_info != null) DisDuration(info: _info),
          ],
        ),
      ),
    );
  }

  void _getDirectionDetails() async {
    var orderedLoc = LatLng(orderPos.latitude!, orderPos.longitude!);
    var restautantLoc = LatLng(restPos.latitude!, restPos.longitude!);
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(message: "wait...."));
    // Get directions
    final directions = await DirectionsRepository()
        .getDirections(origin: orderedLoc, destination: restautantLoc);
    if (directions != null) {
      setState(() => _info = directions);
      _googleMapController.animateCamera(CameraUpdate.newLatLngBounds(
        _info!.bounds!,
        100.0,
      ));
      Navigator.pop(context);
      return;
    } else
      Navigator.pop(context);
    return;
  }
}
