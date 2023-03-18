import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pay_screen/pay_screen.dart';

class DonateScreenWithMoney extends StatefulWidget {
  const DonateScreenWithMoney({Key? key}) : super(key: key);

  @override
  State<DonateScreenWithMoney> createState() => _DonateScreenWithMoneyState();
}
Color c1 = CupertinoColors.black;
Color c2 = CupertinoColors.black;
Color c3 = CupertinoColors.black;
class _DonateScreenWithMoneyState extends State<DonateScreenWithMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        iconTheme: IconThemeData(color: CupertinoColors.black
        ),
        centerTitle: true,
        title: Text('Donate with money..',style: TextStyle(color: CupertinoColors.black),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 70,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: c1,
                        )
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          c1 = Colors.blueAccent;
                        });
                      },
                      child: Text('\$50',style: TextStyle(fontWeight: FontWeight.bold,color: c1)),

                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    
                    height: 70,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: c2,
                      )
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          c2 = Colors.blueAccent;
                        });
                      },
                      child: Text('\$100',style: TextStyle(fontWeight: FontWeight.bold,color: c2)),

                    ),
                    
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Container(
                    height: 70,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: c3,
                        )
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          c3 = Colors.blueAccent;
                        });
                      },
                      child: Text('\$500',style: TextStyle(fontWeight: FontWeight.bold,color: c3),),

                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 40,),
            Row(children: [
              Expanded(
                child: Container(
                  height: 2,
                  width: 190,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: 10,),
              Text('Or',style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(width: 10,),
              Expanded(
                child: Container(
                  height: 2,
                  width: 190,
                  color: Colors.grey,
                ),
              ),

            ],),
            SizedBox(height: 30,),
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade400,
                  hintText: "                       Enter your price manualy",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Container(
              height: 50,
                width: double.infinity,
                child: TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> PayScreen()));
                }, child: Text('Donate Now',style: TextStyle(fontWeight: FontWeight.bold,color: CupertinoColors.white),)),
              color: CupertinoColors.activeBlue,
            )
          ],

        ),
      ),
    );
  }
}
