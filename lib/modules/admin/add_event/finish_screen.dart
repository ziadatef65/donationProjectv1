import 'package:donationproject/layout/layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FinishScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 260,),
            Center(child: Text('The event has been added successfully',textAlign: TextAlign.center,style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 24,),)),
            const SizedBox(height: 200,),
            Center(
              child: InkWell(
                child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.topLeft,
                            colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                        ),

                        borderRadius:
                        BorderRadius.circular(
                            10)),
                    child:   Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          'Back to home',
                          style: GoogleFonts.cairo(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                ),
                onTap: () {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LayoutScreen()), (route) => false);


                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

