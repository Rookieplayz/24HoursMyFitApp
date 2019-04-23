import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:twenty_four_hours/Authentication/Model/Register.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twenty_four_hours/Authentication/UI/LoginPage.dart';
import 'package:twenty_four_hours/Authentication/auth.dart';
import 'package:twenty_four_hours/Extras/username_gen.dart';
import 'package:twenty_four_hours/MyFit/Models/Follows.dart';

import 'package:twenty_four_hours/Main/HomePage.dart';
import 'package:twenty_four_hours/Main/Profile.dart';
import 'package:twenty_four_hours/Main/root_page.dart';
import 'package:twenty_four_hours/NavigationControl.dart';
import 'package:twenty_four_hours/Widgets-Assets/24HColors.dart';
import 'package:twenty_four_hours/Widgets-Assets/ChipTile.dart';
import 'package:twenty_four_hours/Widgets-Assets/DatePicker.dart';
import 'package:twenty_four_hours/Widgets-Assets/ProfileImage.dart';

class RegisterPage extends StatefulWidget
{
    FirebaseUser user;
  FirebaseAuth Fauth;
  List<UIDs> uids = [];
  Register userInfo;
  List<Register> userInfos = List();
  String UID = '';
  DatabaseReference reference;
  List<String> countries=new List<String>();
  

  RegisterPage({this.countries,this.Fauth,this.uids,this.userInfo,this.UID,this.userInfos,this.reference});

  @override
  RegisterPageState createState()=>RegisterPageState(values:countries,Fauth: Fauth,uids:uids,userInfo: userInfo,userInfos:userInfos,UID:UID,reference:reference);

}
class RegisterPageState extends State<RegisterPage>
{
   File _image;

  
  FirebaseUser user;
  FirebaseAuth Fauth;
  List<UIDs> uids = [];
  Register userInfo;
  List<Register> userInfos = List();
  String UID = '';
  DatabaseReference reference;
  Profile myProfile;
  String ff="jua";

  RegisterPageState({this.values,this.Fauth,this.uids,this.userInfo,this.userInfos,this.UID,this.reference});

  Register register;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;

