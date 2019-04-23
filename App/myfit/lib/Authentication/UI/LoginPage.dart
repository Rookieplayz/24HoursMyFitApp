import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twenty_four_hours/Authentication/Model/Register.dart';
import 'package:twenty_four_hours/Authentication/auth.dart';
import 'package:twenty_four_hours/Authentication/auth_provider.dart';
import 'package:twenty_four_hours/Main/HomePage.dart';
import 'package:twenty_four_hours/NavigationControl.dart';
import 'package:twenty_four_hours/Widgets-Assets/24HColors.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(

  scopes: <String>[

    'email',

    'https://www.googleapis.com/auth/contacts.readonly',

  ],

);

class LoginPage extends StatefulWidget{
 final VoidCallback onSignedIn;
 final String fontfamily;
 final Key usernameFieldKey;
  final String password_hintText='';
  final String username_hintText='';
  final Color mainColor;
  final Color subColor;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmission;
  final GlobalKey<FormState> formkey;
  final GlobalKey<FormFieldState<String>> passwordKey;
  final List<String> users;
  final List<String> emails;



 LoginPage({this.onSignedIn,this.fontfamily='Jua',this.validator,
      this.mainColor,
      this.onFieldSubmission,
      this.onSaved,
      this.passwordKey,
      this.subColor,
      this.usernameFieldKey,
      this.formkey,
      this.users,
      this.emails});

  //instantiate State
  _LoginPageState createState()=>new _LoginPageState(fontfamily: fontfamily);
}
class _LoginPageState extends State<LoginPage> 
{
   
  GoogleSignInAccount _currentUser;

  String _contactText;
  final String fontfamily;
    _LoginPageState({this.fontfamily});  
  
  bool _autovalidate = false;
   bool _validname = false;
   bool validinput=false;
   TextEditingController _usernameController = new TextEditingController();
   TextEditingController _passwordController = new TextEditingController();
   bool _obscureText = true;
   var _validform = false;
   bool _validPassword = false;
   String email;
    var usernameMessage = new Text('');
  var errUsername = new Text('');
  bool submittimg=false;

   String _validateInput(String value){
     if(value.isEmpty)
     return 'A Field is Empty!';
     return null;
   }

   void _handleSubmitted() {
     print("submitting...");
     
   
      setState(() { submittimg=true;
        email = getEmail(_usernameController.text.toLowerCase());
        //for debug: 
      //  print("E:"+email);
        _handleLogin(email:email,password: _passwordController.text);
      });
    
  }
  /**
   * This method searches through the database for a user with the entered username,
   * and returns the email back.
   * @param username - takes a String
   * @return string
   */
  String getEmail(String username)
  {
    //search database
    //print("E: "+username);
 return widget.emails[widget.users.indexOf(username)];

  }
  /**
   * This method takes in the username to email input and the password
   * and varifies the user
   * @param email - username to Email
   * @param password
   */

 void saveUserInformation(Register userInfo,String image) async {
  DatabaseReference ref;
   FirebaseUser user=await FirebaseAuth.instance.currentUser();
       
      String UID = user.uid;
    //print("UID: $UID");
    ref = FirebaseDatabase.instance.reference();
    ref.child("User_Information").child(UID).push().set(userInfo.toJson());

    FirebaseDatabase.instance.setPersistenceEnabled(true);
    FirebaseStorage store = FirebaseStorage.instance;
    StorageReference path = store
        .ref()
        .child(UID)
        .child("Profile")
        .child("profile_pic.png");
    StorageUploadTask uploadTask = path.putFile(File(image));
  }

  void addNewUser(Register userInfo,String image,String e)
  {
    if(widget.emails.contains(e)){}
    else{
     
      saveUserInformation(userInfo, image);
    }
  }
   _handleLogin({String email='',String password=''})
  async
  {
     //for debug: print(email); print(password);
      String user;
      try {
      var auth = AuthProvider.of(context).auth;
      user = await auth.signInWithEmailAndPassword(email, password);

      print("done logging in");
     // print(user);

      print("new user set");
      return user;
      widget.onSignedIn();
    } catch (err) {
      print(err.toString());
      setState(() {
        submittimg=false;
        usernameMessage = new Text(
          err.toString(),
          style: new TextStyle(
              color:HColors.red, fontFamily: fontfamily, fontSize: 14.0),
          textAlign: TextAlign.center,
        );
        _validname=false;
      });
    } finally {
      if (user != null) {
        //Log in was successfull!
         NavigationControl(nextPage:new HomePage()).navTo(context);
       
      } else {
        setState(() {
          usernameMessage = new Text(
            "Incorrect password, please retry",
            style: new TextStyle(
                color:HColors.red, fontFamily: fontfamily, fontSize: 14.0),
            textAlign: TextAlign.center,
          );
          _validPassword=false;
        });
        //Log in was unsuccessfull!
      }
    }
  }
  Animation<Color> anim;
final Tween colorTween =
    ColorTween(begin: Colors.yellow, end: Colors.green);
@override
  void initState() {
    super.initState();
  
    _usernameController.addListener(onChange);
    _passwordController.addListener(onChange);
  
    //_textFocus.addListener(onChange);f
  }
  
