

import 'package:flutter/material.dart';

class GradientAnimation extends StatefulWidget {

  final LinearGradient begin;

  final LinearGradient end;

  final AnimationController controller;



  const GradientAnimation({

    Key key,

    @required this.controller,

    @required this.begin,

    @required this.end,

  }) : super(key: key);



  @override

  _GradientAnimationState createState() => _GradientAnimationState();

}



class _GradientAnimationState extends State<GradientAnimation> {

  Animation<LinearGradient> _animation;



  @override

  void initState() {

    _animation = LinearGradientTween(

      begin: widget.begin,

      end: widget.end,

    ).animate(widget.controller);



    super.initState();

  }



  @override

  Widget build(BuildContext context) {

    return AnimatedBuilder(

      animation: _animation,

      builder: (context, _) {

        return Container(

          decoration: BoxDecoration(

            gradient: _animation.value,

          ),

        );

      },

    );

  }

}



/// An interpolation between two LinearGradients.

///

/// This class specializes the interpolation of [Tween] to use

/// [LinearGradient.lerp].

///

/// See [Tween] for a discussion on how to use interpolation objects.

class LinearGradientTween extends Tween<LinearGradient> {

  /// Provide a begin and end Gradient. To fade between.

  LinearGradientTween({

    LinearGradient begin,

    LinearGradient end,

  }) : super(begin: begin, end: end);



  @override

  LinearGradient lerp(double t) => LinearGradient.lerp(begin, end, t);

}