      defaultImages = false;
    });
  }

  Future takePic() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;

      defaultImages = false;
    });
  }

  Future<FirebaseUser> saveAuth(String password, String email) async {
    print("Username: $email, password: $password");
    try{
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password).
        then((user){user.sendEmailVerification();snackBar("An Email Varification has been sent to $email. Confirm then continue");return user;}).catchError((e){print(e);});
    }catch(e){print("error occured");}
    return null;
  }


  DatabaseReference ref;

  Future<void> saveUserInformation(var user) async {
    if(user!=null)
    UID = user.uid;
    print("UID: $UID");
   
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    ref = FirebaseDatabase.instance.reference();
    ref.child("User_Information").child(UID).push().set(userInfo.toJson());

    // ref.child("Profile").child(UID).push().set(myProfile.toJson());

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseStorage store = FirebaseStorage.instance;
    StorageReference path = store
        .ref()
        .child(UID)
        .child("Profile")
        .child("profile_pic.png");
    StorageUploadTask uploadTask = path.putFile(_image);
      UserUpdateInfo updateInfo = new UserUpdateInfo();
    updateInfo.displayName = username;
    updateInfo.photoUrl = _image.path;
    user.updateProfile(updateInfo);
    
    await user.reload();
  }

  var formkey = new GlobalKey<FormState>();
  var formkey3 = new GlobalKey<FormState>();
  DateFormat dateFormat;
  static bool _validEmail = false;
  static bool _validName = false;
  static bool _validPassword = false;
  static bool _obscureText = true;
  List<String> values = new List<String>();
  List<String> _MCC = new List<String>();
  List<String> countries = new List<String>();
  String _value;
  String _value2 = '93 ';
  var pick = '353';
  var snackbar;

  DateTime _fromDate = new DateTime.now();
  String generatedUsername;
  var ageError = new Text('');
  String username = '';
  String password = '';
  String email = '';
  String fn = '', sn = '', sex = 'Male', phone_no = '00000000';
  DateTime birthday = new DateTime.now();

   TextEditingController _controller = new TextEditingController();
   TextEditingController _econtroller = new TextEditingController();
   TextEditingController _pcontroller = new TextEditingController();

   TextEditingController _ucontroller = new TextEditingController();
   TextEditingController _fncontroller = new TextEditingController();
   TextEditingController _sncontroller = new TextEditingController();
   TextEditingController _phoneController = new TextEditingController();

  final _UsNumberTextInputFormatter _phoneNumberFormatter =
      new _UsNumberTextInputFormatter();
  var mainformkey;
  int radioValue = 0;
  bool switchValue = false;
  bool defaultImages = true;

  var isTwoCompleted = false;

  var isThreeCompleted = false;
  var isFourCompleted = true;
  var isFiveCompleted = false;
  var isSixCompleted = false;
  var isSevenCompleted = false;
  bool isAllComplete = false;

  String userInitials = 'A';

  var phoneSupplied = false;
  List<String> _interests = [
    'Health & fitness',
    'Blogging',
    'Cooking',
    'Music',
    'Hip-Hop',
    'R&B',
    'Rock',
    'Pop',
    'Jazz',
    'Movies',
    'Tv',
    'Concerts',
    'Tech',
    'Books',
    'Science',
    'Plants',
    'Basketball',
    'Soccer',
    'American Football',
    'Rugby',
    'Sports',
    'Travel',
    'Games',
    'Photography',
    'Art',
  ];
  Set<String> selectedIntrests;
  Map<String, double> _startLocation;
  Map<String, double> _currentLocation;

  StreamSubscription<Map<String, double>> _locationSubscription;

  Location _location = new Location();
  String error;

  bool currentWidget = true;

  @override
  void dispose() {
    super.dispose();
    _pcontroller.dispose();
    
    _controller.dispose();
    _ucontroller.dispose();
    _econtroller.dispose();
  }

  initPlatformState() async {
   // Map<String, double> location;
    // Platform messages may fail, so we use a try/catch PlatformException.

    try {
     // location = await _location.getLocation;
     // print(location);

      error = null;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      } else if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error =
            'Permission denied - please ask the user to enable it from the app settings';
      }

      //location = null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    //if (!mounted) return;

    setState(() {
     // _startLocation = location;
    });
  }

  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      if (radioValue == 0)
        sex = 'Male';
      else if (radioValue == 1)
        sex = 'Female';
      else
        sex = 'other';
    });
  }

  var formkey2 = new GlobalKey<FormState>();

  generateName() {
    generatedUsername = new UsernameGenerator().getUsername();
    print(generatedUsername);
  }

  bool isValidBirthday() {
    print("age: ${new DateTime.now().year - _fromDate.year}");
    if (new DateTime.now().year - _fromDate.year >= 6) {
      return true;
    } else {
      return false;
    }
  }

  void SaveAndValidate() {
    final formState = formkey.currentState;
    if (formState.validate())
      setState(() {
        password=_controller.text.trim();
        email=_econtroller.text.trim();
        username=_ucontroller.text.trim();
        isOneCompleted = true;
        if(email.contains(" "))
        email=email.split(" ")[0];
        print("Email: "+email);
        
        
      });
    else
      isOneCompleted = false;
  }

  void SaveAndValidate2() {
    final formState = formkey2.currentState;
    if (formState.validate())
      setState(() {
        isTwoCompleted = true;
        userInitials = fn.substring(0, 1);
        if (sn.isNotEmpty) {
          userInitials += " " + sn.substring(0, 1);
        }
      });
    else
      isTwoCompleted = false;
  }

  void SaveAndValidate3() {
    final formState = formkey3.currentState;
    if (formState.validate())
      setState(() {
        isFiveCompleted = true;
      });
    else
      isFiveCompleted = false;
  }

  void divideValues() {
    var temp;
    if (values.isNotEmpty)
      for (String s in values) {
        temp = s.split(':');
        _MCC.add(temp[1]);
        countries.add(temp[0]);
      }
  }

  String __isValidName(String name) {
    if (name.isEmpty) {
      _validName = false;
      return 'Field Required';
    } else
      return null;
  }

  String _isValidUser(String name) {
    if (name.isNotEmpty) {
      if (!isUserExisting(name)) {
        return null;
      } else
        return 'Username $name is Taken ';
    } else
      return 'Empty Field!';
  }

  String _isValidEmail(String email) {
      if(email.contains(" "))
        email=email.split(" ")[0];
    if (email.isNotEmpty) {
      if (email.contains('@')) {
        if (!isUserExisting(email)) {
          return null;
        }
        return 'This User Already Exists';
      } else
        return 'Email must contain @ ';
    } else
      return 'Empty Field!';
  }

  bool validEmail(String email) {
      if(email.contains(" "))
        email=email.split(" ")[0];
    if (email.isNotEmpty&&email.contains('@')&&!isUserExisting(email))return true;
    else return false;
     
  }
  bool validPassword(String password) {
    password = password.trim();
    password = password.replaceAll(" ", "");
    RegExp regExp = new RegExp(".*[A-Z]+.*");
    RegExp regExp1 = new RegExp(".*[a-z]+.*");
    RegExp regExp2 = new RegExp(".*[0-9]+.*");
    // userDetails.add(new ArrayList<String>());
    int T = 0, F = 0;

    if (password.length >= 8&&regExp.allMatches(password).isNotEmpty&&regExp1.allMatches(password).isNotEmpty&&regExp2.allMatches(password).isNotEmpty)
    return true;
    else return false;
  }


  String isValidPassword(String password) {
    password = password.trim();
    password = password.replaceAll(" ", "");
    RegExp regExp = new RegExp(".*[A-Z]+.*");
    RegExp regExp1 = new RegExp(".*[a-z]+.*");
    RegExp regExp2 = new RegExp(".*[0-9]+.*");
    // userDetails.add(new ArrayList<String>());
    int T = 0, F = 0;

    if (password.length >= 8) {
      if (regExp.allMatches(password).isNotEmpty) {
        print(regExp.allMatches(password));
        if (regExp1.allMatches(password).isNotEmpty) {
          if (regExp2.allMatches(password).isNotEmpty) {
            return null;
          } else {
            return "Must have a Number";
          }
        } else {
          return "Lowercase Letter missing";
        }
      } else {
        return "An UPPERCASE letter is a must";
      }
    } else {
      return "Password is too short min (6)";
    }
  }

  String _validatePhoneNumber(String value) {
    _formWasEdited = true;

    final RegExp phoneExp = new RegExp(r'^\(\d\d\d\) \d\d\d\-\d\d\d\d$');

    if (!phoneExp.hasMatch(value))
      return '  (###)  ###-#### - Enter Your phone number.';

    return null;
  }



  Locale myLocale;
  final Set<String> _materials = new Set<String>();

  void _reset() {
    _materials.clear();

    _materials.addAll(_interests);
    _selectedMaterial = '';

    _selectedAction = '';
    _selectedTools.clear();
  }

  void _removeTool(String name) {
    _materials.remove(name);

    _selectedTools.remove(name);
  }

 Future<void> checkConfirmation()async
 {
    var user = await FirebaseAuth.instance.currentUser();
   if(user!=null)
   while(!user.isEmailVerified)
   {
    // print("Email is not varified");
     
   }
   else{
     print("no user");
   }
 }

  @override
  void initState() {
    super.initState();
 
  
    dateFormat = new DateFormat.yMMMMd('en_ISO');
    //myLocale=Localizations.localeOf(context);
    // _controller.addListener(onChange);
   // initPlatformState();

    /*_locationSubscription =
      _location.onLocationChanged.listen((Map<String,double> result) {
        setState(() {
          _currentLocation = result;
          print(_currentLocation);
        });
      });*/

    _sncontroller.addListener(s_onChange);
    _fncontroller.addListener(s_onChange);

    _reset();


    //_textFocus.addListener(onChange);
  }

  void _onChanged(String value) {
    setState(() {
      _value = value;
      _value2 = _MCC.elementAt(values.lastIndexOf(value));
    });
  }

  String acceptName() {
    return generatedUsername;
  }

  bool isOneCompleted = false;

  TimeOfDay _fromTime = const TimeOfDay(hour: 7, minute: 28);
  int current_step = 0;

  List<Step> my_steps;

  bool _autovalidate = false;
  int _tapped = 0;
  bool _formWasEdited = false;

  // List<DropdownMenuItem> locations = [new Drop];

  Color _nameToColor(String name) {
    assert(name.length > 1);
    final int hash = name.hashCode & 0xffff;
    final double hue = (360.0 * hash / (1 << 15)) % 360.0;
    return new HSVColor.fromAHSV(1.0, hue, 0.4, 0.90).toColor();
  }


  bool isUserExisting(String user) {
    bool doesExists = false;
    for (Register users in userInfos) {
      print(users.email.toLowerCase() == user.toLowerCase());
      if (users.username.toLowerCase() == user.toLowerCase() ||
          users.email.toLowerCase() == user.toLowerCase()) return true;
    }
    return false;
  }


  _sendSMS() {}

  bool loadingUser=false;
  compleSetup() async{
    if(validEmail(email)&&validPassword(password))
    saveAuth(password, email).then((user){
    
     // saveAuth(password, email);
     if(user!=null){
       print("Saving user..."+user.email);
       setState(() {
                loadingUser=true;
              });
  
    userInfo = new Register(
      user.uid,
        username,
        email,
        fn,
        sn,
        new DateFormat.yMd('en_ISO').format(birthday),
        new DateTime.now(),
        sex,
        num.tryParse(phone_no),
        _image.path,
        _interests);
   // saveUserInformation();
    print(register); saveUserInformation(user)..then((user){
      setState((){
        loadingUser=false;
        _showAlertDialog('');
      });
    });
 }

  else{
   print(user);
   setState(() {
        loadingUser=true;
      });
 
   
 }}); 
   
  }

  Future<Null> _showAlertDialog(String value) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        print('showing....');
        return new AlertDialog(
          content: new Center(
            child: new Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new ProfileImage(defaultImages, true,
                        initials: userInitials,
                        image: _image != null
                            ? new FileImage(_image)
                            : new AssetImage('images/hbot_wave.png'),
                        width: 100.0,
                        height: 100.0,
                        color:HColors.midnightAccent,
                        shape: BoxShape.circle,
                        fill:HColors.midnightAccent),
                    new Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage('images/ic_launcher.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                new Padding(padding: const EdgeInsets.only(top: 35.0)),
                new Text('Congrats $fn,  We\'re Glad that You Joined us.',
                    style: new TextStyle(
                      fontFamily: 'Jua',
                    ))
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
                onPressed:null,//((){NavigationControl()}),
                child: new Text(
                  'Gimme a Tour',
                  style: new TextStyle(color:HColors.blue),
                )),
            // new FlatButton(onPressed: _sendSMS, child: new Text('Send SMS',style: new TextStyle(color:HColors.blue),)),
            new FlatButton(
                onPressed: ((){NavigationControl(nextPage: HomePage()).navTo(context);}),
                child: new Text(
                  'Take me Home',
                  style: new TextStyle(color:HColors.green),
                )),
          ],
        );
      },
    );
  }
