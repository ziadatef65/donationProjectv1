import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:donationproject/models/events_model.dart';
import 'package:donationproject/modules/admin/cubit/cubit.dart';
import 'package:donationproject/modules/admin/cubit/states.dart';
import 'package:donationproject/modules/donate_screen/donate_scree_money.dart';
import 'package:donationproject/modules/donate_screen/donate_screnn_food.dart';
import 'package:donationproject/modules/pay_screen/cubit/cubit.dart';
import 'package:donationproject/modules/selected_event/selected_event_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomeScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state)  {},
      builder: (context,state){
        return  Scaffold(
          backgroundColor: CupertinoColors.white,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.topLeft,
                                  colors: [
                                    Color.fromRGBO(92, 70, 156, 10),
                                    Colors.black87
                                  ]),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Image(
                                  image: AssetImage('assets/images/logo.png')),
                            )),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DonateWithFood()));
                            },
                            child: const CircleAvatar(
                              backgroundColor: Color.fromRGBO(29, 38, 125, 10),
                              radius: 25,
                              child: Center(
                                  child: Icon(
                                    Icons.fastfood_rounded,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DonateScreenWithMoney()));
                            },
                            child: const CircleAvatar(
                              backgroundColor: Color.fromRGBO(29, 38, 125, 10),
                              radius: 25,
                              child: Center(
                                  child: Icon(
                                    Icons.monetization_on_outlined,
                                    color: Colors.white,
                                    size: 25,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Container(
                  //   height: 300,
                  //   width: double.infinity,
                  //   child: Text(AdminCubit.get(context).sum.toString()),
                  // ),


                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('events').snapshots(),
                    builder: (context,snapshot){
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final documents = snapshot.data?.docs;
                      return documents!.isEmpty ? Center(child: Text('No events yet',style: GoogleFonts.cairo(fontSize: 40,fontWeight: FontWeight.w400, color: Color.fromRGBO(29, 38, 125, 10),),)):
                      SizedBox(
                        height: 530,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context,index)=>const SizedBox(width: 25,),
                          itemCount: documents.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            final event = documents[index];
                            return LayoutBuilder(
                              builder: (BuildContext context, BoxConstraints constraints) {
                                return SizedBox(
                                  width: 360,
                                  height:530, // Set the desired height for each item
                                  child:     Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Container(
                                          width: double.infinity,
                                          height: 530,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(30),
                                            color: const Color.fromRGBO(92, 70, 156, 10),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(bottom: 20,left: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 430,),
                                                event['target'] == 0? Row(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: Text('The event has been completed successfully',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.white),),
                                                    ),
                                                  ],
                                                ):
                                                Row(
                                                  children: [
                                                    Text('Our Target:',style: GoogleFonts.cairo(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                                                    const SizedBox(width: 10,),
                                                    Text('${event['target']} EGP',style: GoogleFonts.cairo(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                                                    const Spacer(),
                                                    InkWell(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> SelectedEventPage(event['imageOfEvent'],event['nameOfEvent'],event['percentage'],event['target'])));
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.white,
                                                        radius: 33,
                                                        child: Text('Donate',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,color: const Color.fromRGBO(92, 70, 156, 10) ),),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 20,),
                                                  ],
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6),
                                        child: Container(
                                          height: 420,
                                          decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.87),
                                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15),bottomRight: Radius.circular(90))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Stack(
                                                      clipBehavior: Clip.none,
                                                      children: [
                                                        Material(
                                                          elevation:10,
                                                          borderRadius: BorderRadius.circular(8),
                                                          child: Container(
                                                            height: 200,
                                                            width: 150,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8),
                                                                image:  DecorationImage(
                                                                  fit: BoxFit.cover,
                                                                  image: NetworkImage('${event['imageOfEvent']}'),
                                                                )),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          left: 110,
                                                          top: 60,
                                                          child: Material(
                                                            elevation: 10,
                                                            borderRadius:BorderRadius.circular(8),
                                                            child: Container(
                                                              width: 170,
                                                              height: 185,
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                              child: Padding(
                                                                padding: const EdgeInsets.all(20),
                                                                child: Center(child: Text('${event['nameOfEvent']}',style: GoogleFonts.heebo(fontWeight: FontWeight.bold,fontSize: 18),)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        if(event['target'] == 0  )
                                                        Positioned(
                                                            left: 220,
                                                            top:1,
                                                            child:
                                                            CircularPercentIndicator(
                                                              percent: 1,
                                                              progressColor: const Color.fromRGBO(92, 70, 156, 10),
                                                              radius: 40,
                                                              center:  Text('100 %',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 20)) ,
                                                            )),
                                                        if(event['target'] != 0 )
                                                        Positioned(
                                                            left: 220,
                                                            top:1,
                                                            child:
                                                            CircularPercentIndicator(
                                                              percent:  event['fixedTarget'] == event['target'] ?0:((event['target']*100)/event['fixedTarget'])/100 ,
                                                              progressColor: const Color.fromRGBO(92, 70, 156, 10),
                                                              radius: 40,
                                                              center: event['fixedTarget'] == event['target'] ? Text('0%',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 20)):Text('${((event['fixedTarget']-event['target'])*100)/event['fixedTarget']} %',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 20)),
                                                            )),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                Text(
                                                  'Details:',
                                                  style: GoogleFonts.cairo(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 24),
                                                ),
                                                Expanded(
                                                  child: Tooltip(
                                                    message: '${event['details']}',
                                                    child: Text(
                                                     '${event['details']}',maxLines: 3,overflow: TextOverflow.ellipsis,
                                                      style: GoogleFonts.cairo(

                                                          color: Colors.black,
                                                          fontSize: 18),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      // Expanded(
                      //   child: Container(
                      //     height: 120,
                      //     width: double.infinity,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(8),
                      //       color: const Color.fromRGBO(92, 70, 156, 10),
                      //     ),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Column(
                      //         children: [
                      //           Text(
                      //             "Your donation of money",
                      //             style: GoogleFonts.cairo(
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.white,
                      //                 fontSize: 15),
                      //           ),
                      //           const SizedBox(
                      //             height: 15,
                      //           ),
                      //           Text(
                      //             "${MainCubit.get(context).userModel?.numberOfDonationMoney} EGP",
                      //             style: GoogleFonts.cairo(
                      //                 fontWeight: FontWeight.bold,
                      //                 color: Colors.white,
                      //                 fontSize: 18),
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Expanded(
                        child: Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color.fromRGBO(12, 19, 79, 16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Your donation of food",
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "${MainCubit.get(context).userModel?.numberOfDonationFood} Times",
                                  style: GoogleFonts.cairo(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
