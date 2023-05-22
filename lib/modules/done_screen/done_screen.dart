import 'package:donationproject/layout/layout.dart';
import 'package:donationproject/modules/home_screen/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        iconTheme: IconThemeData(color: CupertinoColors.black
        ),
       elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child:Image(image: AssetImage('assets/images/done.png'),),),
            SizedBox(height: 10,),
            Expanded(child: Text('Thank You! for your Donation when delivery accept your order we will make you know',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize:24,),textAlign: TextAlign.center,)),
            Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),

                color: const Color.fromRGBO(29, 38, 125, 10),

              ),
              child: TextButton(
                onPressed: ()
                {
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LayoutScreen()), (route) => false);
                },
                child: Center(child: Text('Back to home',style: GoogleFonts.cairo(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
