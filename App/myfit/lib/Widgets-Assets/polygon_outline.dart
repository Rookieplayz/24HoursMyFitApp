
import 'package:flutter/material.dart';
import 'package:twenty_four_hours/Widgets-Assets/24HColors.dart';
import 'package:twenty_four_hours/Widgets-Assets/HexagonDrawer.dart';
import 'package:twenty_four_hours/Widgets-Assets/polygon_path_drawer.dart';

class HexagonOutlined extends StatelessWidget
{
  Color color;
  Size size;
  double width;
  Widget _child;
  bool animated;


  HexagonOutlined( this._child,{this.animated=false,this.color:HColors.midnightTextPrimary, this.size:const Size(100.0,100.0), this.width=4.0});
  static int sides=6;
  static double rotate=0.0;
  static double borderRadius=5.0;
  PolygonPathSpecs specs = new PolygonPathSpecs(
    sides: sides < 3 ? 3 : sides,
    rotate: rotate,
    borderRadiusAngle: borderRadius,
  );
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(

      overflow: Overflow.visible,
      children: <Widget>[
       animated?new AnimateHexagonOutline(specs,[new PolygonLine(color:color)],size:size,width:width,color: color,capType:StrokeCap.square,style:PaintingStyle.stroke):
      new PolygonOutline(specs,[new PolygonLine(color:color)],size:size,width:width,color: color,capType:StrokeCap.square,style:PaintingStyle.stroke),

        Container(height:size.height, width:size.width),
        Positioned(
          top: size.height/10+10,
          left: size.width/10 +12,
          child: new Container(width:size.width-50,height:size.height-50,child:new Center(child:_child)),

        ),



      ],
    );
  }

}