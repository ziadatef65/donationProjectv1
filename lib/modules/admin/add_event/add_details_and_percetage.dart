
import 'package:donationproject/modules/admin/add_event/finish_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';

class AddPercentageAndDetailsPage extends StatelessWidget {
  final nameOfEvent;
  final imageOfEvent;
  AddPercentageAndDetailsPage(this.nameOfEvent,this.imageOfEvent);

  @override
  Widget build(BuildContext context) {
    var percentageController = TextEditingController();
    var detailsController = TextEditingController();
    var targetController = TextEditingController();
    var fixedTargetController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state){
if(state is DoneAddInfoSuccessState)
  {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>FinishScreen()), (route) => false);
  }
      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          body:SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 50,left: 20,bottom: 20,right: 20),
              child: Form(
                key: formKey,
                child: Column(

                  children: [
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 700,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 70,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(70),topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                                    gradient: LinearGradient(
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
                                          'Add more important info ',style: GoogleFonts.cairo(fontSize: 24,color: Colors.white,fontWeight: FontWeight.bold),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
                              child: Text('Add percentage of event progress:',style: GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child:  TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Percentage of event must not empty';
                                    }
                                  },
                                  controller: percentageController,
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
                                      'Add Percentage of event',
                                      style: GoogleFonts.cairo(),
                                    ),
                                    floatingLabelStyle:
                                    const TextStyle(color:  Color.fromRGBO(29, 38,125, 10),),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15,top: 2),
                              child: Text('Add Details of event:',style: GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: TextFormField(

                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Details must not empty';
                                    }
                                  },
                                  maxLines:7,
                                  controller: detailsController,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color:  Color.fromRGBO(92, 70,156, 10,)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    alignLabelWithHint: true,
                                    focusedBorder: OutlineInputBorder(

                                      borderSide:
                                      const BorderSide(color: Color.fromRGBO(29, 38,125, 10)),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    label:  Text(
                                      'Add Details of event',
                                      style: GoogleFonts.cairo(),
                                    ),
                                    floatingLabelStyle:
                                    const TextStyle(color:  Color.fromRGBO(29, 38,125, 10),),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15,top: 2),
                              child: Text('Add the target of event and fixed target in EGP:',style: GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10,left: 15,right: 15),
                              child:  Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Target of event must not empty';
                                          }
                                        },
                                        controller: targetController,
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
                                            'Add target of event',
                                            style: GoogleFonts.cairo(),
                                          ),
                                          floatingLabelStyle:
                                          const TextStyle(color:  Color.fromRGBO(29, 38,125, 10),),
                                        )),
                                  ),
                                  const SizedBox(width: 10,),
                                  Expanded(
                                    child: TextFormField(
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Fixed Target must not empty';
                                          }
                                        },
                                        controller: fixedTargetController,
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
                                            'Add Fixed target ',
                                            style: GoogleFonts.cairo(),
                                          ),
                                          floatingLabelStyle:
                                          const TextStyle(color:  Color.fromRGBO(29, 38,125, 10),),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15,),
                            if(state is AddTargetOfEventLoadingState)
                              const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 4,
                                  color: Color.fromRGBO(29, 38,125, 10),
                                ),
                              ),
                          ],
                        ) ,
                      ),
                    ),
                    const SizedBox(height: 25,),
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
                            // AdminCubit.get(context).addPercentageOfEvent(nameOfEvent, percentageController.text);
                            // AdminCubit.get(context).addDetailsOfEvent(nameOfEvent, detailsController.text);
                            // AdminCubit.get(context).addTargetOfEvent(nameOfEvent, targetController.text);
                             AdminCubit.get(context).addInformation(nameOfEvent, int.parse(percentageController.text+"00"), detailsController.text, int.parse(targetController.text+"00"),int.parse(fixedTargetController.text+"00"));

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
