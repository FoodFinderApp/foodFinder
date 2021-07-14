import 'package:flutter/material.dart';
import 'package:foodfinder/screens/checkOut.dart';
import 'package:foodfinder/screens/trackOrder.dart';

class HomePage extends StatelessWidget {
  static String route = "/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FoodFinder'),
      ),
      body: Column(children: <Widget>[
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 2.0,
              shape: StadiumBorder(),
              primary: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            ),
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: ((context) => CheckOut()))),
            child: Text('CART')),
        SizedBox(
          height: 25,
        ),
        // ignore: deprecated_member_use
        RaisedButton(
            color: Colors.blue,
            child: Text(
              "TRACK ORDER",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.pushNamed(context, TrackOrder.route);
            })
      ]),
    );
  }
}
