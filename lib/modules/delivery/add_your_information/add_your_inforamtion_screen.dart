import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:donationproject/modules/delivery/add_your_information/add_your_inforamtion1_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddInformationScreen extends StatelessWidget {
  const AddInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, DonationStates>(
      listener: (context, state) {
        if(state is UpdateSuccessState)
          {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>AddInformationScreen1()), (route) => false);
          }
      },
      builder: (context, state) {
        var profileImage = MainCubit.get(context).profileImage;
        var cubit = MainCubit.get(context);
        var userModel = MainCubit.get(context).userModel;
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                Text(
                  'You must complete this important information to be able to continue:',
                  style: GoogleFonts.cairo(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 600,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(

                      children: [
                        if(state is UploadLoadingState)
                          const LinearProgressIndicator(),
                        const  SizedBox(height: 40,),
                        Center(
                          child: CircleAvatar(
                            radius: 90,
                            backgroundImage: profileImage == null ? NetworkImage('${userModel?.image}'):FileImage(profileImage)as ImageProvider,
                          ),
                        ),
                       const Expanded(child: SizedBox(height: 20,)),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
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
                                          color: Colors.white, fontSize: 16),
                                    )),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: CupertinoColors.systemBlue,
                                ),
                                child: TextButton(
                                    onPressed: () {
                                      cubit.uploadProfileDeliveryImage(name: userModel!.name!, phone: userModel.phone!, address: userModel.address!);
                                    },
                                    child: Text(
                                      'Update your Image',
                                      style: GoogleFonts.cairo(
                                          color: Colors.white, fontSize: 16),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        const  SizedBox(height: 20,)
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
