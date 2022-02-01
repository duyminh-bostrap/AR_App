import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

String link = "https://scontent.fhan14-1.fna.fbcdn.net/v/t39.30808-6/257806154_1304809436632593_5544268618515568260_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=cuTrfG2r6UQAX8yHkK9&tn=gL_fe3OQHx5hr7J6&_nc_ht=scontent.fhan14-1.fna&oh=00_AT_0J5dS_g3-KngF2iyx0MhYHfO14uLg0t68g1fMgY5rcQ&oe=61CF5C2F";

class SelectEffect extends StatefulWidget {
  UnityWidgetController unityWidgetController;
  String link;
  String effect;

  SelectEffect({
    Key key,
    @required this.unityWidgetController,
    @required this.link,
    @required this.effect,
  }) : super(key: key);

  @override
  _SelectEffect createState() => _SelectEffect();
}
class _SelectEffect extends State<SelectEffect> {
  int isActive = 1;

  @override
  Widget build(BuildContext context) {
    return widget.link != null
        ? Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
      height: 125,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          width: 4.0,
          color: (isActive != 1)? Color.fromRGBO(240, 113, 124, 1.0): Colors.transparent,
        ),
        borderRadius: BorderRadius.circular(30),
      ),

      clipBehavior: Clip.antiAliasWithSaveLayer,
      child:  GestureDetector(
        onTap: () {
          setState(() {
            isActive = (isActive != 1) ? 1: 0;
            widget.unityWidgetController.postMessage(
              widget.effect,
              'setAcitive',
              isActive.toString(),
            );
          });
        },
        child: Image(
              image: AssetImage(widget.link),
              fit: BoxFit.cover,)
      ),
    )
        : const SizedBox.shrink();
  }
}