void snackBar(String msg)
{
  FirebaseUser user;
  final snackBar = SnackBar(
    duration: Duration(minutes: 5),
    content: Text(msg),action: SnackBarAction(
    label:"Resend",
    onPressed: (){user.sendEmailVerification();},
    
  ),);

// Find the Scaffold in the Widget tree and use it to show a SnackBar
Scaffold.of(context).showSnackBar(snackBar);

}
  String _capitalize(String name) {
    assert(name != null && name.isNotEmpty);
    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }

  /*Locale myLocale = Localizations.localeOf(context);
    print(myLocale.countryCode);*/
  String _selectedMaterial = '';
  String _selectedAction = '';
  final Set<String> _selectedTools = new Set<String>();

  @override
  Widget build(BuildContext context) {
       divideValues();
 _value = values.elementAt(14);
    final List<Widget> choiceChips = _materials.map<Widget>((String name) {
      return new FilterChip(
        key: new ValueKey<String>(name),
        backgroundColor: _nameToColor(name),
        label: new Text(_capitalize(name)),
        selected:
            _materials.contains(name) ? _selectedTools.contains(name) : false,
        onSelected: !_materials.contains(name)
            ? null
            : (bool value) {
                setState(() {
                  if (!value) {
                    _selectedTools.remove(name);
                  } else {
                    _selectedTools.add(name);
                  }
                  if (_selectedTools.isNotEmpty) {
                    isSixCompleted = true;
                  }
                });
              },
      );
    }).toList();

    snackbar = SnackBar(
      duration: new Duration(seconds: 5),
      content: Text('This email is Linked to an Account'),
      action: SnackBarAction(
        label: 'Login',
        onPressed: () {
         NavigationControl(nextPage:LoginPage()).navTo(context);
          // Some code to undo the change!
          /*  Navigator.push(context, new PageRouteBuilder(
              opaque: false,
              pageBuilder: (BuildContext context, _, __) {
                return new Center(child: new Text('My PageRoute'));
              },
              transitionsBuilder: (___, Animation<double> animation, ____, Widget child) {
                return new FadeTransition(
                  opacity: animation,
                  child: new RotationTransition(
                    turns: new Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                    child: child,
                  ),
                );
              }
          ));*/
        },
      ),
    );
    // Scaffold.of(context).showSnackBar(snackbar);

    my_steps = [
      new Step(

          // Title of the Step

          title: new Text(
            isOneCompleted ? "Registered *" : "Register *",
            style: new TextStyle(
              color: isOneCompleted
                  ?HColors.lightGreenAccent
                  :HColors.lightBlueAccent,
              fontFamily: 'ExoLight',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),

          // Content, it can be any widget here. Using basic Text for this example

          content: new Form(
            key: formkey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 24.0,
                ),
                new TextFormField(
                  controller: _ucontroller,
                  validator: (value) => _isValidUser(value),
                  style: const TextStyle(
                      color:HColors.white, fontSize: 14.0, fontFamily: 'Jua'),
                  decoration: InputDecoration(
                     fillColor: HColors.white10,
                    filled: true,
                    border: const UnderlineInputBorder(),
                    icon: const Icon(Icons.person,
                        color:HColors.midnightTextPrimary),
                    hintText: 'Enter Username..',
                    hintStyle: const TextStyle(
                        color:HColors.white70,
                        fontSize: 14.0,
                        fontFamily: 'Jua'),
                    labelText: 'Username',
                    labelStyle: TextStyle(
                        color:HColors.midnightTextPrimary,
                        fontSize: 14.0,
                        fontFamily: 'ExoLight'),
                    suffixIcon: new GestureDetector(
                      onTap: () {
                        generateName();
                        setState(() {
                          _ucontroller.text = generatedUsername;
                          username = _ucontroller.text.trim();
                        });
                      },
                      child: new Icon(
                        Icons.assignment_ind,
                        color:HColors.lightGreenAccent,
                      ),
                    ),
                  ),
                ),
                new Padding(padding: const EdgeInsets.only(top: 12.0)),
                new TextFormField(
                  controller: _econtroller,
                  validator: (value) => _isValidEmail(value),
                  style: const TextStyle(
                      color:HColors.white, fontSize: 14.0, fontFamily: 'Jua'),
                  decoration: InputDecoration(
                       fillColor: HColors.white10,
                    filled: true,
                      border: const UnderlineInputBorder(),
                      icon: new Icon(Icons.email,
                          color: _validEmail
                              ?HColors.lightGreenAccent
                              :HColors.midnightTextPrimary),
                      hintText: 'Enter Email..',
                      hintStyle: const TextStyle(
                          color:HColors.white70,
                          fontSize: 14.0,
                          fontFamily: 'Jua'),
                      labelText: 'Email',
                      labelStyle: const TextStyle(
                          color:HColors.midnightTextPrimary,
                          fontSize: 14.0,
                          fontFamily: 'ExoLight')),
                ),
                new Padding(padding: const EdgeInsets.only(top: 12.0)),
                new TextFormField(
                  style: const TextStyle(
                      color:HColors.white,
                      fontSize: 14.0,
                      fontFamily: 'sans-serif'),
                  obscureText: _obscureText,
                  validator: (value) => isValidPassword(value),
                  controller: _controller,
                  decoration: new InputDecoration(
                    border: const UnderlineInputBorder(),
                       fillColor: HColors.white10,
                    filled: true,
                    
                    icon: _validPassword
                        ? const Icon(Icons.lock_open, color:HColors.green)
                        : const Icon(Icons.lock,
                            color:HColors.midnightTextPrimary),
                    hintText: 'Enter Password',
                    labelText: "Password",
                    hintStyle: new TextStyle(
                        fontFamily: 'Jua',
                        color:HColors.white30,
                        fontSize: 18.0),
                    labelStyle: new TextStyle(
                        fontFamily: 'Jua', color:HColors.midnightTextPrimary),
                    suffixIcon: new GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: new Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color:HColors.midnightAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          state: isOneCompleted ? StepState.complete : StepState.error,
          isActive: true),
      new Step(
          title: new Text(
            isTwoCompleted ? fn + " " + sn + " *" : "Full-Name *",
            style: new TextStyle(
              color: isTwoCompleted
                  ?HColors.lightGreenAccent
                  :HColors.lightBlueAccent,
              fontFamily: 'ExoLight',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          content: new Form(
            key: formkey2,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 24.0,
                ),
                new TextFormField(
                  controller: _fncontroller,
                  validator: (value) => __isValidName(value),
                  style: const TextStyle(
                      color:HColors.white, fontSize: 14.0, fontFamily: 'Jua'),
                  decoration: InputDecoration(
                       fillColor: HColors.white10,
                    filled: true,
                      border: const UnderlineInputBorder(),
                      icon: new Icon(Icons.perm_identity,
                          color:HColors.midnightTextPrimary),
                      hintText: 'Enter First name..',
                      hintStyle: const TextStyle(
                          color:HColors.white70,
                          fontSize: 14.0,
                          fontFamily: 'Jua'),
                      labelText: 'First name',
                      labelStyle: const TextStyle(
                          color:HColors.midnightTextPrimary,
                          fontSize: 18.0,
                          fontFamily: 'Jua')),
                ),
                new Padding(padding: const EdgeInsets.only(top: 12.0)),
                new TextFormField(
                  controller: _sncontroller,
                  style: const TextStyle(
                      color:HColors.white, fontSize: 14.0, fontFamily: 'Jua'),
                  decoration: InputDecoration(
                       fillColor: HColors.white10,
                    filled: true,
                      border: const UnderlineInputBorder(),
                      hintText: 'Enter Last name..',
                      hintStyle: const TextStyle(
                          color:HColors.white70,
                          fontSize: 14.0,
                          fontFamily: 'Jua'),
                      labelText: 'Last name',
                      labelStyle: const TextStyle(
                          color:HColors.midnightTextPrimary,
                          fontSize: 18.0,
                          fontFamily: 'Jua')),
                ),
              ],
            ),
          ),

          // You can change the style of the step icon i.e number, editing, etc.

          state: isTwoCompleted ? StepState.complete : StepState.error,
          isActive: true),
      new Step(
          title: new Text(
            isThreeCompleted
                ? 'DOB: ' +
                    new DateFormat.yMd('en_ISO').format(_fromDate) +
                    ' (${new DateTime.now().year - _fromDate.year})'
                : "Birthday *",
            style: new TextStyle(
              color: isThreeCompleted
                  ?HColors.lightGreenAccent
                  :HColors.lightBlueAccent,
              fontFamily: 'ExoLight',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          content: new Column(
            children: <Widget>[
              new DatePicker(
                 fillColor: HColors.white10,
                    filled: true,
                labelText: 'When\'s Your B-Day',
                selectedDate: _fromDate,
                labelStyle: new TextStyle(
                    color:HColors.midnightTextPrimary,
                    fontSize: 18.0,
                    fontFamily: 'Jua'),
                labelStyle2: new TextStyle(
                    color:HColors.white, fontSize: 14.0, fontFamily: 'Jua'),
                valueStyle: new TextStyle(
                    color:HColors.midnightTextPrimary,
                    fontSize: 14.0,
                    fontFamily: 'Jua'),
                selectDate: (DateTime date) {
                  setState(() {
                    _fromDate = date;
                  });
                  if (isValidBirthday()) {
                    setState(() {
                      isThreeCompleted = true;
                      ageError = new Text('');
                    });
                  } else {
                    setState(() {
                      isThreeCompleted = false;
                      ageError = new Text(
                          'Oops Sorry! You must be 6 or over to have an account',
                          style: new TextStyle(
                              color:HColors.red,
                              fontFamily: 'Jua',
                              fontSize: 16.0));
                    });
                  }
                },
              ),
              ageError
            ],
          ),
          state: isThreeCompleted ? StepState.complete : StepState.error,
          isActive: true),
      new Step(
          title: new Text(
            isFourCompleted ? "Gender: $sex" : "Gender: Male *",
            style: new TextStyle(
              color: isFourCompleted
                  ?HColors.lightGreenAccent
                  :HColors.lightBlueAccent,
              fontFamily: 'ExoLight',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          content: new Column(
            children: <Widget>[
              new Icon(Icons.wc, color:HColors.midnightTextPrimary),
              new Padding(padding: const EdgeInsets.only(left: 6.0)),
              new Text(
                'Select Gender',
                style: new TextStyle(
                    color:HColors.midnightTextPrimary,
                    fontFamily: 'Jua',
                    fontSize: 16.0),
              ),
              new Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                new Row(children: <Widget>[
                  new Row(
                    children: <Widget>[
                      new Text(
                        '\u2642',
                        style: new TextStyle(
                            color:HColors.blue,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Jua'),
                      ),
                      new Text(
                        'Male',
                        style: new TextStyle(
                            color:HColors.midnightTextPrimary,
                            fontSize: 14.0,
                            fontFamily: 'Jua'),
                      ),
                    ],
                  ),
                  new Radio<int>(
                      value: 0,
                      groupValue: radioValue,
                      onChanged: handleRadioValueChanged)
                ]),
                new Row(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Text(
                          '\u2640',
                          style: new TextStyle(
                              color:HColors.pinkAccent,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Jua'),
                        ),
                        new Text(
                          'Female',
                          style: new TextStyle(
                              color:HColors.midnightTextPrimary,
                              fontSize: 14.0,
                              fontFamily: 'Jua'),
                        ),
                      ],
                    ),
                    new Radio<int>(
                        value: 1,
                        groupValue: radioValue,
                        activeColor:HColors.pinkAccent,
                        onChanged: handleRadioValueChanged),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Text(
                      'Other',
                      style: new TextStyle(
                          color:HColors.midnightTextPrimary,
                          fontSize: 14.0,
                          fontFamily: 'Jua'),
                    ),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Radio<int>(
                        value: 2,
                        groupValue: radioValue,
                        activeColor:HColors.deepPurpleAccent,
                        onChanged: handleRadioValueChanged),
                  ],
                ),
              ]),
            ],
          ),
          state: StepState.complete,
          isActive: true),
      new Step(
          title: new Text(
            isFiveCompleted ? phone_no : "Phone Number: Not Provided",
            style: new TextStyle(
              color: isFiveCompleted
                  ?HColors.lightGreenAccent
                  :HColors.lightBlueAccent,
              fontFamily: 'ExoLight',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          content: new Column(
            children: <Widget>[
              new DropdownButton(
                  value: _value,
                  items: values.map((String value) {
                    return new DropdownMenuItem(
                      value: value,
                      child: new Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Icon(
                            Icons.assistant_photo,
                            color:HColors.blue,
                          ),
                          Text("${value}",
                              style: new TextStyle(
                                  color:HColors.blueGrey,
                                  fontSize: 14.0,
                                  fontFamily: 'Jua')),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    _onChanged(value);
                  }),
              new TextFormField(
                controller: _phoneController,
                validator: (value) => _validPhoneNumber(value),
                style: new TextStyle(
                  color:HColors.white,
                  fontSize: 14.0,
                  fontFamily: 'Jua',
                ),

                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    fillColor: HColors.white10,
                    filled: true,


                    // icon: const Icon(Icons.phone,color:HColors.midnightTextPrimary),

                    labelText: 'Phone Number',
                    labelStyle: new TextStyle(
                        color:HColors.midnightTextPrimary,
                        fontSize: 14.0,
                        fontFamily: 'Jua'),
                    prefixText: '+ ${_value2} ',
                    prefixStyle: new TextStyle(
                        color:HColors.midnightTextPrimary,
                        fontFamily: 'Jua',
                        fontSize: 16.0)),

                keyboardType: TextInputType.phone,

                // onSaved: (String value) { person.phoneNumber = value; },

                // TextInputFormatters are applied in sequence.

                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,

                  // Fit the validating format.

                  _phoneNumberFormatter,
                ],
              ),
            ],
          ),
          state: isFourCompleted ? StepState.complete : StepState.indexed,
          isActive: true),
      new Step(
          title: new Text(
            isSixCompleted
                ? "Interests: ${_selectedTools.length} Selected"
                : "Interests: None Selected",
            style: new TextStyle(
              color: isSixCompleted
                  ?HColors.lightGreenAccent
                  :HColors.lightBlueAccent,
              fontFamily: 'ExoLight',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          content: new Column(
            children: <Widget>[
              new Icon(Icons.touch_app, color:HColors.midnightTextPrimary),
              new Padding(padding: const EdgeInsets.only(left: 6.0)),
              new Text(
                'Select your interests',
                style: new TextStyle(
                    color:HColors.midnightTextPrimary,
                    fontFamily: 'Jua',
                    fontSize: 16.0),
              ),
              new ChipTile(label: '', children: choiceChips),
            ],
          ),
          state: isSixCompleted ? StepState.complete : StepState.editing,
          isActive: true),
      new Step(
          title: new Text(
            "Profile Pic",
            style: new TextStyle(
              color: isSevenCompleted
                  ?HColors.lightGreenAccent
                  :HColors.lightBlueAccent,
              fontFamily: 'ExoLight',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          content: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new ProfileImage(
                defaultImages,
                false,
                initials: userInitials,
                image: _image != null
                    ? new FileImage(_image)
                    : new AssetImage('images/hbot_wave.png'),
                width: 100.0,
                height: 100.0,
                color:HColors.midnightTextPrimary,
                shape: BoxShape.circle,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      new FloatingActionButton(
                        onPressed: getImage,
                        backgroundColor:HColors.purpleAccent,
                        tooltip: 'Pick Image',
                        child: new Icon(Icons.image),
                      ),
                      new Text(
                        'Pick Image',
                        style: new TextStyle(
                            color:HColors.midnightTextPrimary,
                            fontFamily: 'Jua',
                            fontSize: 16.0),
                      )
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      new FloatingActionButton(
                        onPressed: takePic,
                        tooltip: 'Take a Pic',
                        child: new Icon(Icons.camera_alt),
                      ),
                      new Text(
                        'Take a Pic',
                        style: new TextStyle(
                            color:HColors.midnightTextPrimary,
                            fontFamily: 'Jua',
                            fontSize: 16.0),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
          state: isSixCompleted ? StepState.complete : StepState.editing,
          isActive: true),
      new Step(
          title: new Text(
            "Finalize",
            style: new TextStyle(
              color: isAllComplete
                  ?HColors.lightGreenAccent
                  :HColors.lightBlueAccent,
              fontFamily: 'ExoLight',
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          content: loadingUser?new CircularProgressIndicator():new Container(
            child: new RaisedButton(
              onPressed:isAllComplete?(){print("i'm Good");compleSetup();}:null,
              shape: new RoundedRectangleBorder(
                  side: new BorderSide(
                    color:isAllComplete?HColors.green:HColors.red,
                    width: 2.0,
                  ),
                  borderRadius: new BorderRadius.circular(20.0)),
              color:HColors.green,
              child: new Text(
                isAllComplete
                    ? 'I\'m Happy with everything ☺'
                    : 'Oops you\'re not Done',
                style: new TextStyle(
                    color: isAllComplete ?HColors.white70 :HColors.red,
                    fontSize: 14.0,
                    fontFamily: 'Jua'),
              ),
            ),
          ),
          state: isAllComplete ? StepState.complete : StepState.editing,
          isActive: true),
    ];

    return new Form(
      key: mainformkey,

      autovalidate: _autovalidate,

      //onWillPop: _warnUserAboutInvalidData,

      child: new Flexible(
        child: new Stepper(
          // Using a variable here for handling the currentStep

          currentStep: this.current_step,

          // List the steps you would like to have

          steps: my_steps,

          // Define the type of Stepper style

          // StepperType.horizontal :  Horizontal Style

          // StepperType.vertical   :  Vertical Style

          type: StepperType.vertical,

          // Know the step that is tapped

          onStepTapped: (step) {
            // On hitting step itself, change the state and jump to that step
            if (step == 0)
              SaveAndValidate();
            else if (step == 1) SaveAndValidate2();
            setState(() {
              // update the variable handling the current step value

              // jump to the tapped step

              setState(() {
                isFiveCompleted = true;
              });
              current_step = step;
              print("OnStepped: $current_step");
              if (step == 0)
                SaveAndValidate();
              else if (step == 1) {
                SaveAndValidate2();
              } else if (step == 4) {
                phone_no = _phoneController.text.trim();
                if (_validPhoneNum()) {
                } else {
                  setState(() {
                    isFiveCompleted = false;
                  });
                }
              } else if (step == 5) {
                isSevenCompleted = true;
              } else if (step == 6) {
                email = _econtroller.text.trim();
                username = _ucontroller.text.trim();
                password = _controller.text.trim();
                fn = _fncontroller.text.trim();
                sn = _sncontroller.text.trim();
                birthday = _fromDate;
                phone_no = phone_no;
                String interests;

                for (String s in _selectedTools) {
                  interests += s + "\n";
                }

                print(
                    "Username: $username\nEmail: $email\nPassword: $password\nFirst name: $fn\nSecond name: $sn\nGender: $sex\nPhone no.: $phone_no\nInterest: ${interests}");
              } else if (step == 7) {
                if (isOneCompleted &&
                    isTwoCompleted &&
                    isThreeCompleted &&
                    isFourCompleted) isAllComplete = true;
              
              }
            });

            // Log function call

            print("onStepTapped : " + step.toString());
          },

          onStepCancel: () {
            // On hitting cancel button, change the state

            setState(() {
              // update the variable handling the current step value

              // going back one step i.e subtracting 1, until its 0

              if (current_step > 0) {
                current_step = current_step - 1;
              } else {
                current_step = 0;
              }
            });

            // Log function call

            print("onStepCancel : " + current_step.toString());
          },

          // On hitting continue button, change the state

          onStepContinue: () {
            setState(() {
              // update the variable handling the current step value

              // going back one step i.e adding 1, until its the length of the step

              if (current_step < my_steps.length - 1) {
                current_step = current_step + 1;
              } else {
                if (isOneCompleted &&
                    isTwoCompleted &&
                    isThreeCompleted &&
                    isFourCompleted) isAllComplete = true;
               // sendEmail();
              }
              var step = current_step;
              print("Oncontinued: $step");
              if (step == 1)
                SaveAndValidate();
              else if (step == 2)
                SaveAndValidate2();
              else if (step == 4) {
                email = _econtroller.text.trim();
                username = _ucontroller.text.trim();
                password = _controller
                    .text.trim(); //.replaceRange(1, _controller.text.length, '*');
                fn = _fncontroller.text.trim();
                sn = _sncontroller.text.trim();
                birthday = _fromDate;
                phone_no = phone_no;
              } else if (step == 3) {
                email = _econtroller.text.trim();
                username = _ucontroller.text.trim();
                password = _controller
                    .text.trim(); //.replaceRange(1, _controller.text.length, '*');
                fn = _fncontroller.text.trim();
                sn = _sncontroller.text.trim();
                birthday = _fromDate;
                phone_no = phone_no;
              } else if (step == 5) {
                email = _econtroller.text.trim();
                username = _ucontroller.text.trim();
                password = _controller
                    .text.trim(); //.replaceRange(1, _controller.text.length, '*');
                fn = _fncontroller.text.trim();
                sn = _sncontroller.text.trim();
                birthday = _fromDate;
                phone_no = phone_no;
                phone_no = _phoneController.text.trim();
                if (_validPhoneNum()) {
                  setState(() {
                    isFiveCompleted = true;
                  });
                } else {
                  setState(() {
                    isFiveCompleted = false;
                  });
                }
              } else if (step == 6) {
                email = _econtroller.text.trim();
                username = _ucontroller.text.trim();
                password = _controller
                    .text.trim(); //.replaceRange(1, _controller.text.length, '*');
                fn = _fncontroller.text.trim();
                sn = _sncontroller.text.trim();
                birthday = _fromDate;
                phone_no = phone_no;
                isSevenCompleted = true;
              } else if (step == 7) {
                email = _econtroller.text.trim();
                username = _ucontroller.text.trim();
                password = _controller
                    .text.trim(); //.replaceRange(1, _controller.text.length, '*');
                fn = _fncontroller.text.trim();
                sn = _sncontroller.text.trim();
                birthday = _fromDate;
                phone_no = phone_no.trim();
                if (isOneCompleted &&
                    isTwoCompleted &&
                    isThreeCompleted &&
                    isFourCompleted) isAllComplete = true; 
                   // compleSetup();
              
              }
              else if (step == 8) {

               
               print("Step 8");
              //  saveAuth(password, email);
                compleSetup();
              }
            });

            // Log function call

            print("onStepContinue : " + current_step.toString());
          },
        ),
      ),
    );
  }

  static String _validatePassword(String value) {}

  void seePassword() {
    setState(() {});
  }

  void onChange() {
    _ucontroller.text = username;
    print(isValidPassword(_controller.text));
  }

  void s_onChange() {
    setState(() {
      fn = _fncontroller.text.trim();
      sn = _sncontroller.text.trim();
    });
  }

  String _validPhoneNumber(String value) {
    if (value.length < 5) {
      return 'This Phone Number is Invalid';
    } else
      return null;
  }

  bool _validPhoneNum() {
    if (phone_no.length < 5) {
      return false;
    } else
      return true;
  }
}

class UIDs {
  var _uid;

  UIDs(this._uid);

  String get uid => _uid;

  set uid(dynamic value) {
    _uid = value;
  }

  UIDs.fromSnapshot(DataSnapshot snapshot) : _uid = snapshot.key;
}

class _UsNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;

    int selectionIndex = newValue.selection.end;

    int usedSubstringIndex = 0;

    final StringBuffer newText = new StringBuffer();

    if (newTextLength >= 1) {
      newText.write('(');

      if (newValue.selection.end >= 1) selectionIndex++;
    }

    if (newTextLength >= 4) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 3) + ') ');

      if (newValue.selection.end >= 3) selectionIndex += 2;
    }

    if (newTextLength >= 7) {
      newText.write(newValue.text.substring(3, usedSubstringIndex = 6) + '-');

      if (newValue.selection.end >= 6) selectionIndex++;
    }

    if (newTextLength >= 11) {
      newText.write(newValue.text.substring(6, usedSubstringIndex = 10) + ' ');

      if (newValue.selection.end >= 10) selectionIndex++;
    }

    // Dump the rest.

    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));

    return new TextEditingValue(
      text: newText.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
