import 'dart:io';

import 'package:async/async.dart';
import 'package:path_provider/path_provider.dart';
enum THEMETYPE{MIDNIGHT,DAYLIGHT,EVENING}
class Setting
{
 /* static THEMETYPE theme=THEMETYPE.MIDNIGHT;
  static String fontfamily='jua';
  static bool notification=false;
  static bool gym_notification=false;
  static bool social_notification=false;
  static bool edu_notification=false;
  static bool downloadToLocal=false;
  static bool appearOnline=false;
  static bool location=false;
  static bool gestures=false;*/
   THEMETYPE theme=THEMETYPE.MIDNIGHT;
   String fontfamily='jua';
   bool notification=false;
   bool gym_notification=false;
   bool social_notification=false;
   bool edu_notification=false;
   bool downloadToLocal=false;
   bool appearOnline=false;
   bool location=false;
   bool gestures=false;

  
  final String filename="setting.txt";
  Setting({
     this.theme,
    this.fontfamily,
    this.notification,
    this.gym_notification,
    this.social_notification,
    this.edu_notification,
   this.downloadToLocal,
    this.appearOnline,
    this.location,
    this.gestures

  });

  

  Future<String> get _localPath async{
    final dir=await getApplicationDocumentsDirectory();
    print("path:${dir.path}");
    return dir.path;
  }
  Future<File> get _localFile async{
    final path=await _localPath;
    return File('$path/'+filename);
  }
 
  String saveData()
  {
     
     String result='';
    switch(theme){
      case THEMETYPE.MIDNIGHT:result+='MIDNIGHT';break;
      case THEMETYPE.DAYLIGHT:result+='DAYLIGHT';break;
      case THEMETYPE.EVENING:result+='EVENING';break;
    }
     result+="\n"+fontfamily;
    switch(notification){
      case true:
      {
        result+='\ntrue';
        switch (gym_notification) {
          case true:result+='\ntrue';break;
          case false:result+='\nfalse';break;
        }
        switch (social_notification) {
          case true:result+='\ntrue';break;
          case false:result+='\nfalse';break;
        }
        switch (edu_notification) {
          case true:result+='\ntrue';break;
          case false:result+='\nfalse';break;
        }
      }
      break;
      case false:result+='\nfalse\nfalse\nfalse\nfalse';break;
    }
     switch(downloadToLocal){
      case true:result+='\ntrue';break;
      case false:result+='\nfalse';break;
    }
    switch(gestures){
      case true:result+='\ntrue';break;
      case false:result+='\nfalse';break;
    }
     switch(location){
      case true:result+='\ntrue';break;
      case false:result+='\nfalse';break;
    }
     switch(appearOnline){
      case true:result+='\ntrue';break;
      case false:result+='\nfalse';break;
    }
     
    return result; 
  }
  @override
  String toString()
  {
   
  }

  void parseString(String s)
  {
    List<String>strs=s.split('\n');
   
    for(String str in strs)
    print("+$str");
    if(strs.length>9)
    { print(strs.length);
        String theme_str=strs[0];
        String font=strs[1];
        String notification_str=strs[2];
       String gnotification_str=strs[3];
       String snotification_str=strs[4];
       String enotification_str=strs[5];
        String appearOnline_str=strs[6];

        String gesture_str=strs[7];
        String loc_str=strs[8];
        
        String downloadToLocal_str=strs[9];

        print(theme_str);
        print(downloadToLocal_str);
        

        switch(theme_str){
        case 'MIDNIGHT':theme=THEMETYPE.MIDNIGHT;break;
        case 'DAYLIGHT':theme=THEMETYPE.DAYLIGHT;break;
        case 'EVENING':theme=THEMETYPE.EVENING;break;
      }
      fontfamily=font;
      switch(notification_str){
        case 'true':notification=true;break;
        case 'false':notification=false;break;
      }
      switch(gnotification_str){
        case 'true':gym_notification=true;break;
        case 'false':gym_notification=false;break;
      }
      switch(snotification_str){
        case 'true':social_notification=true;break;
        case 'false':social_notification=false;break;
      }
      switch(enotification_str){
        case 'true':edu_notification=true;break;
        case 'false':edu_notification=false;break;
      }
      switch(downloadToLocal_str){
        case 'true':downloadToLocal=true;break;
        case 'false':downloadToLocal=false;break;
      }
      switch(appearOnline_str){
        case 'true':appearOnline=true;break;
        case 'false':appearOnline=false;break;
      }
      switch(loc_str){
        case 'true':location=true;break;
        case 'false':location=false;break;
      }
      switch(gesture_str){
        case 'true':gestures=true;break;
        case 'false':gestures=false;break;
      }
    
  
    }
    print("THEME: $theme");
    print("Notification: $notification");
   
  }
  
  Future<File> saveSettings()async
  {
    print(theme);
    final file =await _localFile;
    print(file.lastModified().toString());
    return file.writeAsString(saveData());

  }
  Future<void> loadSettings() async
  {
      String contents;
    try{
      final file=await _localFile;
       contents=await file.readAsString();
       print("Hers the file content: $contents");
      
    }catch(e){
       contents='';
       print('creating file..');
       theme=THEMETYPE.MIDNIGHT;
        fontfamily='jua';
        notification=false;
        gym_notification=false;
        social_notification=false;
        edu_notification=false;
        downloadToLocal=false;
        appearOnline=false;
        location=false;
        gestures=false;
        saveSettings();


    }
    parseString(contents);
  }

}