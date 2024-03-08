import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player_flutter/home_main.dart';
import '../home.dart';
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 70),
          Stack(
            alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset('assets/images/img.jpg'),
            ),
            SizedBox(height: 100,),
            Positioned(
                child:  Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    "Dancing between                  The shadows                      Of rhythm",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            )
          ],
          ),
          Container(
            width: 300,
            child: Column(
              children: [

            Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Container(
              width: 290,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFFF3022),
              ),
              child: ElevatedButton(
                onPressed: () {
                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => MainHome()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(
                  'Get Started',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
      Container(
        width: 290,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
              width: 1,
              color: Color(0xFFFF3022)
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => MainHome()),
                  (Route<dynamic> route) => false,
            );
          },

          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          child: Text(
              'Continue with Email',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,

                  decoration: TextDecoration.none,
                  color: Color(0xFFFF3022),
                ),
              )
          ),
        ),
      ),
      const SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.all(0),
        child: Text( textAlign: TextAlign.center,
          "by continuing you agree to terms of services and  Privacy policy",
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: Colors.grey,
                fontSize: 12

              )
          ),
        ),
      )
              ],
            ),
          )
        ],
      ),
    );
  }
}