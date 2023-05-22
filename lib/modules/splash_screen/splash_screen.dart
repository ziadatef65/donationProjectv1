import 'dart:async';
import 'package:donationproject/modules/splash_screen/splash_screen2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/network/local/cache_helper.dart';
import '../login_page/login_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SplashScreen2()));


      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => LoginScreen()),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splashScreen.png"),
            fit: BoxFit.cover,
          ),
        ),
        child:  Center(
          // child: Image(image: AssetImage('assets/images/bg.png'))
          
          child:Text(
            "Donation",
            style: GoogleFonts.cairo(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

