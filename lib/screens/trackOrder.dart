import 'package:flutter/material.dart';
import 'package:foodfinder/providerData/locationData.dart';
import 'package:foodfinder/screens/liveMapScreen.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TrackOrder extends StatelessWidget {
  static String route = "trackOrder";
  @override
  Widget build(BuildContext context) {
    var orderlocation = Provider.of<AddressData>(context).orderLocation;
    return (orderlocation.placeDetails == null)
        ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('OrderId#'),
              centerTitle: true,
            ),
            body: Center(
              child: Text("You have not palaced any order yet!"),
            ),
          )
        : WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
              //await Navigator.popAndPushNamed(context, HomePage.route);
              //Navigator.popUntil(context, (route) => route.isFirst);
              return true;
            },
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text('OrderId#50498'),
                centerTitle: true,
              ),
              body: ListView(
                  padding: EdgeInsets.only(left: 25.0, top: 15.0, right: 8.0),
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "Your Food is On the Way!",
                            style:
                                TextStyle(fontSize: 23, color: Colors.purple),
                          ),
                        ),
                        Text(orderlocation.homeTitle! +
                            ',' +
                            orderlocation.currentAddress! +
                            ',' +
                            orderlocation.placeDetails! +
                            '.'),
                        SizedBox(
                          height: 15.0,
                        ),
                        TimelineTile(
                          afterLineStyle: LineStyle(color: Colors.purple),
                          alignment: TimelineAlign.start,
                          isFirst: true,
                          indicatorStyle: const IndicatorStyle(
                            width: 18,
                            color: Colors.purple,
                            indicatorXY: 0.1,
                            //  iconStyle: IconStyle(iconData: IconDataProperty(name, value))),
                            padding: EdgeInsets.all(5),
                          ),
                          endChild: Container(
                            height: 80,
                            padding: EdgeInsets.only(left: 15, top: 5),
                            //color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Processed",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text("we are preparing your order",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ))
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          afterLineStyle: LineStyle(color: Colors.greenAccent),
                          alignment: TimelineAlign.start,
                          indicatorStyle: const IndicatorStyle(
                            width: 18,
                            color: Colors.greenAccent,
                            padding: EdgeInsets.all(5),
                            indicatorXY: 0.1,
                          ),
                          endChild: Container(
                            height: 80,
                            padding: EdgeInsets.only(left: 15, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order Confirmed",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "order has been confirmed",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          afterLineStyle: LineStyle(color: Colors.redAccent),
                          alignment: TimelineAlign.start,
                          indicatorStyle: const IndicatorStyle(
                            width: 18,
                            color: Colors.redAccent,
                            padding: EdgeInsets.all(5),
                            indicatorXY: 0.1,
                          ),
                          endChild: Container(
                            height: 80,
                            padding: EdgeInsets.only(left: 15, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Food is cooking",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                // Text(
                                //   "order has been shipped",
                                //   style: TextStyle(fontSize: 15, color: Colors.black),
                                // )
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          afterLineStyle: LineStyle(color: Colors.yellowAccent),
                          alignment: TimelineAlign.start,
                          indicatorStyle: const IndicatorStyle(
                            width: 18,
                            color: Colors.yellowAccent,
                            padding: EdgeInsets.all(5),
                            indicatorXY: 0.1,
                          ),
                          endChild: Container(
                            height: 80,
                            padding: EdgeInsets.only(left: 15, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Food is On The Way!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "Track your food on the map",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          afterLineStyle: LineStyle(color: Colors.orangeAccent),
                          alignment: TimelineAlign.start,
                          //isLast: true,
                          indicatorStyle: const IndicatorStyle(
                            width: 18,
                            color: Colors.orangeAccent,
                            padding: EdgeInsets.all(5),
                            indicatorXY: 0.1,
                          ),
                          endChild: Container(
                            height: 80,
                            padding: EdgeInsets.only(left: 15, top: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Food Delivered",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      color: Colors.black),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "oh yaa!",
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.black),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 8.0),
                          alignment: Alignment.bottomRight,
                          //color: Colors.pink,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FloatingActionButton(
                                child: Icon(Icons.map),
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.green,
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            LiveMapScreen()))),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                'Track him',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          );
  }
}
