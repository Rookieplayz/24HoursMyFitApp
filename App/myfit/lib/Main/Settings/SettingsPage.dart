import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twenty_four_hours/Authentication/Model/Register.dart';
import 'package:twenty_four_hours/Main/Settings/Setting.dart';
import 'package:twenty_four_hours/Main/main.dart';

class SettingsPage extends StatefulWidget
{
  Setting setting;
  Register user=null;
  SettingsPage({
    this.setting,
    this.user
  });

  SettingState createState()=>SettingState(setting: setting,user:user);
}
class SettingState extends State<SettingsPage>
{
  Register user;
  Setting setting;
  SettingState({
    this.setting,
    this.user
  });

  bool midnight=true;
  bool daylight=false;
  bool evening=false;
  bool disableNotifications=false;

  @override
  void initState() {
    // TODO: implement initState
    switch(setting.theme)
    {
      case THEMETYPE.DAYLIGHT:_radioValue=1;break;
      case THEMETYPE.EVENING: _radioValue=2;break;
      case THEMETYPE.MIDNIGHT:_radioValue=0;break;
    }
    disableNotifications=!setting.notification;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Scaffold(
        appBar:AppBar(
          title: new Text("Settings"),
          leading: new Icon(Icons.settings),
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body:new ListView(

          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Text("Theme",style: new TextStyle(fontWeight:FontWeight.bold,fontFamily:setting.fontfamily,fontSize: 16,color: Theme.of(context).accentColor,)),
            Divider(color: Theme.of(context).accentColor,),
            ListTile(title: Text("Midnight"),
              trailing: new Radio(
                value:0,
                groupValue: _radioValue,
                onChanged: changeTheme,
              ),
              subtitle: Text("Your whole app has a darker-navy theme"),
              onTap: (){setState(() {
                _radioValue=0;
                changeTheme(_radioValue);
              });},
            ),

            Divider(),
            ListTile(title: Text("DayLight"),trailing: new Radio(
              value:1,
              groupValue: _radioValue,
              onChanged: changeTheme,
            ),
              subtitle: Text("Your whole app has a bright theme"),
              onTap: (){setState(() {
                _radioValue=1;
                changeTheme(_radioValue);
              });},
            ),
            Divider(),
            ListTile(title: Text("Evening"),trailing: new Radio(
              value:2,
              groupValue: _radioValue,
              onChanged: changeTheme,
            ),
              subtitle: Text("Your whole app has a purple theme"),
              onTap: (){setState(() {
                _radioValue=2;
                changeTheme(_radioValue);
              });},
            ),

            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Padding(
                    padding: const EdgeInsets.only(top:10),
                    child:Text("Notifications",style: new TextStyle(fontWeight:FontWeight.bold,fontFamily:setting.fontfamily,fontSize: 16,color: Theme.of(context).accentColor,))),

                Switch(onChanged:_allNotifications,value:setting.notification)
              ],),
            Divider(color: Theme.of(context).accentColor,),
            ListTile(
              enabled: !disableNotifications,
              onTap: (){setState(() {

                if(setting.gym_notification)setting.gym_notification=false;
                else setting.gym_notification=true;
                _gnChanged(setting.gym_notification);
              });},
              title: Text("Health & Fitness"),trailing:Checkbox(
              value: setting.gym_notification,
              onChanged: disableNotifications?(b){}:_gnChanged,
            ),

              subtitle: Text(setting.gym_notification?"You will now Recieve Notification from myFit":"You will not recieve myFit Notifications"),
            ),
            Divider(),
            ListTile(
              onTap: (){setState(() {
                if(setting.social_notification)setting.social_notification=false;
                else setting.social_notification=true;
                _lnChanged(setting.social_notification);
              });},
              enabled: !disableNotifications,
              title: Text("Lifestyle"),trailing: Checkbox(
              value: setting.social_notification,
              onChanged: disableNotifications?(b){}:_lnChanged,

            ),

              subtitle: Text(setting.social_notification?"You will now recieve Notifications from myLifestyle":"You will not Recieve Notifications from myLifestyle"),
            ),
            Divider(),
            ListTile(
              onTap: (){setState(() {
                if(setting.edu_notification)setting.edu_notification=false;
                else setting.edu_notification=true;
                _enChanged(setting.edu_notification);
              });},
              enabled: !disableNotifications,
              title: Text("Education"),trailing:Checkbox(
              value: setting.edu_notification,
              onChanged: disableNotifications?(b){}:_enChanged,
            ),

              subtitle: Text(setting.edu_notification?"You will now recieve Notifications from myEdu":"You will no longer Recieve myEdu Notifications"),
            ),
            Divider(),
            Padding(
                padding: const EdgeInsets.only(top:10),
                child:Text("Visibility",style: new TextStyle(fontWeight:FontWeight.bold,fontFamily:setting.fontfamily,fontSize: 16,color: Theme.of(context).accentColor,))),
            Divider(color: Theme.of(context).accentColor,),

            ListTile(

              title: Text("Appear Online"),
              trailing: Switch(value: setting.appearOnline,onChanged:_onlineChanged),
              subtitle: Text(setting.appearOnline?"You can be seen online":"You cannot be seen not Online"),
              onTap: (){setState(() {
                if(setting.appearOnline)setting.appearOnline=false;
                else setting.appearOnline=true;
                _onlineChanged(setting.appearOnline);
              });},
            ),
            Divider(),
            ListTile(
              onTap: (){setState(() {
                if(setting.location)setting.location=false;
                else setting.location=true;
                _locationChanged(setting.location);
              });},
              title: Text("Location"),
              trailing: Switch(value: setting.location,onChanged:_locationChanged),
              subtitle: Text(setting.location?"Your location is on":"Your location is off"),
            ),


            Text("My Account",style: new TextStyle(fontWeight:FontWeight.bold,fontFamily:setting.fontfamily,fontSize: 16,color:Theme.of(context).accentColor)),
            Divider(color:Theme.of(context).accentColor),
            user!=null?
            ListTile(
              title: Text("Sign out",style: TextStyle(color: Colors.red),),
              subtitle:Column(
                  children:<Widget>[
                    ListTile(
                        title:Text("Name"),
                        subtitle:Text("${user.first_name} ${user.second_name}"
                        )),
                    Divider(),
                    ListTile(
                        title:Text("currently Signed in as"),
                        subtitle:Text("${user.username}"
                        )),
                    Divider(),
                    ListTile(
                        title:Text("Email"),
                        subtitle:Text("${user.email}"
                        )),
                    Divider(),
                    ListTile(
                        title:Text("Birthday"),
                        subtitle:Text("${user.DOB}")),

                  ]),
            ):

            ListTile(
              title: Text("Login/Register",style: TextStyle(color: Colors.teal),),
              subtitle: Text("You are currently not signed in"),
            ),


            Text("About",style: new TextStyle(fontWeight:FontWeight.bold,fontFamily:setting.fontfamily,fontSize: 16,color:Theme.of(context).accentColor)),
            Divider(color:Theme.of(context).accentColor),
            ListTile(
              title: Text("Version"),
              subtitle: Text("version 0.0.1"),
              enabled: false,
            ),
            Divider(),
            ListTile(
              title: Text("Third-party Software"),
              subtitle: Text("A big thanks to all these wonderful software"),
            ),
            Divider(),
            ListTile(
              title: Text("T&Ts"),
              subtitle: Text("Terms and conditions"),
            ),
            Divider(),
            ListTile(
              title: Text("Privacy Policy"),
              subtitle: Text("see more"),
            ),

          ],

        )
    );
  }
  var _radioValue=0;
  void changeTheme(int value)
  {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          {
            DynamicTheme.of(context).setThemeData(Themes.MIDNIGHT);

            setting.theme=THEMETYPE.MIDNIGHT;
          }
          break;
        case 1:
          {

            DynamicTheme.of(context).setThemeData(Themes.DAYLIGHT);
            setting.theme=THEMETYPE.DAYLIGHT;
          }
          break;
        case 2:
          {
            DynamicTheme.of(context).setThemeData(Themes.EVENING);
            setting.theme=THEMETYPE.EVENING;
          }
          break;
      }
    });
    setting.saveSettings();
    setState(() {

    });
  }
  void _allNotifications(bool value)
  {
    if(value)
    {
      setState((){
        disableNotifications=false;
        setting.notification=true;
        setting.edu_notification=true;
        setting.social_notification=true;
        setting.gym_notification=true;

        setting.saveSettings();
      });
    }
    else{
      setState((){
        disableNotifications=true;
        setting.notification=false;
        setting.edu_notification=false;
        setting.social_notification=false;
        setting.gym_notification=false;
        setting.saveSettings();
      });
    }
  }
  void _gnChanged(bool value) => setState(() {setting.gym_notification = value; setting.saveSettings();});
  void _lnChanged(bool value) => setState(() { setting.social_notification = value; setting.saveSettings();});
  void _enChanged(bool value) => setState((){ setting.edu_notification = value; setting.saveSettings();});
  void _locationChanged(bool value) => setState((){setting.location = value; setting.saveSettings();});
  void _onlineChanged(bool value) => setState(() { setting.appearOnline = value; setting.saveSettings();});



}