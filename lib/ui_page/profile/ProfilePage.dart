import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_news_app/constant/ConstantFile.dart';
import 'package:flutter_news_app/utils/SessionManager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'UpdateProfile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String myId, myEmail, myName, myPhoto;
  SessionManager sessionManager = SessionManager();
  LatLng myLocation;
  Timer _timer;
  final Map<String, Marker> _marker = {};

  void getCurrentLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _marker.clear();
      final myMarker = Marker(
          markerId: MarkerId("My Position"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          infoWindow: InfoWindow(title: "My Location", snippet: "Udacoding"));
      _marker['Current Location'] = myMarker;
      myLocation = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    print("Lat : ${currentLocation.latitude}");
    print("Lon : ${currentLocation.longitude}");
  }

  void periodicMethod() async {
    _timer = Timer.periodic(Duration(seconds: 2), (test) async {
      if (this.mounted) {
        setState(() {
          getCurrentLocation();
          print("Get Location Ke ${test.tick}");
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer.cancel();
    periodicMethod();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    periodicMethod();
    sessionManager.getPreference().then((value) {
      setState(() {
        myId = sessionManager.globIduser;
        myEmail = sessionManager.globEmail;
        myName = sessionManager.globName;
        myPhoto = sessionManager.globPhoto;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    width: 120,
                    height: 120,
                    child: CircleAvatar(
                      radius: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: myPhoto == null
                            ? Center()
                            : Image.network(
                                ConstantFile().imageUrl + myPhoto,
                                fit: BoxFit.fill,
                                width: 120,
                                height: 120,
                              ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 16, left: 32, right: 32, bottom: 16),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 6,
                    child: Card(

                      elevation: 7,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                            leading: Icon(
                              Icons.person,
                              size: 45,
                            ),
                            title: Text(
                              myName == null ? "" : myName,
                              style: TextStyle(fontSize: 20),
                            )),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                            size: 45,
                          ),
                          title: Text(
                            myEmail == null ? "" : myEmail,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("Latitude : ${myLocation.latitude}"),
                  Text("Longitude : ${myLocation.longitude}"),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16, bottom: 16, left: 32, right: 32),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: myLocation == null
                                ? LatLng(-6.1753924, 106.8249641)
                                : myLocation,
                            zoom: 11.0),
                        markers: _marker.values.toSet(),
                        gestureRecognizers:
                            <Factory<OneSequenceGestureRecognizer>>[
                          Factory<OneSequenceGestureRecognizer>(
                            () => ScaleGestureRecognizer(),
                          )
                        ].toSet(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: RaisedButton(
                        color: Colors.red,
                        child: Text(
                          "Update Profile",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateProfile(
                                        id: myId,
                                        name: myName,
                                        email: myEmail,
                                        photo: myPhoto,
                                      )));
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
