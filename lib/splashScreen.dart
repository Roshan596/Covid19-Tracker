import 'dart:async';

import 'package:app/worldStates.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> with TickerProviderStateMixin{
  late final AnimationController _controller=AnimationController(duration: Duration(seconds: 3),vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5),
    ()=>Navigator.push(context, MaterialPageRoute(builder:(context) =>Worldstates() ,))
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(animation: _controller, 
          child: Container(
            height: 200,
            width: 200,
            child: Center(
              child: 
              Image(image: AssetImage('images/virus1.png')),
            ),
          ),
          
          builder:(context, child) {
            return Transform.rotate(angle: _controller.value * 2.0 * math.pi,
            child: child,
            
            );
          },),
          SizedBox(height: MediaQuery.of(context).size.height*.08,),
          Align(
            alignment: AlignmentGeometry.center,
            child: Center(child: Text("Covid-19\nTracker App",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),)))

        ],
      ) 
      )

    );
  }
}