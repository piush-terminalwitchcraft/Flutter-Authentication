import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_authentication/utils/AllStyles.dart';
import 'package:flutter_authentication/utils/AppRoutes.dart';
import 'package:flutter_authentication/utils/authentication.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool chkUserLogged = false;
  final auth = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: FirebaseService().isUserLoggedin(),
        builder: (context, snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = MainBody();
          } else
            children = Align(
              alignment: Alignment.center,
              child: Text("User data is not available"),
            );
          return children;
        },
      ),
    );
  }

  Widget MainBody() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      double width = constraints.maxWidth;
      if (width > 1280) {
        return _Body(6, 8, 6);
      } else if (width > 720) {
        return _Body(4, 8, 4);
      } else {
        return _Body(1, 8, 1);
      }
    });
  }

  Widget _EmptyContainer(double width) {
    return SizedBox(
      height: width,
    );
  }

  Widget _Body(int a, int b, int c) {
    return Column(
      children: [
        _EmptyContainer(60),
        Row(
          children: [
            Expanded(
              child: Container(),
              flex: a,
            ),
            Expanded(
              flex: b,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  auth.getProfileImg(),
                  _EmptyContainer(20),
                  Text(
                    auth.getUserName(),
                    style: AllStyles().DefaultStyleWithColor(Colors.deepOrange),
                  ),
                  _EmptyContainer(20),
                  Text(
                    auth.getEmail()!,
                    style: AllStyles().DefaultStyle(),
                  ),
                  _EmptyContainer(20),
                  ElevatedButton(
                    onPressed: () {
                      auth.signOutFromGoogle().then((value) {
                        Navigator.pushNamed(context, Approutes.LoginRoute);
                      });
                    },
                    child: Text("Sign out"),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(),
              flex: c,
            ),
          ],
        )
      ],
    );
  }
}
