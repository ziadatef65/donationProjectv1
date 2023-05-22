
import 'package:donationproject/modules/donate_screen/donate_screnn_food.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'donate_scree_money.dart';

class DonateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: CupertinoColors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 25,top: 40,right: 25,bottom: 25),
        child: Column(
          children: [
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DonateScreenWithMoney()));
              },
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.topLeft,
                        colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                    ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text('Donate with money',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.white),),
                      const Spacer(),
                      const Icon(Icons.monetization_on_outlined,color: Colors.white,size: 40,),
                    ],
                  ),
                ),
              ),
            ),
       const     SizedBox(height: 40,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DonateWithFood()));
              },
              child: Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.topLeft,
                      colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Text('Donate with food',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.white),),
                      Spacer(),
                      Icon(Icons.fastfood_rounded,color: Colors.white,size: 40,),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )



      ),
    );
  }
}
