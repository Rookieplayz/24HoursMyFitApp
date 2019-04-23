 import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:speech_bubble/speech_bubble.dart';
import 'package:twenty_four_hours/Main/Award.dart';
import 'package:twenty_four_hours/Main/Profile.dart';
import 'package:twenty_four_hours/Widgets-Assets/confetti.dart';
import 'package:flare_flutter/flare_actor.dart';
class DisplayAchievement{
  Award award;
  Profile profile;
  BuildContext context;
  DisplayAchievement(this.award,this.profile,this.context);
void display()async {
  
    award.unlock(award, profile);
    OverlayState overlayState=Overlay.of(context);
    OverlayEntry overlayEntry=OverlayEntry(
      builder: (context)=>Positioned(
        top: 24.0,
        right: 10.0,
        child:SpeechBubble(
          color: award.grade==Grade.BRONZE?Colors.brown:award.grade==Grade.SILVER?Colors.blueGrey:Colors.amber,
          nipLocation: NipLocation.RIGHT,
          child:Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                fit: StackFit.loose,
              children:<Widget>[
               Container(
                   width: 50.0,
                 height: 50.0,
                 child:FlareActor(
            "Flare/colorful_bubbles.flr",fit: BoxFit.scaleDown,animation: "Grow",
                )),
               Positioned(
                 left: 6.0,
                 top: 10.0,
                 right: 9.0,
                 child:Shimmer.fromColors(
                highlightColor:award.grade==Grade.BRONZE?Colors.brown.shade200:award.grade==Grade.SILVER?Colors.blueGrey.shade100:Colors.amber.shade200,
                baseColor: Colors.white,
                child:Icon(FontAwesomeIcons.trophy)
              ))]),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(award.name),
                  Text(award.description,style: TextStyle(color: Colors.white54,fontFamily: 'Iceberg' ),),
                ],
              )
            ],
          ),
        )
      ));
   
      overlayState.insert(overlayEntry);
    
      await Future.delayed(Duration(seconds:10));
      overlayEntry.remove();
    
      }
      
}