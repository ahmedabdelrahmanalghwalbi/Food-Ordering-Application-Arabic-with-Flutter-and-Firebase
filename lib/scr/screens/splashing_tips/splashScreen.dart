import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'tips.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  var mainColor = 0xffEF5C5D;
  var secondColor = 0xffFEDD2E;
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds:Tips(),
      title: Text(
        'Welcome To Our Resturant',
        style: TextStyle(fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 30.0,
            color: Color(secondColor)
        ),
      ),
      image:Image(
        image: AssetImage("assets/loggo.png"),
      ),
      photoSize: MediaQuery.of(context).size.width/3,
      backgroundColor: Color(mainColor),
      loaderColor: Color(secondColor),
    );
  }
}