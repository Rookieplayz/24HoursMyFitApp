import 'package:flutter/material.dart';
import 'package:twenty_four_hours/Widgets-Assets/24HColors.dart';

class ProfileImage extends StatelessWidget {
  final ImageProvider image;
  final Color color;
  final double width;
  final double height;
  final BoxShape shape;
  final String initials;
  final bool defaultImg;
  final bool isFill;
  final Color fill;

  const ProfileImage(
    @required this.defaultImg,
    @required this.isFill, {
    this.shape,
    this.image,
    this.color = Colors.blue,
    this.height = 100.0,
    this.initials = 'A',
    this.width = 100.0,
    this.fill = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return defaultImg
        ? new Container(
            width: width,
            height: height,
            child: new Center(
                child: new Text(initials,
                    style: new TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Jua',
                      color: Colors.white,
                    ))),
            decoration: new BoxDecoration(
              color: isFill || fill != null ? fill : Colors.transparent,
              border: new Border.all(color: color, width: 5.0),
              shape: shape,
              // color: color,
            ))
        : (new CircleAvatar(
          maxRadius: width*0.5,
          minRadius: width*0.1,
          backgroundImage:image,
          backgroundColor: color,
          ));
  }
}
