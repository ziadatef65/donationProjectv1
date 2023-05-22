import 'package:donationproject/modules/admin/add_event/add_details_and_percetage.dart';
import 'package:donationproject/modules/admin/cubit/cubit.dart';
import 'package:donationproject/modules/admin/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/components.dart';

class AddImageOfEventScreen extends StatelessWidget {
  final nameOfEvent;

  AddImageOfEventScreen(this.nameOfEvent);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AdminCubit, AdminStates>(
      listener: (context, state) {
        if (state is UploadProfileImageSuccessState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPercentageAndDetailsPage(nameOfEvent,AdminCubit.get(context).profileImage)));
        }
        if(state is UploadProfileImageSuccessState )
        {
          showToast(text: 'Event image has been added successfully' , state: ToastState.SUCCESS);
        }
      },
      builder: (context, state) {
        var profileImage = AdminCubit.get(context).profileImage;
        var eventsModel = AdminCubit.get(context).eventModel;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 90, left: 20, bottom: 20, right: 20),
              child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.topLeft,
                              colors: [
                                Color.fromRGBO(92, 70, 156, 10),
                                Color.fromRGBO(12, 19, 79, 10)
                              ]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            'Add image of event',
                            style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Material(
                        elevation: 10,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        child: Container(
                          height: 450,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                if (profileImage == null)
                                  SizedBox(height: 300,),
                                  const SizedBox(height: 10,),
                                if (profileImage != null)
                                Container(
                                  height: 300,
                                  width: double.infinity,
                                  child: Image(
                                    image:  profileImage == null ? NetworkImage('${eventsModel?.imageOfEvent}'): FileImage(profileImage) as ImageProvider,),
                                ),
                                const SizedBox(height: 40,),
                                InkWell(
                                  child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              begin: Alignment.center,
                                              end: Alignment.topLeft,
                                              colors: [
                                                Color.fromRGBO(92, 70, 156, 10),
                                                Color.fromRGBO(12, 19, 79, 10)
                                              ]),
                                          borderRadius:
                                          BorderRadius.circular(
                                              10)),
                                      child:   Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Upload',
                                            style: GoogleFonts.cairo(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,

                                                fontSize: 20),
                                          ),
                                        ],
                                      )
                                  ),
                                  onTap: () {
                                    AdminCubit.get(context).getProfileImage();
                                  },
                                ),
                                const SizedBox(height: 5,),
                                if(state is UploadImageOfEventLoadingState)
                                const LinearProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  color: Color.fromRGBO(92, 70, 156, 10),
                                  minHeight:4,

                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: InkWell(
                          child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      begin: Alignment.center,
                                      end: Alignment.topLeft,
                                      colors: [
                                        Color.fromRGBO(92, 70, 156, 10),
                                        Color.fromRGBO(12, 19, 79, 10)
                                      ]),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Next',
                                    style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )),
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              AdminCubit.get(context).uploadProfileImage(nameOfEvent);
                            }
                          },
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
