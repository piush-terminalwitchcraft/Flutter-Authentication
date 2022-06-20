import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_authentication/pages/home.dart';
import 'package:flutter_authentication/utils/AllStyles.dart';
import 'package:flutter_authentication/utils/authentication.dart';
import 'package:flutter_authentication/utils/otherServices.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_authentication/utils/AppRoutes.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  bool loading = false;
  Widget _divider(String txt) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text(
            txt,
            style: AllStyles().DefaultStyleWithColor(Colors.orange),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _googleSignInButton() {
    return InkWell(
      onTap: () {
        setState(() {
          loading = true;
          try {
            FirebaseService().signInwithGoogle(context).then((value) => {
                  print("Successfully logged in"),
                  Navigator.pushNamed(context, Approutes.HomeRoute),
                });
          } catch (e) {
            print(e);
            Navigator.pushNamed(context, Approutes.LoginRoute);
          }
          loading = false;
        });
      },
      child: !loading
          ? Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.deepOrangeAccent, width: 3),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/images/google_logo.png"),
                    height: 35.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Sign in with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            )
          : CircularProgressIndicator(),
    );
  }

  Widget _EmptyContainer(double width) {
    return SizedBox(
      height: width,
    );
  }

  Widget _Body(int a, int b, int c) {
    return Material(
      child: Column(
        children: [
          upperCanva(),
          Row(
            children: [
              Expanded(
                child: Container(),
                flex: a,
              ),
              Expanded(
                flex: b,
                child: Column(
                  children: [
                    Text(
                      "Welcome to Login Page",
                      style: AllStyles().DefaultStyle(),
                    ),
                    _EmptyContainer(20),
                    TextField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orangeAccent, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepOrangeAccent, width: 2.0),
                        ),
                        hintText: 'Enter the email ID',
                      ),
                      onChanged: (text) {
                        setState(() {
                          email = text;
                          print(email);
                          print(password);
                        });
                      },
                    ),
                    _EmptyContainer(20),
                    TextField(
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orangeAccent, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepOrangeAccent, width: 2.0),
                        ),
                        hintText: 'Enter the password',
                      ),
                      onChanged: (text) {
                        setState(() {
                          print(email);
                          print(password);
                          password = text;
                        });
                      },
                    ),
                    _EmptyContainer(20),
                    ElevatedButton(
                      style: AllStyles().DefaultButtonStyle(Colors.deepOrange),
                      onPressed: () {
                        FirebaseService()
                            .handleSignInEmail(email, password)
                            .then((value) {
                          print(value);
                          Navigator.pushNamed(context, Approutes.HomeRoute);
                        }).catchError((e) => print(e));
                      },
                      child: Text("Login"),
                    ),
                    _EmptyContainer(30),
                    Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Forgot Password?",
                        style: AllStyles().DefaultStyle(),
                      ),
                    ),
                    _EmptyContainer(10),
                    _divider("OR"),
                    _EmptyContainer(20),
                    _googleSignInButton(),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
                flex: c,
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: a,
                    child: Container(),
                  ),
                  Expanded(
                    flex: b,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Don't have an account?  ",
                            style: AllStyles().DefaultStyle(),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                Navigator.pushNamed(
                                    context, Approutes.RegisterRoute);
                              });
                            },
                            child: Text(
                              "Register Here",
                              style: AllStyles()
                                  .DefaultStyleWithColor(Colors.deepOrange),
                            ),
                          )
                        ]),
                  ),
                  Expanded(
                    flex: c,
                    child: Container(),
                  ),
                ],
              ),
              lowerImage(),
            ],
          ),
        ],
      ),
    );
    ;
  }

  Widget lowerImage() {
    return Image.asset(
      "assets/images/lowerCurve.png",
      height: 100,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }

  Widget upperCanva() {
    return Container(
      height: 50,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);

    return MaterialApp(
      home: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          if (width > 1280) {
            return _Body(6, 8, 6);
          } else if (width > 720) {
            return _Body(4, 8, 4);
          } else {
            return _Body(1, 8, 1);
          }
        },
      ),
    );
  } // child:
}
