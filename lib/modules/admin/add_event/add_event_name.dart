import 'package:donationproject/modules/admin/add_event/add_event_image.dart';
import 'package:donationproject/modules/admin/cubit/cubit.dart';
import 'package:donationproject/modules/admin/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../shared/components/components.dart';


class AddEventName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state){
        if (state is CreateEventSuccessState)
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddImageOfEventScreen(nameController.text)));
        }
        if(state is CreateEventSuccessState )
        {
          showToast(text: 'Event name has been added successfully' , state: ToastState.SUCCESS);
        }
      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 130,left: 20,bottom: 20,right: 20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 400,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child:Column(
                          children: [
                            Stack(
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
                                          'Add the event name',style: GoogleFonts.cairo(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 100,),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child:  TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Name of event must not empty';
                                    }
                                  },
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:  Color.fromRGBO(92, 70,156, 10,)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                      const BorderSide(color: Color.fromRGBO(29, 38,125, 10)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    label:  Text(
                                      'Add name of event',
                                      style: GoogleFonts.cairo(),
                                    ),
                                    floatingLabelStyle:
                                    const TextStyle(color:  Color.fromRGBO(29, 38,125, 10),),
                                  )),
                            ),
                            SizedBox(height: 50,),
                            if(state is CreateEventLoadingState)
                            CircularProgressIndicator(
                              strokeWidth: 4,
                              color: Color.fromRGBO(29, 38,125, 10),
                            ),
                          ],
                        ) ,
                      ),
                    ),
                    SizedBox(height: 40,),
                    Center(
                      child: InkWell(
                        child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                    begin: Alignment.center,
                                    end: Alignment.topLeft,
                                    colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                                ),

                                borderRadius:
                                BorderRadius.circular(
                                    10)),
                            child:   Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
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
                            )
                        ),
                        onTap: () {
                          if(formKey.currentState!.validate())
                          {
                            AdminCubit.get(context).eventCreate(nameOfEvent: nameController.text);

                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ) ,
        );
      },

    );
  }
}
