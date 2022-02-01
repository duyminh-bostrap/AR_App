import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:hexAr/Widget/CircularButton.dart';
import 'package:hexAr/Widget/select_effect_button.dart';
import 'package:location/location.dart';


class UnityScreen extends StatefulWidget {
  UnityScreen({Key key}) : super(key: key);

  @override
  _UnityScreenState createState() => _UnityScreenState();
}

class _UnityScreenState extends State<UnityScreen> with SingleTickerProviderStateMixin{
  UnityWidgetController _unityWidgetController;
  double position_x = 0.0, position_y = 0.0,position_z = 0.0,rotation_x = 0.0,rotation_y = 0.0,rotation_z = 0.0,scale = 1.0;
  double latitude = 21.0100917816162, longitude = 105.851005554199, altitude = 0.0;
  bool isPause = false;
  AnimationController animationController;
  Animation degOneTranslationAnimation,degTwoTranslationAnimation,degThreeTranslationAnimation;
  Animation rotationAnimation, rotationAnimation2, _animation;


  Location location = new Location();


  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 250));
    // degOneTranslationAnimation = TweenSequenceItem<double>(tween: Tween<double >(begin: 0.0,end: 1.2), weight: 75.0),.animate(animationController);
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
    rotationAnimation = Tween<double>(begin: 0.0,end: 180.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    rotationAnimation2 = Tween<double>(begin: 0.0,end: 0.0).animate(CurvedAnimation(parent: animationController, curve: Curves.easeOut));
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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // unity screens
          Container(
            color: Colors.white,
            child: UnityWidget(
              onUnityCreated: onUnityCreated,
              onUnityMessage: onUnityMessage,
              onUnitySceneLoaded: onUnitySceneLoaded,
              fullscreen: true,
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          // select effect
          Positioned(
            bottom: 150,
            child: Container(
              height: 185,
              width: size.width,
              child: Transform.translate(
                offset: Offset.fromDirection(200,degOneTranslationAnimation.value * 0),
                child: Container(
                  transform: Matrix4.rotationZ(getRadiansFromDegree(rotationAnimation2.value))..scale(degOneTranslationAnimation.value),
                  height: 185.0,
                  // color: Color.fromRGBO(0, 255, 0, 1.0),
                  child:
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(20, 50, 10, 10),
                      //   child: SelectEffect(unityWidgetController: _unityWidgetController, link: 'lib/images/great-buddha-of-thailand.png', effect: 'Effect 0',),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(20, 50, 10, 10),
                      //   child: SelectEffect(unityWidgetController: _unityWidgetController, link: 'lib/images/snowflakes.png', effect: 'Effect 1',),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                      //   child: SelectEffect(unityWidgetController: _unityWidgetController, link: 'lib/images/buildings.png', effect: 'Effect 0'),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                        child: SelectEffect(unityWidgetController: _unityWidgetController, link: 'lib/images/fireworks.png', effect: 'Effect 2'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                        child: SelectEffect(unityWidgetController: _unityWidgetController, link: 'lib/images/fireworks-2.png', effect: 'Effect 3'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 70, 20, 10),
                        child: SelectEffect(unityWidgetController: _unityWidgetController, link: 'lib/images/fireworks-3.png', effect: 'Effect 4'),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 70, 20, 10),
                        child: SelectEffect(unityWidgetController: _unityWidgetController, link: 'lib/images/love.png', effect: 'Effect 5'),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(10, 50, 20, 10),
                      //   child: SelectEffect(unityWidgetController: _unityWidgetController, link: 'lib/images/merlion.png', effect: 'Effect 6'),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // menu button
          Positioned(
              top: 40,
              left: 15,
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
          // take photo button
          Positioned(
            bottom: 60,
            left: size.width/2-35,
            child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    width:  4.0,
                    color: Colors.white,
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    radius: 30,
                    hoverColor: Colors.black54,
                    splashColor: Colors.black54,
                    borderRadius: BorderRadius.circular(40),
                    // highlightColor: Colors.blue,
                    onTap: () => print("alo"),
                    onLongPress: () async {
                      print('blo');
                    },

                  ),
                )
            ),
          )
        ],
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


