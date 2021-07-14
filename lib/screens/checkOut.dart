import 'package:flutter/material.dart';
import 'package:foodfinder/models/addressModels.dart';
import 'package:foodfinder/providerData/locationData.dart';
import 'package:flutter_khalti/flutter_khalti.dart';
import 'package:foodfinder/screens/addOrderLocMap.dart';
import 'package:foodfinder/screens/homePage.dart';
import 'package:foodfinder/screens/trackOrder.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckOut extends StatefulWidget {
  static String route = "checkOut";
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _homeController = TextEditingController();
  TextEditingController _dirDetailController = TextEditingController();
  AddressLoc orderlocation = AddressLoc();
  String _selectedMethod = "not Selected";
  String address = 'your current address';

  setAddress(String? add) {
    if (add != null) {
      setState(() {
        address = add;
      });
      return;
    } else
      return;
  }

  // setPhNum(String? phn) {
  //   if (phn != null) {
  //     setState(() {
  //       _phoneController.text = reverseText(phn);
  //     });
  //     return;
  //   } else
  //     return;
  // }

  @override
  void dispose() {
    _phoneController.dispose();
    _homeController.dispose();
    _dirDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    orderlocation = Provider.of<AddressData>(context).orderLocation;
    setAddress(orderlocation.currentAddress);
    // setPhNum(orderlocation.phNumber);
    return Scaffold(
      appBar: AppBar(
        title: Text('CHECKOUT'),
        centerTitle: true,
      ),
      body: ListView(children: [
        SizedBox(
          height: 15.0,
        ),
        Container(
          margin: EdgeInsets.only(left: 1.0, right: 1.0),
          padding: EdgeInsets.only(left: 1.0, right: 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Delivary Address',
                style: TextStyle(
                  fontSize: 21,
                ),
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(2.0),
                  padding: const EdgeInsets.all(6.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.add,
                            size: 17,
                            color: Colors.green,
                          ),
                        ),
                        TextSpan(
                            text: " Add new Address",
                            style: TextStyle(color: Colors.green)),
                      ],
                    ),
                  ),
                ),
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => MapScreen()))),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 1.0,
        ),
        Container(
          margin: EdgeInsets.only(left: 3.0, right: 3.0),
          padding: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
//             height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
              //   color: Colors.pink, //////////////////COLOR
              ),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: 3.0, left: 3.0, right: 6.0),
              padding: EdgeInsets.only(
                  left: 20.0, top: 1.0, bottom: 3.0, right: 3.0),
              height: 58,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: const Offset(3.0, 3.0),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                  ),
                ],
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Row(children: [
                Icon(
                  FontAwesomeIcons.houseUser,
                  size: 28.0,
                  color: Colors.green,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      address,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                )
              ]),
            ),
            SizedBox(height: 15.0),
            Container(
              margin: EdgeInsets.only(top: 3.0, left: 3.0, right: 6.0),
              padding: EdgeInsets.only(left: 20.0, top: 3.0, bottom: 2.0),
              height: 55,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    offset: const Offset(3.0, 3.0),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                  ),
                ],
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(children: [
                Icon(
                  Icons.phone,
                  size: 28.0,
                  color: Colors.green,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    top: 1,
                  ),
                  child: SizedBox(
                      width: 130,
                      child: TextField(
                        controller: _phoneController,
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          counter: SizedBox.shrink(),
                          //border: OutlineInputBorder(),
                          hintText: 'Phone number *',
                          hintStyle: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        autofocus: false,
                        onChanged: (value) {
                          Provider.of<AddressData>(context, listen: false)
                              .locationOrPhone(value);
                        },
                      )),
                ),
              ]),
            ),
            SizedBox(height: 15.0),
            Container(
                margin: EdgeInsets.only(top: 3.0, left: 3.0, right: 6.0),
                // padding: EdgeInsets.all(3.0),
                padding: EdgeInsets.only(left: 20.0, top: 1.0, bottom: 7.0),
                height: 55,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: const Offset(3.0, 3.0),
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: SizedBox(
                    width: 130,
                    child: TextField(
                      controller: _homeController,
                      style: TextStyle(fontSize: 20.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Address Title e.g. Home,Office *',
                        hintStyle: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      autofocus: false,
                      onChanged: (value) {
                        Provider.of<AddressData>(context, listen: false)
                            .updateOrHomeTitle(value);
                      },
                    ))),
            SizedBox(height: 15.0),
            Container(
                margin: EdgeInsets.only(top: 3.0, left: 3.0, right: 6.0),
                // padding: EdgeInsets.all(3.0),
                padding: EdgeInsets.only(
                    left: 20.0, top: 2.0, bottom: 3.0, right: 12),
                height: 125,
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      offset: const Offset(3.0, 3.0),
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                    ),
                  ],
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: _dirDetailController,
                  keyboardType: TextInputType.multiline,
                  minLines: 1, //Normal textInputField will be displayed
                  maxLines: 8,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Direction Details *',
                    hintStyle: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  autofocus: false,
                  onChanged: (value) {
                    Provider.of<AddressData>(context, listen: false)
                        .locationOrDirection(value);
                  },
                )),
            SizedBox(
              ////////////////////////////////////Here Starts
              height: 15.0,
            ),
            Container(
              margin: EdgeInsets.only(
                right: 200.0,
                top: 8.0,
              ),
              child: Text(
                'Payment Method',
                style: TextStyle(fontSize: 21, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5.0,
                ),
                InkWell(
                  onTap: () {
                    if (_selectedMethod == "Cash") {
                      setState(() {
                        _selectedMethod = "not Selected";
                      });
                    } else {
                      setState(() {
                        _selectedMethod = "Cash";
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(3.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: const Offset(3.0, 3.0),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                      color: Colors.white,
                      border: Border.all(
                        width: 2.0,
                        color: _selectedMethod == "Cash"
                            ? Colors.blue
                            : Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(bottom: 4.0),
                              constraints: BoxConstraints.expand(
                                height: 70,
                              ),
                              child: Image.asset(
                                  'assets/images/cashOnDelivery.jpg')),
                          Text(
                            'Cash on Delivery',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                InkWell(
                  onTap: () {
                    if (_selectedMethod == "Khalti") {
                      setState(() {
                        _selectedMethod = "not Selected";
                      });
                    } else {
                      setState(() {
                        _selectedMethod = "Khalti";
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(3.0),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: const Offset(3.0, 3.0),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                      color: Colors.white,
                      border: Border.all(
                          width: 2.0,
                          color: _selectedMethod == "Khalti"
                              ? Colors.blue
                              : Colors.white),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 4.0),
                            padding: EdgeInsets.only(
                              right: 2.0,
                            ),
                            constraints: BoxConstraints.expand(
                              height: 70,
                            ),
                            child: Image.asset('assets/images/khalti.jpg'),
                          ),
                          Text(
                            'Khalti',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 2.0,
                primary: Colors.green,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
              ),
              child: Text(
                'PAYMENT',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: makePayment,
            ),

            ///here Ends///////////////////////////////////////////
          ]),
        )
      ]),
    );
  }

  //////////////////////////////////////////////////////////////////////////
  /////////////////// PAYMENT WITH KHALTI
  _payViaKhalti() async {
    double amount = double.parse(orderlocation.homeTitle!.trim()) * 100;
    FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
      publicKey: "test_public_key_28c6104e8a064d74b9edb37320f5e2dd",
      urlSchemeIOS: "KhaltiPayFlutterExampleScheme",
      paymentPreferences: [
        KhaltiPaymentPreference.KHALTI,
      ],
    );
    KhaltiProduct product = KhaltiProduct(
      id: "test",
      amount: amount,
      name: "Hello Product",
    );
    _flutterKhalti.startPayment(
      product: product,
      onSuccess: (data) async {
        print("Your Khalti Payment is Successfull!");
        await showSuccessDialog();
      },
      onFaliure: (error) {
        print("sorry, Payment Failure!");
      },
    );
  }

/////////////////////////////////////////////////////
//////////////// CHOOSE CASH ON DELIVERY OR THROUGH KHALTI
  ///

  makePayment() async {
    if (_phoneController.text.length == 10 &&
        _homeController.text.isNotEmpty &&
        _dirDetailController.text.isNotEmpty &&
        address != 'your current address') {
      if (_selectedMethod == "Cash") {
        print("payment Cash On Delivery");
        await showSuccessDialog();
      } else if (_selectedMethod == "Khalti") {
        _payViaKhalti();
        print("payment Through Khalti");
      } else if (_selectedMethod == "not Selected") {
        print("Not selected any of the Method!");
      }
    } else
      print('Please Fill the firm!');
    return;
  }

  showSuccessDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(
                'Congratulations!',
                style: TextStyle(color: Colors.green),
              ),
              content: Text(
                'Your order has been successfully placed.Track your order now.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(TrackOrder.route,
                          ModalRoute.withName(HomePage.route)),
                  // onPressed: () => Navigator.of(context).pushNamed(
                  //   TrackOrder.route,
                  // ),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
