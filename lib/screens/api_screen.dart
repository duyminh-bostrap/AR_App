import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class ApiScreen extends StatefulWidget {
  ApiScreen({Key key}) : super(key: key);

  @override
  _ApiScreenState createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  UnityWidgetController _unityWidgetController;
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();
  }

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
            Expanded(
              child: Container(
                child: UnityWidget(
                  onUnityCreated: onUnityCreated,
                  onUnityMessage: onUnityMessage,
                  onUnitySceneLoaded: onUnitySceneLoaded,
                  fullscreen: false,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Card(
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text("Rotation speed:"),
                    ),
                    Slider(
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                        setRotationSpeed(value.toString());
                      },
                      value: _sliderValue,
                      min: 0,
                      max: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // MaterialButton(
                        //   onPressed: () {
                        //     _unityWidgetController.quit();
                        //   },
                        //   child: Text("Quit"),
                        // ),
                        MaterialButton(
                          onPressed: () {
                            _unityWidgetController.inBackground();
                          },
                          child: Text("Create"),
                        ),
                        MaterialButton(
                          onPressed: () {
                            _unityWidgetController.pause();
                          },
                          child: Text("Pause"),
                        ),
                        MaterialButton(
                          onPressed: () {
                            _unityWidgetController.resume();
                          },
                          child: Text("Resume"),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MaterialButton(
                          onPressed: () async {
                            await _unityWidgetController.openInNativeProcess();
                          },
                          child: Text("Open Native"),
                        ),
                        MaterialButton(
                          onPressed: () {
                            _unityWidgetController.unload();
                          },
                          child: Text("Unload"),
                        ),
                        MaterialButton(
                          onPressed: () {
                            _unityWidgetController.quit();
                          },
                          child: Text("Quit"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setRotationSpeed(String speed) {
    _unityWidgetController.postMessage(
      'Cube',
      'SetRotationSpeed',
      speed,
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