  @override
  void dispose()
  {
    super.dispose();
  
    _usernameController.dispose();
    _passwordController.dispose();


  }
  void onChange()
  {
    if(_usernameController.text.isNotEmpty&&_passwordController.text.isNotEmpty)
    setState((){validinput=true;});
    else
     setState((){validinput=false;});
    

  }
Future<FirebaseUser> _handleSignIn() async {
FirebaseUser user;
return user;
   /* try {

      GoogleSignInAccount googleSignInAccount=await _googleSignIn.signIn();
      GoogleSignInAuthentication gsA=await googleSignInAccount.authentication;
      var auth = FirebaseAuth.instance;
       user=await auth.signInWithGoogle(
        idToken: gsA.idToken,
        accessToken: gsA.accessToken,

      );
      Register userInfo=new Register(
        user.uid,
        googleSignInAccount.displayName,
        googleSignInAccount.email,
        "",
        "",
        "",
        DateTime.now(),
        "",
        null,
        googleSignInAccount.photoUrl,
        []);
        addNewUser(userInfo,googleSignInAccount.photoUrl,userInfo.email);
      return user;



    } catch (error) {

      print(error);

    }
    finally{
      if (user != null) {
        //Log in was successfull!
        NavigationControl(nextPage:new HomePage()).navTo(context);
       
      }
    }

  }
    bool _loadingInProgress;
  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 5));
    _dataLoaded();
  }
    void _dataLoaded() {
    setState(() {
      _loadingInProgress = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: HColors.midnight_main,
      key: new Key("loginMain"),
      child:Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height-170,
        child:loginForm()
      )
      
    );*/
  }
  Widget loginForm()
  {
    return !submittimg?
    new SafeArea(
      top:false,
      bottom:true,
      child: new Form(
        key:widget.formkey,
        autovalidate: _autovalidate,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          /*  new Container(
                padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                height: 40.0,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.all(new Radius.circular(12.0)),
                  border: new Border.all(
                      color: _validname ? HColors.midnightAccent : HColors.red,
                      width: 2.5,
                      style: BorderStyle.solid),
                  color:HColors.transparent,
                ),*/
                new Padding(padding:EdgeInsets.all(5.0),child:
                 new TextFormField(
                  key: widget.usernameFieldKey,
                  controller: _usernameController,
                  validator: _validateInput,
                  style: new TextStyle(
                      fontFamily: fontfamily, fontSize: 16.0, color:HColors.white),
                  decoration: new InputDecoration(
                    fillColor: HColors.white10,
                    border: new UnderlineInputBorder(),
                    filled: true,
                    icon: _validname
                        ? const Icon(Icons.check_circle, color:HColors.green)
                        : const Icon(Icons.person,
                            color:HColors.midnightTextPrimary),
                    hintText: 'Enter Username/Email',
                    labelText: "Username/Email",
                    hintStyle: new TextStyle(
                        fontFamily: fontfamily,
                        color:HColors.white30,
                        fontSize: 16.0),
                    labelStyle: new TextStyle(
                        fontFamily: fontfamily, color:HColors.midnightTextPrimary),
                  ),
                )
                ),
             
            

              Padding(padding:const EdgeInsets.all(5.0),
                child: new TextFormField(
                  key: widget.passwordKey,
                  obscureText: _obscureText,
                  onSaved: widget.onSaved,
                  validator: _validPassword?(s){return "";}:(s){return "Incorrect password";},
                  controller: _passwordController,
                  style: new TextStyle(color:HColors.white, fontSize: 16.0),
                  decoration: new InputDecoration(
                    fillColor: HColors.white10,
                    border: new UnderlineInputBorder(),
                    filled: true,
                    icon: _validPassword
                        ? const Icon(Icons.lock_open, color:HColors.green)
                        : const Icon(Icons.lock,
                            color:HColors.red),
                    hintText: 'Enter Password',
                    labelText: "Password",
                    hintStyle: new TextStyle(
                        fontFamily: fontfamily,
                        color:HColors.white30,
                        fontSize: 16.0),
                    labelStyle: new TextStyle(
                        fontFamily: fontfamily, color:HColors.midnightTextPrimary),
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
              ),
              new Padding(padding: const EdgeInsets.all(12.0),child: usernameMessage,),
              
               new SizedBox(
                width: 340.0,
                height: 40.0,
                child: new RaisedButton(
                  
                  onPressed:validinput? _handleSubmitted:null,
                  child: new Text(
                    'Confirm',
                    style: new TextStyle(
                      fontFamily: fontfamily,
                      letterSpacing: 1.0,
                      fontSize: 16.0,
                      color:validinput?HColors.white:Colors.white24,
                    ),
                  ),
                  shape: new RoundedRectangleBorder(
                      side: new BorderSide(
                        color:HColors.midnightAccent,
                        width: 1.0,
                      ),
                      borderRadius: new BorderRadius.circular(20.0)),
                  color:HColors.midnightAccent,
                  elevation: 10.0,
                ),
              ),
                new Padding(padding: const EdgeInsets.all(12.0),child:Text("or",style:TextStyle(color:Colors.white,fontFamily: 'Jua'))),
              
               new SizedBox(
                width: 250.0,
                height: 60.0,
                child: new RaisedButton(
                  
                  onPressed:(){_handleSignIn()..then((user){}).catchError((e){print(e);});},
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                    Icon(FontAwesomeIcons.google,color: Colors.red,),
                    Text(
                    'Sign in with Goolge',
                    style: new TextStyle(
                      fontFamily: fontfamily,
                      letterSpacing: 1.0,
                      fontSize: 16.0,
                      color:HColors.white
                    ),
                  )]),
                  shape: new RoundedRectangleBorder(
                      side: new BorderSide(
                        color:HColors.white,
                        width: 2.0,
                      ),
                      borderRadius: new BorderRadius.circular(20.0)),
                  color:HColors.transparent,
                  elevation: 10.0,
                ),
              ),
          ],
        )

      )
    ):Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
  
}