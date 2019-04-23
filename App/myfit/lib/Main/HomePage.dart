import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twenty_four_hours/Authentication/Model/Register.dart';
import 'package:twenty_four_hours/Authentication/UI/WelcomePage.dart';
import 'package:twenty_four_hours/Authentication/auth.dart';
import 'package:twenty_four_hours/Authentication/auth_provider.dart';
import 'package:twenty_four_hours/DatabaseHandling/ExcersiseHandling.dart';
import 'package:twenty_four_hours/DatabaseHandling/UserInformationDB.dart';
import 'package:twenty_four_hours/DatabaseHandling/WorkoutDBHandling.dart';
import 'package:twenty_four_hours/MyFit/Models/Achievements.dart';
import 'package:twenty_four_hours/MyFit/Models/Exercise.dart';
import 'package:twenty_four_hours/MyFit/Models/Workout.dart';
import 'package:twenty_four_hours/Main/Award.dart';
import 'package:twenty_four_hours/Main/Profile.dart';
import 'package:twenty_four_hours/Main/Settings/Setting.dart';
import 'package:twenty_four_hours/Main/Settings/SettingsPage.dart';
import 'package:twenty_four_hours/Main/main.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:twenty_four_hours/Main/DisplayAchivement.dart';
import 'package:twenty_four_hours/NavigationControl.dart';
import 'package:twenty_four_hours/Widgets-Assets/24HColors.dart';
import 'package:twenty_four_hours/Widgets-Assets/Polygon.dart';
import 'package:twenty_four_hours/Widgets-Assets/auto_size_text.dart';
import 'package:twenty_four_hours/Widgets-Assets/polygon_clipper.dart';
import 'package:twenty_four_hours/Widgets-Assets/polygon_outline.dart';

class HomePage extends StatefulWidget {
  final VoidCallback onSignedOut;
  final Setting setting;
  final String title;

  HomePage({Key key,this.title,this.onSignedOut,this.setting}) : super(key: key);
  HomePagestate createState() => HomePagestate(setting:setting);

  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;

      await auth.signOut();

      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  FirebaseUser user;
}
enum AppBarBehavior { normal, pinned, floating, snapping }

class HomePagestate extends State<HomePage> with TickerProviderStateMixin{
 ///Variables here///////////////
  String currentUser = '';
  String result="";
  Setting setting;
  DateTime dateTime;
  TabController _tabController;
  AnimationController _controller;
  Timer _timer;
  String greetingMsg;
  String dayProgress;
  double startAt;
  String hbotMsg = '...', hbotImg = 'images/hbot.png';
  String dayAnimation='';
  String weatherAnim='';
  var _scrollController = new ScrollController();
  AppBarBehavior _appBarBehavior = AppBarBehavior.normal;
  var stops = [0.3, 0.6, 0.9];
  Color deepShade = new Color.fromRGBO(153, 230, 255, 1.0),
      mediumShade = new Color.fromRGBO(204, 242, 255, 1.0),
      shallowShade = new Color.fromRGBO(255, 255, 255, 1.0);
  bool isMorning = true;
  String currentTime = new DateFormat.Hm().format(new DateTime.now()),
      currentDate = new DateFormat.yMMMEd().format(new DateTime.now());
  final double _appBarHeight = 300.0;

  List<Widget> displays=[Text("Main"),Text("Weather"),Text("Schedule")];
  ///end///
  Future updateTime() async {
    DateTime date = await DateTime.now();
    // print(date);
    setState(() {
      currentTime = new DateFormat.Hms().format(date);
    });
  }
  HomePagestate({this.setting});
  Widget app=WaitingScreen();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

          app= Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,

