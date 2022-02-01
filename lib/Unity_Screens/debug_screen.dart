import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:hexAr/Widget/CircularButton.dart';
import 'package:location/location.dart';

class DebugScreen extends StatefulWidget {
  DebugScreen({Key key}) : super(key: key);

  @override
  _DebugScreen createState() => _DebugScreen();
}

class _DebugScreen extends State<DebugScreen> with SingleTickerProviderStateMixin{
  UnityWidgetController _unityWidgetController;
  double position_x = 0.0, position_y = 0.0,position_z = 0.0,rotation_x = 0.0,rotation_y = 0.0,rotation_z = 0.0,scale = 1.0;
  double latitude = 21.0100917816162, longitude = 105.851005554199, altitude = 0.0;
  bool isPause = false;
  AnimationController animationController;
  Animation degOneTranslationAnimation,degTwoTranslationAnimation,degThreeTranslationAnimation;
  Animation rotationAnimation, _animation;

  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  bool _isListenLocation = false;


  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double >(begin: 0.0,end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.2,end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double >(begin: 0.0,end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.4,end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween<double >(begin: 0.0,end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(tween: Tween<double>(begin: 1.75,end: 1.0), weight: 65.0),
    ]).animate(animationController);
    _animation = Tween<double>(begin: 0.0,end: 1.0).animate(animationController);
    rotationAnimation = Tween<double>(begin: 0.0,end: 0.0).animate(CurvedAnimation(parent: animationController
        , curve: Curves.easeOut));
    super.initState();
    // getCurrentLocation();
    // _determinePosition();
    animationController.addListener((){
      setState(() {

      });
    });
  }

