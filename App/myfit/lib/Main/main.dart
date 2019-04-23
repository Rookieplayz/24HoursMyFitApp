import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:twenty_four_hours/Authentication/Model/Register.dart';
import 'package:twenty_four_hours/Authentication/UI/LRPage.dart';
import 'package:twenty_four_hours/Authentication/UI/RegisterPage.dart';
import 'package:twenty_four_hours/Authentication/auth.dart';
import 'package:twenty_four_hours/Authentication/auth_provider.dart';
import 'package:twenty_four_hours/Main/HomePage.dart';
import 'package:twenty_four_hours/Main/Settings/Setting.dart';
import 'package:twenty_four_hours/Main/Settings/SettingsPage.dart';
import 'package:twenty_four_hours/Main/root_page.dart';
import 'package:twenty_four_hours/NavigationControl.dart';
import 'package:twenty_four_hours/Widgets-Assets/24HColors.dart';
import 'package:twenty_four_hours/Widgets-Assets/GraidentAnimator.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
void main() => runApp(MyApp());

class Themes {
  static final ThemeData MIDNIGHT = new ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    primaryColor: HColors.mainscreenDark,
    accentColor: HColors.midnightAccent,
    primaryColorLight: HColors.midnight_main,
    primaryColorDark: HColors.mainscreenDark,
    backgroundColor: HColors.midnight_main,
    scaffoldBackgroundColor: HColors.midnight_main,
    bottomAppBarColor: HColors.mainscreenDark,

  );
  static final ThemeData DAYLIGHT = new ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.amber,
    accentColor: HColors.daylightAccent,
    primaryColorLight: Colors.amber.shade100,
    primaryColorDark: Colors.amber.shade600,
    backgroundColor: Colors.white,
  );
  static final ThemeData EVENING = new ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.purple,
    accentColor: HColors.eveAccent,
    primaryColorLight: HColors.eve_main,
    primaryColorDark: HColors.eveDark,
    backgroundColor: HColors.eve_main,
  );
  static ThemeData CURRENT_THEME(THEMETYPE type){
    switch(type)
    {
      case THEMETYPE.MIDNIGHT:return MIDNIGHT;break;
      case THEMETYPE.DAYLIGHT:return DAYLIGHT;break;
      case THEMETYPE.EVENING:return EVENING;break;

    }
  }
  static void changeTheme(THEMETYPE type,BuildContext context)
  {
    switch(type)
    {
      case THEMETYPE.MIDNIGHT:
        {
          DynamicTheme.of(context).setThemeData(MIDNIGHT);
          DynamicTheme.of(context).setBrightness(Brightness.light);
        };
        break;
      case THEMETYPE.DAYLIGHT:
        {
          DynamicTheme.of(context).setThemeData(DAYLIGHT);
          DynamicTheme.of(context).setBrightness(Brightness.dark);
        };break;
      case THEMETYPE.EVENING:
        {
          DynamicTheme.of(context).setThemeData(EVENING);
          DynamicTheme.of(context).setBrightness(Brightness.dark);
        };break;

    }
  }
}
class WaitingScreen extends StatefulWidget
{
  WaitingScreenState createState()=>new WaitingScreenState();
}
class WaitingScreenState extends State<WaitingScreen> with
    SingleTickerProviderStateMixin
{
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    );
    _controller.addListener(glistener);
  }
  void glistener()
  {
    if (!_controller.isAnimating) {
      if (_controller.isCompleted) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          GradientAnimation(
            begin: LinearGradient(
              colors: [Colors.blue.shade100, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            end: LinearGradient(
              colors: [Colors.purple, Colors.deepPurple],
            ),
            controller: _controller,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget>[
                Container(
                    width: 150.0,
                    height:150.0,
                    child:FlareActor(
                      "Flare/dl.flr",fit: BoxFit.contain,animation: "start",
                    )),
                Text("Setting you up...",style: TextStyle(color: Colors.white,fontSize: 28.0,))
              ]),

        ],
      ),
    );
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hours();
  }
}

class Hours extends StatefulWidget {
  HoursState createState() => HoursState();
}

class HoursState extends State<Hours> {
  HoursState() {
    // Auth().signInWithEmailAndPassword("olamidepeters@gmail.com", "artiscool");
  }
  Widget app=new WaitingScreen();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("firebase starting...");
    //  Setting setting=new Setting();
    // setting.loadSettings().then((c){setState(() {
    app=AuthProvider(
        auth: Auth(),
        child: new DynamicTheme(
            defaultBrightness: Brightness.dark,
            data: (brightness) =>Themes.MIDNIGHT,
            themedWidgetBuilder: (context, theme) {
              return new
              MaterialApp(
                title: 'Flutter Demo',
                theme:theme,

                home:
                new SplashScreen(), // user!=null ? HomePage():LoginActivityMain(),
                routes: <String, WidgetBuilder>{
                  '/RootPage': (BuildContext context) => new RootPage()
                },
              );
            }));
    // });
    // });

    return app;
  }

}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  startTime() async {
    /*var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);*/
    Setting setting=Setting();

    setting.loadSettings().then((n){
      print("This is setting: ${setting.theme}");
      switch(setting.theme)
      {
        case THEMETYPE.MIDNIGHT:
          {
            print("Midnight");
            DynamicTheme.of(context).setThemeData(Themes.MIDNIGHT);

          }
          break;
        case THEMETYPE.DAYLIGHT:
          {
            print("Its daylght");
            DynamicTheme.of(context).setThemeData(Themes.DAYLIGHT);

          }break;
        case THEMETYPE.EVENING:
          {
            print("lol");
            DynamicTheme.of(context).setThemeData(Themes.EVENING);

          }break;

      }

      Future.delayed(Duration(seconds: 1)).then((n){
        NavigationControl(nextPage: RootPage(setting: setting,)).replaceWith(context);
      });});
  }

  AnimationController _controller;

  void navigationPage() {
    //Navigator.of(context).pushReplacementNamed('/RootPage');
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 7),
    );
    _controller.addListener(glistener);

    startTime();


  }
  void glistener()
  {
    if (!_controller.isAnimating) {

      if (_controller.isCompleted) {

        _controller.reverse();


      } else {

        _controller.forward();

      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(

      body: new Stack(
        children: <Widget>[
          GradientAnimation(
            begin: LinearGradient(
              colors: [Colors.blue.shade100, Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            end: LinearGradient(
              colors: [Colors.purple, Colors.deepPurple],
            ),
            controller: _controller,
          ),
          Center(child:  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:<Widget>[
                Container(
                    width: 150.0,
                    height:150.0,
                    child:FlareActor(
                      "Flare/dl.flr",fit: BoxFit.contain,animation: "start",
                    )),
                Text("Setting you up...",style: TextStyle(color: Colors.white,fontSize: 28.0,))
              ])),

        ],
      ),
    );
  }
}
