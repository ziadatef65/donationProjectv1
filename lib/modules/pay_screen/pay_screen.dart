import 'package:donationproject/modules/done_screen/done_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        iconTheme: IconThemeData(color: CupertinoColors.black
        ),
        centerTitle: true,
        title: Text('Pat Now...',style: TextStyle(color: CupertinoColors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all()
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Image(image: AssetImage('assets/images/paypal.png')),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "2121 6352 8465 ****",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 500,),
            Container(
              height: 50,
              width: double.infinity,
              child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> DoneScreen()));
              }, child: Text('Pay Now',style: TextStyle(fontWeight: FontWeight.bold,color: CupertinoColors.white),)),
              color: CupertinoColors.activeBlue,
            )
          ],
        ),
      ),
    );
  }
}
