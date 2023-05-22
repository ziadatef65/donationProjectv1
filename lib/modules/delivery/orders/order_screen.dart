import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:donationproject/layout/layout.dart';
import 'package:donationproject/shared/components/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/user_model.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../waiting_page/waiting_page.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, DonationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return

            StreamBuilder<UserModel>(
                stream: MainCubit.get(context).userModelStream,
                builder: (context, AsyncSnapshot<UserModel> snapshot) {
                  if (snapshot.hasData && snapshot.data?.orderNow == true) {
                    return Scaffold(
             body:
             StreamBuilder<UserModel>(stream: MainCubit.get(context).userModelStream,
                 builder: (context, AsyncSnapshot<UserModel> snapshot) {
                   if (snapshot.hasData && snapshot.data?.orderNow == true) {
                     return
                       Scaffold(
                         backgroundColor: Colors.white,
                         body: Padding(
                           padding: const EdgeInsets.all(
                               20),
                           child: Column(
                               crossAxisAlignment: CrossAxisAlignment
                                   .center,
                               mainAxisAlignment: MainAxisAlignment
                                   .center,
                               children: [
                                 const Center(
                                     child: Icon(
                                       CupertinoIcons
                                           .lock_circle,
                                       size: 180,
                                         color: Color.fromRGBO(29, 38, 125, 10),
                                     )),
                                 Text(
                                   'Now you can\'t use the application now until user give us feedback if you receive the order or no',
                                   textAlign: TextAlign
                                       .center,
                                   style: GoogleFonts
                                       .cairo(
                                       fontWeight: FontWeight
                                           .bold,
                                       fontSize: 20,
                                     color: Color.fromRGBO(29, 38, 125, 10),),),
                               ]),
                         ),
                       );
                   } else {
                     return Container(
                       color: Colors.white,
                       child: Center(
                         child: Text('No order acceptable yet',style: GoogleFonts.cairo(
                             fontWeight: FontWeight.bold,fontSize: 24,color: Colors.black87
                         ),),
                       ),
                     );
                   }
                 }
             ) );
                  } else {
                    return Scaffold(
                      backgroundColor: Colors.white,
                      body: state is GetUserLoadingState ? const Center(
                        child: CircularProgressIndicator(),)
                          : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Container(
                            height: 580,
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance.collection(
                                  'orders').snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                final documents = snapshot.data?.docs;

                                return
                                  documents!.isEmpty ? Center(child: Text('No orders yet',style: GoogleFonts.cairo(fontSize: 40,fontWeight: FontWeight.w400, color: Color.fromRGBO(29, 38, 125, 10),),)):
                                  ListView.separated(
                                  itemCount: documents!.length,
                                  itemBuilder: (context, index) {
                                    final order = documents[index];
                                    return Padding(
                                      padding:
                                      const EdgeInsets.only(left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 20),
                                      child: Container(
                                        height: 300,
                                        child: Card(
                                          elevation: 8,
                                          color: Colors.grey.shade300,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: SingleChildScrollView(
                                              physics: const BouncingScrollPhysics(),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Order-${index + 1}',
                                                        style: GoogleFonts
                                                            .cairo(
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            fontSize: 24,
                                                            color: Colors.blue),
                                                      ),
                                                      const Spacer(),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator
                                                                .pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>
                                                                        LayoutScreen()), (
                                                                route) => false);
                                                            MainCubit.get(
                                                                context)
                                                                .updateOrderState(
                                                                true,
                                                                order['userId']);
                                                            MainCubit.get(
                                                                context)
                                                                .getUserData();
                                                            MainCubit.get(
                                                                context)
                                                                .updateTheOrderId(
                                                                order['orderId'],
                                                                order['userId']);
                                                            MainCubit.get(
                                                                context)
                                                                .updateOrderState(
                                                                true, MainCubit
                                                                .get(context)
                                                                .userModel
                                                                ?.userId);
                                                            MainCubit.get(
                                                                context)
                                                                .updateDeliveryId(
                                                                '${MainCubit
                                                                    .get(
                                                                    context)
                                                                    .userModel
                                                                    ?.userId}',
                                                                order['userId']
                                                            );

                                                          },
                                                          child: Text(
                                                            'Accept the order',
                                                            style: GoogleFonts
                                                                .cairo(
                                                                color: Colors
                                                                    .blue,
                                                                fontWeight: FontWeight
                                                                    .bold),
                                                          ))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 1,
                                                    color: Colors.white,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "Name:",
                                                        style: GoogleFonts
                                                            .cairo(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color: Colors.blue),
                                                      ),
                                                      const SizedBox(
                                                        width: 7,
                                                      ),
                                                      Text(
                                                        "${order['name']}",
                                                        style: GoogleFonts
                                                            .cairo(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        CupertinoIcons.phone,
                                                        color: Colors.blue,
                                                      ),
                                                      const SizedBox(
                                                        width: 7,
                                                      ),
                                                      Text(
                                                        "${order['phone']}",
                                                        style: GoogleFonts
                                                            .cairo(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Colors.blue,
                                                      ),
                                                      const SizedBox(
                                                        width: 7,
                                                      ),
                                                      Text(
                                                        "${order['address']}",
                                                        style: GoogleFonts
                                                            .cairo(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        "Description:",
                                                        style: GoogleFonts
                                                            .cairo(
                                                            fontSize: 18,
                                                            fontWeight: FontWeight
                                                                .bold,
                                                            color: Colors.blue),
                                                      ),
                                                      const SizedBox(
                                                        width: 7,
                                                      ),
                                                      Container(
                                                          width: 300,
                                                          child: Text(
                                                              "${order['description']}",
                                                              textAlign: TextAlign
                                                                  .start,
                                                              style: GoogleFonts
                                                                  .cairo(
                                                                fontSize: 18,
                                                              ))),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 0.1,
                                  ),
                                );
                              },
                            )


                        ),
                      ),

                    );
                  }
                }
            );


        }



    );
  }
}
