import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_authentication/utils/AppRoutes.dart';
import 'package:flutter_authentication/utils/authentication.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/rendering.dart';
import '../utils/AllStyles.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  XFile? imageFile = null;
  String email = "";
  String username = "";
  String password = "";
  var auth = FirebaseService();

  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":
        imageFile = await ImagePicker().pickImage(
            source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
        break;
      case "camera":
        imageFile = await ImagePicker().pickImage(
            source: ImageSource.camera, maxHeight: 200, maxWidth: 200);
        break;
    }
  }

  Widget _EmptyContainer(double width) {
    return SizedBox(
      height: width,
    );
  }

  Widget _mainBody(int a, int b, int c) {
    return Material(
      child: Column(
        children: [
          _EmptyContainer(40),
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
                      "Register Here 😊😊",
                      style: AllStyles().DefaultStyle(),
                    ),
                    _EmptyContainer(20),
                    InkWell(
                      onTap: () {
                        print("tapped");
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: (imageFile == null)
                            ? Image.asset("assets/images/profile_image.jpg")
                                .image
                            : FileImage(File(imageFile!.path)),
                      ),
                    ),
                    _EmptyContainer(20),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          username = text;
                        });
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orangeAccent, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepOrangeAccent, width: 2.0),
                        ),
                        hintText: 'Enter your name',
                      ),
                    ),
                    _EmptyContainer(20),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          email = text;
                        });
                      },
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.orangeAccent, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepOrangeAccent, width: 2.0),
                        ),
                        hintText: 'Enter the email',
                      ),
                    ),
                    _EmptyContainer(20),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          password = text;
                        });
                      },
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
                    ),
                    _EmptyContainer(20),
                    ElevatedButton(
                      style: AllStyles().DefaultButtonStyle(Colors.deepOrange),
                      onPressed: () {
                        print("Clicked register");
                        print(email);
                        print(username);
                        print(password);

                        setState(() {
                          auth.handleSignUp(email, password).then((user) {
                            print(user);
                            if (!username.isEmpty) {
                              auth.UpdateUsername(username)
                                  .catchError((e) => print(e));
                            }
                            if (imageFile != null) {
                              auth.UpdateProfilePic(imageFile!.path.toString());
                            }
                          }).catchError((e) => print(e));
                          Navigator.pushNamed(context, Approutes.HomeRoute);
                        });
                      },
                      child: Text("Register"),
                    ),
                    _EmptyContainer(30),
                    Container(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Approutes.LoginRoute);
                        },
                        child: Text(
                          "Registered? Log in here ",
                          style: AllStyles()
                              .DefaultStyleWithColor(Colors.deepOrange),
                        ),
                      ),
                    ),
                    _EmptyContainer(10),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
                flex: c,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double width = constraints.maxWidth;
          if (width > 1280) {
            return _mainBody(6, 8, 6);
          } else if (width > 720) {
            return _mainBody(4, 8, 4);
          } else {
            return _mainBody(1, 8, 1);
          }
        },
      ),
    );
  }

  getImage() {
    return null;
  }
}
