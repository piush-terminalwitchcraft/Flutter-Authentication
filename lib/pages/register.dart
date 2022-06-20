import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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

  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        imageFile = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 90);
        break;

      case "camera": // CAMERA CAPTURE CODE
        imageFile = await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 90);
        break;
    }

    if (imageFile != null) {
      print("You selected  image : " + imageFile!.path);
      setState(() {
        debugPrint("SELECTED IMAGE PICK   $imageFile");
      });
    } else {
      print("You have not taken image");
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
                    Container(
                      width: 100,
                      height: 100,
                      margin: EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          print("Tapped");
                          setState(() {
                            imageSelector(context, "camera")
                                .then((value) => {});
                          });
                        },
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: (imageFile == null)
                              ? Image.asset('assets/images/profile_image.jpg')
                                  .image
                              :
                              // : FileImage(imageFile).file,
                              FileImage(File(imageFile!.path)),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    _EmptyContainer(20),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          username = text;
                        });
                      },
                      decoration: InputDecoration(
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
                          FirebaseService().signInWithDefaultMethod(
                              email, username, password, "");
                        });
                      },
                      child: Text("Register"),
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
