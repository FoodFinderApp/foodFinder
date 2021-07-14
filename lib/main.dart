import 'package:flutter/material.dart';
import 'package:foodfinder/providerData/locationData.dart';
import 'package:foodfinder/screens/checkOut.dart';
import 'package:foodfinder/screens/homePage.dart';
import 'package:foodfinder/screens/trackOrder.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AddressData())],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: "foodFinder",
        initialRoute: HomePage.route,
        //home: HomePage(),
        routes: {
          HomePage.route: (_) => HomePage(),
          CheckOut.route: (_) => CheckOut(),
          TrackOrder.route: (_) => TrackOrder(),
        },
      ),
    );
  }
}