            body: new NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverAppBar(
                    backgroundColor: deepShade,
                    expandedHeight: _appBarHeight,
                    pinned: _appBarBehavior == AppBarBehavior.pinned,
                    floating: _appBarBehavior == AppBarBehavior.floating ||
                        _appBarBehavior == AppBarBehavior.snapping,
                    snap: _appBarBehavior == AppBarBehavior.snapping,
                    actions: <Widget>[

                      new IconButton(
                        icon: Icon(Icons.chat_bubble_outline),
                        onPressed: () {},
                      ),
                      IconButton(icon: Icon(Icons.settings), onPressed: () {
                        setting.loadSettings().then((s){
                          NavigationControl(nextPage:new SettingsPage(
                              user: userInfo,
                              setting:setting)).navTo(context);});}),
                    ],
                    flexibleSpace: new FlexibleSpaceBar(
                      title: new Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[],
                      ),
                      background: new Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          // This gradient ensures that the toolbar icons are distinct

                          // against the background image.

                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: stops,
                                colors: <Color>[
                                  deepShade,
                                  mediumShade,
                                  shallowShade
                                ],
                              ),
                            ),
                          ),

                    /*     new Transform.translate(
                            offset: new Offset(0.0, 100.0),
                            child: new Image(
                              image: new AssetImage(bgImg),
                              fit: BoxFit.scaleDown,
                              height: 70.0,
                              width: 90.0,
                            ),
                          ),
                            new Transform.translate(
                            offset: new Offset(0.0, 10.0),
                            child: new Image(
                              image: new AssetImage(weatherImg),
                              fit: BoxFit.scaleDown,
                              height: 70.0,
                              width: 90.0,
                            ),
                          ),*/
                           TabBarView(
                        controller: _tabController,
                        children: displays.map((Widget choice) {
                          return Padding(
                            padding: EdgeInsets.zero,
                            child: ChoiceCard(
                              tabController: _tabController,
                              currentTime: currentTime,
                              currentDate: currentDate,
                              choice: choice,
                              isMorning: isMorning,
                            ),
                          );
                        }).toList(),
                      ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Stack(
                fit: StackFit.expand,
                children: <Widget>[

                  DecoratedBox(
                    decoration: BoxDecoration(
                        color:Colors.black26,
                    ),
                  ),

                 /* new Transform.translate(
                    offset: new Offset(MediaQuery.of(context).size.width*0.32, MediaQuery.of(context).size.height*0.06),
                    child:
                  HexagonFilled(
                    new Container(
                        child:new Column(
                          children: <Widget>[
                            Shimmer.fromColors(
                              baseColor: Colors.redAccent,
                              highlightColor: Colors.red.shade100,
                              period: Duration(seconds: 2),
                              child:new RaisedButton(onPressed: null),
                            ),
                            Padding(padding: const EdgeInsets.all(6.0)),

                          ],
                        )
                    ),
                    shadows: [PolygonBoxShadow(color:Colors.black87,elevation:10.0)],
                    size: new Size(150.0,150.0),
                    color: Colors.red,
                  )),
                  new Transform.translate(
                      offset: new Offset(MediaQuery.of(context).size.width*0.02, MediaQuery.of(context).size.height*0.30),
                      child:
                      HexagonFilled(
                        new Container(
                            child:new Column(
                              children: <Widget>[
                                Shimmer.fromColors(
                                  baseColor: Colors.yellowAccent,
                                  highlightColor: Colors.yellow.shade100,
                                  period: Duration(seconds: 2),
                                  child:new RaisedButton(onPressed: null),
                                ),
                                Padding(padding: const EdgeInsets.all(6.0)),

                              ],
                            )
                        ),
                        size: new Size(150.0,150.0),
                        color: Colors.yellow,
                      )),
                  new Transform.translate(
                      offset: new Offset(MediaQuery.of(context).size.width*0.6, MediaQuery.of(context).size.height*0.30),
                      child:
                      HexagonFilled(
                        new Container(
                            child:new Column(
                              children: <Widget>[
                                Shimmer.fromColors(
                                  baseColor: Colors.purpleAccent,
                                  highlightColor: Colors.purple.shade100,
                                  period: Duration(seconds: 2),
                                  child:new RaisedButton(onPressed: null),
                                ),
                                Padding(padding: const EdgeInsets.all(6.0)),

                              ],
                            )
                        ),
                        size: new Size(150.0,150.0),
                        color: Colors.purple,
                      )),
*/
                ],
              ),
            ),);

    return app;
       
  }

  StreamSubscription _subscription;
    StreamSubscription _profileSubscription;
    UserInformationDB userInfoDB;
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
  void _nextPage(int delta) {
    final int newIndex = _tabController.index + delta;
    if (newIndex < 0 || newIndex >= _tabController.length) return;
    _tabController.animateTo(newIndex);
  }

  num rndNumber(num min, num max) {
    return new Random().nextInt(max - min + 1) + min;
  }

  void setTime(Timer timer) {

    final greetings = [
      userInfo!=null?"Good Morning ${userInfo.username}":"Good Morning",
      "Good Afternoon",
      "It\'s Going to be a beautiful day today",
      "Good Evening",
      "Night Night! "
    ];
    setState(() {

      hbotMsg =  userInfo!=null?'Hey ${userInfo.username}':"Hey There!";
      hbotImg = 'images/hbot.png';
      dayProgress = '${100 - ((dateTime.hour * 100) / 24).round()}%';
      startAt = ((dateTime.hour * 100) / 24) / 100;
      //    print('hour: ${dateTime.hour} __ $dayProgress');
      dateTime = new DateTime.now();
      currentTime = new DateFormat.Hm().format(dateTime);
      currentDate = new DateFormat.yMMMEd().format(dateTime);
      // print("DateTime: ${dateTime.hour}");
      if (dateTime.hour >= 1 && dateTime.hour <= 3) {
      //  bgImg = 'images/mnight.png';
        hbotImg = 'assets/gifs/hbot_sleep.gif';
        deepShade = new Color.fromRGBO(80, 0, 179, 1.0);
        mediumShade = new Color.fromRGBO(133, 51, 255, 1.0);
        shallowShade = new Color.fromRGBO(198, 26, 255, 1.0);
        //stops=[0.4,0.6,1.0];
        greetingMsg = greetings[4];
        isMorning = false;
      } else if (dateTime.hour >= 4 && dateTime.hour <= 6) {
        greetingMsg = greetings[4];
       // bgImg = 'images/mnight.png';
        hbotImg = 'assets/gifs/hbot_sleep.gif';
        deepShade = new Color.fromRGBO(0, 0, 102, 1.0);
        mediumShade = new Color.fromRGBO(0, 51, 153, 1.0);
        shallowShade = new Color.fromRGBO(51, 102, 153, 1.0);
        //stops=[0.4,0.6,1.0];
        isMorning = false;
      } else if (dateTime.hour >= 7 && dateTime.hour <= 11) {
        greetingMsg = greetings[0];
        //bgImg = 'images/grass-outline-hi.png';
        deepShade = new Color.fromRGBO(0, 204, 255, 1.0);
        mediumShade = new Color.fromRGBO(102, 255, 204, 1.0);
        shallowShade = new Color.fromRGBO(255, 255, 204, 1.0);
        //stops=[0.4,0.6,1.0];
        isMorning = true;
      } else if (dateTime.hour >= 12 && dateTime.hour <= 17) {
        greetingMsg = greetings[rndNumber(1, 2)];
      //  bgImg = 'images/sea.png';
        deepShade = new Color.fromRGBO(153, 230, 255, 1.0);
        mediumShade = new Color.fromRGBO(204, 242, 255, 1.0);
        shallowShade = new Color.fromRGBO(255, 255, 204, 1.0);
        //stops=[0.4,0.6,1.0];
        isMorning = true;
      } else if (dateTime.hour >= 18 && dateTime.hour <= 19) {
        greetingMsg = greetings[3];
        //bgImg = 'images/sea.png';
        shallowShade = new Color.fromRGBO(255, 102, 0, 1.0);
        mediumShade = new Color.fromRGBO(255, 153, 153, 1.0);
        deepShade = new Color.fromRGBO(255, 204, 153, 1.0);
        //stops=[0.4,0.6,1.0];
        isMorning = true;
      } else {
        greetingMsg = greetings[4];
       // bgImg = 'images/night.png';
        deepShade = new Color.fromRGBO(204, 0, 204, 1.0);
        mediumShade = new Color.fromRGBO(255, 102, 153, 1.0);
        shallowShade = new Color.fromRGBO(255, 166, 77, 1.0);
        //stops=[0.4,0.6,1.0];
        isMorning = true;
      }
    });
  }
  @override
  void initState() {
    _controller=new AnimationController(vsync: this,duration: Duration(seconds: 30));
    _controller.addListener((){glistener();});
    _tabController = TabController(vsync: this, length: displays.length);
    _timer = new Timer.periodic(const Duration(seconds: 1), setTime);
    initializeDateFormatting();
    _currentUser();
    print("THEME: ${setting.theme}");
    for (int i = 0; i < 7; i++) controllers.add(new TextEditingController());
    //eh = new ExcersiseHandling();
    wh=new WorkoutDBHandling();
    userInfoDB=new UserInformationDB();
    print("-----------------------------------");
  /* eh.getExerciseStream(_updateExcercises).then((StreamSubscription s) => _subscription = s);
    userInfoDB.getUserInfo(_updateUserInfo).then((StreamSubscription s) => _profileSubscription= s);
     */   super.initState();
      }
    @override
    void dispose()
    {
      if(_subscription!=null)
      _subscription.cancel;
    }
      FirebaseUser user;
      FirebaseAuth Fauth;
      Register userInfo = new Register();
      String UID = '';
      DatabaseReference reference;
    
      Future currentUserInfo() async{
        reference = FirebaseDatabase.instance.reference();
    
        Auth().currentUser().then((uid) {
          reference
              .child("User_Information")
              .child(uid)
              .onChildAdded
              .listen(_onEntryAdded);
          setState(() {
            userInfo = userInfo;
          });
        });
      }
    
      _onEntryAdded(Event event) {
        userInfo = (new Register.fromSnapshot(event.snapshot));
        //   print(userInfo);
      }
    
      Future _currentUser() async {
        user = await FirebaseAuth.instance.currentUser();
        if (user == null)
          setState(() {
            currentUser = 'Guest';
          });
        else
          setState(() {
            currentUser = user.displayName;
          });
      }
    
      List<TextEditingController> controllers = List<TextEditingController>();
      Widget AddTool() {
        return 
            Wrap(
          children: <Widget>[
            TextField(
              controller: controllers[0],
              decoration: InputDecoration(hintText: "Name: "),
            ),
            TextField(
              controller: controllers[1],
              decoration: InputDecoration(hintText: "Describe: "),
            ),
            TextField(
              controller: controllers[2],
              decoration: InputDecoration(hintText: "Tips: "),
            ),
            TextField(
              controller: controllers[3],
              decoration: InputDecoration(hintText: "Muscles: "),
            ),
            TextField(
              controller: controllers[4],
              decoration: InputDecoration(hintText: "Imgurl: "),
            ),
            TextField(
              controller: controllers[5],
              decoration: InputDecoration(hintText: "Level: "),
            )
          ],
        
       
          );
      }
    
   //   ExcersiseHandling eh;
      WorkoutDBHandling wh;
      void _saveExercise(){
    
    // Award a=GymAchievements.MyFitJourney;
   // DisplayAchievement(a,new Profile(userinformation: userInfo),context).display();
    
        bool empty = false;
      
      /*  if (!empty) {
          
          Exercise exercise = new Exercise(
            controllers[0].text,
            controllers[1].text,
            controllers[2].text,
            [controllers[3].text],
            controllers[4].text,
            controllers[5].text,
          );
            Workout w=new Workout(
              user.uid,
              [exercise,exercise],
              "Chest Day",
              "",
              "Advanced",
    
            );
            print(w.toJson());
    
          wh.saveWorkout(w);
          eh.saveExcercise(exercise);
          controllers[0].clear();
          controllers[1].clear();
          controllers[2].clear();
          controllers[3].clear();
          controllers[4].clear();
          controllers[5].clear();
        }*/
         
      }
    
      void _updateExcercises(Exercise exercise) {
     
        setState(() {
        
          if(exercise.name!=null)
              result+=exercise.name+"\n";
            });
      }
    
      void _updateUserInfo(Register reg) {
        setState((){
          userInfo=reg;
        });
        
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard(
      {this.tabController,
        this.currentTime,
        this.currentDate,
        Key key,
        this.choice,
        this.isMorning})
      : super(key: key);

  final Widget choice;

  final String currentTime;
  final String currentDate;
  final bool isMorning;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        choice,
        Align(
        alignment: Alignment.bottomCenter,
          child:new Container(
              height: 48.0,
              alignment: Alignment.center,
              child: TabPageSelector(
                controller: tabController,
                color: Colors.black12,
                selectedColor: Colors.black54,
              )),
        ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

    /* new Text(
                  currentTime,
                  style: new TextStyle(
                    color: isMorning
                        ? HColors.midnightTextSecnodary
                        : HColors.midnightTextPrimary,
                    fontFamily: 'ExoBold',
                    fontSize: 44.0,
                  ),
                ),*/
                new Text(
                  currentDate,
                  style: new TextStyle(
                    color: isMorning ? Colors.black45 : Colors.indigoAccent,
                    fontFamily: 'ExoBold',
                    fontSize: 16.0,
                  ),
                ),

          ],
        ),
      ],
    );
  }
}