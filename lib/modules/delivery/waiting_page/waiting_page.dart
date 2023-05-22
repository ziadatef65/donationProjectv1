import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/user_model.dart';

class WaitingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, DonationStates>(
        listener: (context, state) {},
        builder: (context, state) {
              var userModel = MainCubit
                  .get(context)
                  .userModel;
              return StreamBuilder<UserModel>(
                  stream: MainCubit
                      .get(context)
                      .userModelStream,
                  builder: (context, AsyncSnapshot<UserModel> snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data?.orderNow == true) {
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
                                                                    size: 250,
                                                                    color: CupertinoColors
                                                                        .systemBlue,
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
                                                                    color: CupertinoColors
                                                                        .systemBlue),),
                                                    ]),
                                          ),
                                    );
                        } else {
                              return Container(
                                    color: Colors.white,
                                    child: Center(
                                          child: Text('No order acceptable yet',style: GoogleFonts.cairo(
                                                fontWeight: FontWeight.bold,fontSize: 24
                                          ),),
                                    ),
                              );
                        }
                  }
              );
        }
    );
  }
}