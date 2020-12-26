import 'package:flutter/material.dart';
import 'package:foodorderingwithpayment/scr/helpers/screen_navigation.dart';
import 'package:foodorderingwithpayment/scr/providers/category.dart';
import 'package:foodorderingwithpayment/scr/providers/product.dart';
import 'package:foodorderingwithpayment/scr/providers/restaurant.dart';
import 'package:foodorderingwithpayment/scr/providers/user.dart';
import 'package:foodorderingwithpayment/scr/screens/home.dart';
import 'package:foodorderingwithpayment/scr/screens/registration.dart';
import 'package:foodorderingwithpayment/scr/widgets/loading.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final restaurantProvider = Provider.of<RestaurantProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      key: _key,
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: authProvider.status == Status.Authenticating? Loading() :Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Form(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 35.0),
                          child: Text(
                            "سجل الدخول الى حسابك من هنا ",
                            style: TextStyle(fontSize: 25.0, color: Colors.red),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: TextFormField(
                            controller: authProvider.email,
                            decoration: InputDecoration(
                                hintText: "البريد الالكتروني",
                                border: InputBorder.none),
                            validator: (String value) {
                              if (value.isEmpty ||
                                  value.indexOf(".") == -1 ||
                                  value.indexOf("@") == -1) {
                                return "الرجاء ادخال البريد الالكتروني";
                              }else{
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0),
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  controller: authProvider.password,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "كلمة المرور",
                                      border: InputBorder.none),
                                  validator: (String value) {
                                    if (value.isEmpty || value.length < 6) {
                                      return "الرجاء ادخال كلمة المرور";
                                    }else{
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        MaterialButton(
                            onPressed: ()async{
                              if(!await authProvider.signIn()){
                                _key.currentState.showSnackBar(
                                    SnackBar(content: Text("Login failed!"))
                                );
                                return;
                              }
                              categoryProvider.loadCategories();
                              restaurantProvider.loadSingleRestaurant();
                              productProvider.loadProducts();
                              authProvider.clearController();
                              changeScreenReplacement(context, Home());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              child: Text(
                                "دخول",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20.0),
                              ),
                              margin: EdgeInsets.only(bottom: 10.0, top: 30.0),
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(25.0)),
                            )),
                      ],
                    ),
                  )),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "اذا ليس لديك حساب سجل من هنا ",
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                    Padding(padding: EdgeInsets.all(10.0)),
                    GestureDetector(
                      onTap: (){
                        changeScreen(context, RegistrationScreen());
                      },
                      child: Text("تسجيل جديد",
                          style:
                          TextStyle(color: Colors.red, fontSize: 16.0)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
