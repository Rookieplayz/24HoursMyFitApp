import 'package:flutter/material.dart';
import 'package:twenty_four_hours/Authentication/UI/LRPage.dart';
import 'package:twenty_four_hours/Authentication/UI/LoginPage.dart';
import 'package:twenty_four_hours/Authentication/auth_provider.dart';
import 'package:twenty_four_hours/Main/HomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twenty_four_hours/Main/Settings/Setting.dart';

class RootPage extends StatefulWidget {
  final Setting setting;
  RootPage({this.setting});
  @override
  State<StatefulWidget> createState() => _RootPageState(setting: setting);
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;

  final Setting setting;
  _RootPageState({this.setting});
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    var auth = AuthProvider.of(context).auth;



    auth.currentUser().then((userId) {
      setState(() {
        authStatus =
        userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return _buildWaitingScreen();

      case AuthStatus.notSignedIn:
        return new LRPage(
          onSignedIn: _signedIn,
        );

      case AuthStatus.signedIn:
        return new HomePage(
          onSignedOut: _signedOut,
          setting: setting,
        );
    }

    return null;
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }
}
