import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class ViewEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(

                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.topLeft,
                      colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),

                ),
                child: Center(child: Text('Review the events',style: GoogleFonts.cairo(fontSize: 24,color: Colors.white),)),
              ),
              SizedBox(height: 20,),
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
                    height: 640,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                      itemCount: documents.length,
                      scrollDirection: Axis.vertical,
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
                                        padding: const EdgeInsets.only(bottom: 20,left: 20,),
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
                                                  onTap: ()async{
                                                    await FirebaseFirestore.instance.collection('events').doc(event['nameOfEvent']).delete();
                                                  },
                                                  child: CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    radius: 33,
                                                    child: Text('Delete',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,color: const Color.fromRGBO(92, 70, 156, 10) ),),
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
            ],
          ),
        ),
      ),
    );
  }
}
