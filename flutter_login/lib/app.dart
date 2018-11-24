import 'package:flutter/material.dart';
import 'package:flutter_login/bloc/global/provider.dart';
import 'package:flutter_login/bloc/global/screen/login_screen.dart';
import 'screens/login.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Login',
//      home: Scaffold(
//        body: LoginScreen(),
//      ),
//    );

    return Provider(
      child: MaterialApp(
        title: 'Log Me In',
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
  }
}
