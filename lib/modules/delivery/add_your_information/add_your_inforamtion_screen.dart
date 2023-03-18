import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddInformationScreen extends StatelessWidget {
  const AddInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, DonationStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        var userModel = MainCubit.get(context).userModel;
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text(
                  'You must complete this important information to be able to continue:',
                  style: GoogleFonts.cairo(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 550,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage('${cubit.profileImage}'),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          width: double.infinity,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: CupertinoColors.systemBlue,
                          ),
                          child: TextButton(
                              onPressed: () {
                                cubit.getProfileImage();
                              },
                              child: Text(
                                'Upload your Image',
                                style: GoogleFonts.cairo(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ),
                        SizedBox(height: 40,),
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image(image: NetworkImage('${cubit.nationalId}'),),

                        ),
                        SizedBox(height: 15,),
                        Container(
                          width: double.infinity,
                          height: 50,

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: CupertinoColors.systemBlue,
                          ),
                          child: TextButton(
                              onPressed: () {
                                cubit.getNationalId();
                              },
                              child: Text(
                                'Upload your national id',
                                style: GoogleFonts.cairo(
                                    color: Colors.white, fontSize: 20),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
