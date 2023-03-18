
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'donate_scree_money.dart';

class DonateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: CupertinoColors.black,
        ),
        title: Text('Donate',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: CupertinoColors.black),),
        centerTitle:true,
      ),
      backgroundColor: CupertinoColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
              children: [

                 Material(
                   elevation: 10,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                   child: Container(
                     height: 200,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                       border: Border.all(),
                       image: DecorationImage(
                           image: AssetImage('assets/images/donate1.jpg'),
                         fit: BoxFit.cover,
                         ),
                       ),

                     ),
                 ),
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                      border: Border.all(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Donate with money',style: TextStyle(fontSize: 24),),
                          Spacer(),
                          IconButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DonateScreenWithMoney()));
                          }, icon: Icon(Icons.arrow_forward_ios_rounded))
                        ],
                      ),
                    ),

                  ),
                ),
                SizedBox(height: 20,),
                Material(
                   elevation: 10,
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                   child: Container(
                     height: 200,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
                       border: Border.all(),
                       image: DecorationImage(
                           image: AssetImage('assets/images/donation2.jpg'),
                         fit: BoxFit.cover,
                         ),
                       ),

                     ),
                 ),
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft: Radius.circular(25)),
                      border: Border.all(),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text('Donate with food',style: TextStyle(fontSize: 24),),
                          Spacer(),
                          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios_rounded))
                        ],
                      ),
                    ),

                  ),
                ),




              ]
          ),
        ),
      ),
    );
  }
}
