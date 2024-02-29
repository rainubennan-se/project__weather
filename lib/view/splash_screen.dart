import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:project__weather/view/bottom_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();
    Timer(Duration(seconds: 10), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MyHomePage()));
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: AnimateList(
              interval: 400.ms,
              effects: const [FadeEffect(duration: Duration(seconds: 5))],
              children: const [
                Icon(
                  Icons.sunny_snowing,
                  color: Colors.amber,
                  size: 100,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "el clima",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            )),
      ),
    );
  }
}
