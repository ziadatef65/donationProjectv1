import 'package:donationproject/modules/admin/show_users/default_users.dart';
import 'package:donationproject/modules/admin/show_users/delivery_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../add_event/add_event_name.dart';

class UsersPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 80,right: 20,left: 20,bottom:20),
        child: Column(
          children: [
            InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DefaultUsersPage()));
              } ,
              child: Column(
                children: [
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child:Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                              gradient: const LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.topLeft,
                                  colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20,top: 5),
                              child: Row(
                                children: [
                                  Text(
                                    'Default user',style: GoogleFonts.cairo(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  Icon(CupertinoIcons.person,color: Colors.white,size: 30,),
                                  SizedBox(width: 35,),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ) ,
                    ),
                  ),


                ],
              ),
            ),
            SizedBox(height: 70,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DeliveryUserScreen()));

              },
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child:Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                          gradient: const LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.topLeft,
                              colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,top: 5),
                          child: Row(
                            children: [
                              Text(
                                'Deliveries',style: GoogleFonts.cairo(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Icon(Icons.delivery_dining_sharp,color: Colors.white,size: 30,),
                              SizedBox(width: 35,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ) ,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
