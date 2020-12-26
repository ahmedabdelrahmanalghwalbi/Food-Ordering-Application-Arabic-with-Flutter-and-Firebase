import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodorderingwithpayment/scr/providers/app.dart';
import 'package:foodorderingwithpayment/scr/providers/category.dart';
import 'package:foodorderingwithpayment/scr/providers/product.dart';
import 'package:foodorderingwithpayment/scr/providers/restaurant.dart';
import 'package:foodorderingwithpayment/scr/providers/user.dart';
import 'package:foodorderingwithpayment/scr/screens/home.dart';
import 'package:foodorderingwithpayment/scr/screens/login.dart';
import 'package:foodorderingwithpayment/scr/screens/splash.dart';
import 'package:foodorderingwithpayment/scr/screens/splashing_tips/tips.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home:Tips())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return LoginScreen();
    }
  }
}