  // Future<Position> _determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //
  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }
  //
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }
  //
  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }
  //
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   Position position = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high
  //   );
  // }

  // getCurrentLocation() async {
  //   final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   setState(() {
  //     latitudeData = '${geoposition.latitude}';
  //     longtitudeData = '${geoposition.longitude}';
  //   });
  // }

  @override
  void dispose() {
    _unityWidgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        margin: const EdgeInsets.all(0),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Stack(
          children: [
            Container(
              child: UnityWidget(
                onUnityCreated: onUnityCreated,
                onUnityMessage: onUnityMessage,
                onUnitySceneLoaded: onUnitySceneLoaded,
                fullscreen: false,
                borderRadius: BorderRadius.circular(0),
              ),
            ),
            // Positioned(
            //   child: Stack(
            //     children: [
            //       Transform.translate(
            //         offset: Offset.fromDirection(90,degOneTranslationAnimation.value * 0),
            //       child: Container(
            //         transform: Matrix4.rotationZ(0)..scale(degOneTranslationAnimation.value),
            //           height: 185.0,
            //           // color: Color.fromRGBO(0, 255, 0, 1.0),
            //           child:
            //           ListView(
            //             scrollDirection: Axis.horizontal,
            //             children: <Widget>[
            //               Padding(
            //                 padding: const EdgeInsets.fromLTRB(20, 50, 10, 10),
            //                 child: _CreateRoomButton(),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            //                 child: _CreateRoomButton(),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            //                 child: _CreateRoomButton(),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            //                 child: _CreateRoomButton(),
            //               ),
            //               Padding(
            //                 padding: const EdgeInsets.fromLTRB(10, 50, 20, 10),
            //                 child: _CreateRoomButton(),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Positioned(
            //   top: 50,
            //   left: 20,
            //   child:
            //     Column(
            //       children: [
            //         ElevatedButton(
            //             onPressed: () async{
            //               _serviceEnabled = await location.serviceEnabled();
            //               print(location.serviceEnabled());
            //               if (!_serviceEnabled) {
            //                 _serviceEnabled = await location.requestService();
            //                 if (!_serviceEnabled) {
            //                   return;
            //                 }
            //               }
            //               print(location.serviceEnabled());
            //
            //               _permissionGranted = await location.hasPermission();
            //               print(location.hasPermission());
            //
            //               if (_permissionGranted == PermissionStatus.denied) {
            //                 _permissionGranted = await location.requestPermission();
            //                 if (_permissionGranted != PermissionStatus.granted) {
            //                   return;
            //                 }
            //               }
            //               print('4');
            //
            //               setState(() {
            //                 _isListenLocation = true;
            //               });
            //             },
            //             child: Text(
            //               'Listen location',
            //               style: TextStyle(color: Colors.white, fontSize: 14),
            //             ),
            //         ),
            //         StreamBuilder(
            //           stream: location.onLocationChanged.map(
            //           (_locationData) {
            //             print('${_locationData.latitude}, ${_locationData.longitude}');
            //             setCurrentLatitude('${_locationData.latitude}');
            //             setCurrentLongitude('${_locationData.longitude}');
            //           }
            //           ),
            //           builder: (context, snapshot) {
            //             if(snapshot.connectionState != ConnectionState.waiting)
            //             {
            //               var data = snapshot.data as LocationData;
            //               return Text(
            //                 'Location always change: ${data}',
            //                 style: TextStyle(color: Colors.white, fontSize: 14),
            //               );
            //             }
            //             else {
            //                 return Center(
            //                 child: CircularProgressIndicator()
            //                 );
            //               }
            //             }
            //         ),
            //       ],
            //     ),
            // ),
            Positioned(
              top: 50,
              left: 75,
              child: Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(180),degOneTranslationAnimation.value * 70),
                child: Transform(
                  transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTranslationAnimation.value),
                  alignment: Alignment.center,
                  child:Card(
                    elevation: 10,
                    color: Color.fromRGBO(0, 0, 0, 0.3),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text("Location:", style: TextStyle(color: Colors.white)),
                        ),
                        Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text("Latitude: ", style: TextStyle(color: Colors.white)),
                              ),
                              SizedBox(
                                width: 180,
                                child: Slider(
                                  onChanged: (value) {
                                    setState(() {
                                      latitude = value;
                                    });
                                    setLatitude(value.toString());
                                  },
                                  activeColor: Colors.white,
                                  value: latitude,
                                  min: 21.01,
                                  max: 21.02,
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: Text(latitude.toStringAsPrecision(8), style: TextStyle(color: Colors.white)),
                              ),
                            ]
                        ),
                        Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text("Longitude: ", style: TextStyle(color: Colors.white)),
                              ),
                              SizedBox(
                                width: 180,
                                child: Slider(
                                  onChanged: (value) {
                                    setState(() {
                                      longitude = value;
                                    });
                                    setLongitude(value.toString());
                                  },
                                  activeColor: Colors.white,
                                  value: longitude,
                                  min: 105.8,
                                  max: 105.9,
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: Text(longitude.toStringAsPrecision(8), style: TextStyle(color: Colors.white)),
                              ),
                            ]
                        ),
                        Row(
                            children: [
                              SizedBox(
                                width: 80,
                                child: Text("Altitude: ", style: TextStyle(color: Colors.white)),
                              ),
                              SizedBox(
                                width: 180,
                                child: Slider(
                                  onChanged: (value) {
                                    setState(() {
                                      altitude = value;
                                    });
                                    setAltitude(value.toString());
                                  },
                                  activeColor: Colors.white,
                                  value: altitude,
                                  min: 0,
                                  max: 200,
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: Text(altitude.toStringAsPrecision(8), style: TextStyle(color: Colors.white)),
                              ),
                            ]
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("Position:", style: TextStyle(color: Colors.white),),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: Slider(
                                onChanged: (value) {
                                  setState(() {
                                    position_x = value;
                                  });
                                  setPositionX(value.toString());
                                },
                                activeColor: Colors.white,
                                value: position_x,
                                min: -1000,
                                max: 1000,
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Slider(
                                onChanged: (value) {
                                  setState(() {
                                    position_y = value;
                                  });
                                  setPositionY(value.toString());
                                },
                                activeColor: Colors.white,
                                value: position_y,
                                min: -1000,
                                max: 1000,
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Slider(
                                onChanged: (value) {
                                  setState(() {
                                    position_z = value;
                                  });
                                  setPositionZ(value.toString());
                                },
                                activeColor: Colors.white,
                                value: position_z,
                                min: -1000,
                                max: 1000,
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Center(
                                  child: Text(position_x.toStringAsPrecision(5), style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Center(
                                  child: Text(position_y.toStringAsPrecision(5), style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Center(
                                  child: Text(position_z.toStringAsPrecision(5), style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ]
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text("Rotation:", style: TextStyle(color: Colors.white)),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: Slider(
                                onChanged: (value) {
                                  setState(() {
                                    rotation_x = value;
                                  });
                                  setRotationX(value.toString());
                                },
                                activeColor: Colors.white,
                                value: rotation_x,
                                min: 0,
                                max: 360,
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Slider(
                                onChanged: (value) {
                                  setState(() {
                                    rotation_y = value;
                                  });
                                  setRotationY(value.toString());
                                },
                                activeColor: Colors.white,
                                value: rotation_y,
                                min: 0,
                                max: 360,
                              ),
                            ),
                            SizedBox(
                              width: 120,
                              child: Slider(
                                onChanged: (value) {
                                  setState(() {
                                    rotation_z = value;
                                  });
                                  setRotationZ(value.toString());
                                },
                                activeColor: Colors.white,
                                value: rotation_z,
                                min: 0,
                                max: 360,
                              ),
                            ),
                          ],
                        ),
                        Row(
                            children: [
                              SizedBox(
                                width: 120,
                                child: Center(
                                  child: Text(rotation_x.toStringAsPrecision(5), style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Center(
                                  child: Text(rotation_y.toStringAsPrecision(5), style: TextStyle(color: Colors.white)),
                                ),
                              ),
                              SizedBox(
                                width: 120,
                                child: Center(
                                  child: Text(rotation_z.toStringAsPrecision(5), style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ]
                        ),
                        Row(
                            children: [
                              SizedBox(
                                width: 60,
                                child: Text("Scale:", style: TextStyle(color: Colors.white)),
                              ),
                              SizedBox(
                                width: 180,
                                child: Slider(
                                  onChanged: (value) {
                                    setState(() {
                                      scale = value;
                                    });
                                    setScale(value.toString());
                                  },
                                  activeColor: Colors.white,
                                  value: scale,
                                  min: 0,
                                  max: 5,
                                ),
                              ),
                              SizedBox(
                                width: 80,
                                child: Text(scale.toStringAsPrecision(5), style: TextStyle(color: Colors.white)),
                              ),
                            ]
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 20,
                right: 20,
                child:
                Transform(
                  transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value)),
                  alignment: Alignment.center,
                  child: CircularButton(
                    color: Color.fromRGBO(0, 0, 0, 0.0),
                    width: 60,
                    height: 60,
                    icon: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onClick: (){
                      if (animationController.isCompleted) {
                        animationController.reverse();
                      } else {
                        animationController.forward();
                      }
                    },
                  ),
                )
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child:
              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(180),degOneTranslationAnimation.value * 70),
                child: Transform(
                  transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degOneTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: CircularButton(
                    color: Colors.orangeAccent,
                    width: 60,
                    height: 60,
                    icon: Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    onClick: (){
                      print('Third Button');
                      _unityWidgetController.quit();
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child:
              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(180),degTwoTranslationAnimation.value * 140),
                child: Transform(
                  transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degTwoTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: CircularButton(
                    color: Colors.orangeAccent,
                    width: 60,
                    height: 60,
                    icon: Icon(
                      Icons.pause,
                      color: Colors.white,
                    ),
                    onClick: (){
                      if (isPause) {
                        print('resume');
                        _unityWidgetController.resume();
                        isPause = false;
                      } else {
                        print('pause');
                        _unityWidgetController.pause();
                        isPause = true;

                      }
                    },
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child:
              Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(180),degThreeTranslationAnimation.value * 210),
                child: Transform(
                  transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation.value))..scale(degThreeTranslationAnimation.value),
                  alignment: Alignment.center,
                  child: CircularButton(
                    color: Colors.orangeAccent,
                    width: 60,
                    height: 60,
                    icon: Icon(
                      Icons.camera ,
                      color: Colors.white,
                    ),
                    onClick: (){
                      print('First Button');
                      _unityWidgetController.pause();
                      _unityWidgetController.openInNativeProcess();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void setPositionX(String position) {
    _unityWidgetController.postMessage(
      'GPS',
      'setPositionX',
      position,
    );
  }
  void setPositionY(String position) {
    _unityWidgetController.postMessage(
      'GPS',
      'setPositionY',
      position,
    );
  }
  void setPositionZ(String position) {
    _unityWidgetController.postMessage(
      'GPS',
      'setPositionZ',
      position,
    );
  }
  void setRotationX(String rotation) {
    _unityWidgetController.postMessage(
      'GPS',
      'setRotationX',
      rotation,
    );
  }
  void setRotationY(String rotation) {
    _unityWidgetController.postMessage(
      'GPS',
      'setRotationY',
      rotation,
    );
  }
  void setRotationZ(String rotation) {
    _unityWidgetController.postMessage(
      'GPS',
      'setRotationZ',
      rotation,
    );
  }
  void setScale(String scale) {
    _unityWidgetController.postMessage(
      'GPS',
      'setScale',
      scale,
    );
  }

  void setLatitude(String latitude) {
    _unityWidgetController.postMessage(
      'GPS 5 min',
      'setLatitude',
      latitude,
    );
  }
  void setLongitude(String longitude) {
    _unityWidgetController.postMessage(
      'GPS 5 min',
      'setLongitude',
      longitude,
    );
  }
  void setAltitude(String altitude) {
    _unityWidgetController.postMessage(
      'GPS 5 min',
      'setAltitude',
      altitude,
    );
  }

  void onUnityMessage(message) {
    print('Received message from unity: ${message.toString()}');
  }

  void onUnitySceneLoaded(SceneLoaded scene) {
    print('Received scene loaded from unity: ${scene.name}');
    print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
  }
}



class _CreateRoomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        borderRadius: BorderRadius.circular(30),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: InkWell(
          splashColor: Colors.black45,
          onTap: () => print('scene'),
          child: Column(
            // mainAxisAlignment: MainAxisSize.min,
            children: [
              Ink.image(
                image: NetworkImage(
                    "https://scontent.fhan2-3.fna.fbcdn.net/v/t39.30808-6/257806154_1304809436632593_5544268618515568260_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=oZk5QDXiNYoAX-NsCk4&tn=gL_fe3OQHx5hr7J6&_nc_ht=scontent.fhan2-3.fna&oh=a7f572d1e8a3fc81361de15e829f18e9&oe=61A5D4EF"
                ),
                height: 125,
                width: 100,
                fit: BoxFit.cover,
              ),
            ],
          ),
        )
    );
  }
}
