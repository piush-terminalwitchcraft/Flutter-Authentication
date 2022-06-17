import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_authentication/utils/authentication.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool chkUserLogged = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: FirebaseService().isUserLoggedin(),
        builder: (context, snapshot) {
          Widget children;
          if (snapshot.hasData) {
            children = Text(snapshot.data.toString());
          } else
            children = Text(snapshot.error.toString());
          return children;
        },
      ),
    );
  }
}
