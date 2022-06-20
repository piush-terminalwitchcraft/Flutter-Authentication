import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_authentication/utils/FirebaseStorage.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
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
  File? imageFile;
  Uint8List webImage = Uint8List(10);
  String email = "";
  String username = "";
  String password = "";
  var auth = FirebaseService();

  Future<PermissionStatus> requestPermissions() async {
    await Permission.photos.request();
    return Permission.photos.status;
  }

  Future imageSelector(BuildContext context) async {
    var permissionStatus = requestPermissions();
    if (!kIsWeb && await permissionStatus.isGranted) {
      final picker = ImagePicker();
      final pickedfile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedfile == null) return;
      final file = File(pickedfile.path);
      setState(() async {
        imageFile = file;
      });
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          imageFile = File("a");
          webImage = f;
        });
      }
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
                        setState(() async {
                          await imageSelector(context);
                        });
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: (imageFile == null)
                            ? Image.asset("assets/images/profile_image.jpg")
                                .image
                            : getProfileImg(),
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

                        setState(() async {
                          await auth
                              .handleSignUp(email, password)
                              .then((user) async {
                            print(user);
                            if (!username.isEmpty) {
                              await auth.UpdateUsername(username)
                                  .catchError((e) => print(e));
                            }
                            if (imageFile != null) {
                              await getDownloadURL(user!.uid!)
                                  .then((value) async {
                                print(value);
                                await auth.UpdateProfilePic(value)
                                    .catchError((e) => print(e));
                              }).catchError((e) => print(e));
                            }
                          }).catchError((e) => print(e));
                          Navigator.pushNamed(context, Approutes.LoginRoute);
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

  ImageProvider<Object> getProfileImg() {
    return (kIsWeb)
        ? Image.memory(webImage).image
        : Image.file(imageFile!).image;
  }

  Future<String> getDownloadURL(String uid) async {
    if (kIsWeb) {
      return await StorageService().uploadPicWeb(webImage, uid);
    } else {
      return await StorageService().uploadPic(imageFile!, uid);
    }
  }
}
