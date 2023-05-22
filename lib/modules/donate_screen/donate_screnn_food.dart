import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:donationproject/layout/layout.dart';
import 'package:donationproject/modules/done_screen/done_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/user_model.dart';

class DonateWithFood extends StatelessWidget {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var descriptionController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,DonationStates>(
      listener: (context,state){
        if(state is CreateOrderSuccessState)
        {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const DoneScreen()), (route) => false);
        }
      },
      builder: (context,state) {
        var cubit = MainCubit.get(context);
        return StreamBuilder<UserModel>(
            stream: MainCubit
                .get(context)
                .userModelStream,
            builder: (context, AsyncSnapshot<UserModel> snapshot) {
              if (snapshot.hasData && snapshot.data?.orderNow == true) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50,),
                        const Center(child: Image(image: AssetImage('assets/images/done.png'))),
                        const SizedBox(height: 20,),
                        Text('Your request from a donor has been accepted and will be in front of you very soon. Please click on the button at the bottom of the page if your donation has been received.\n But if you have any complaints about anything, you can call the following number \n " +201111111111 "',textAlign: TextAlign.center,style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 16,color: Color.fromRGBO(29, 38, 125, 10),),),
                        Text('The Delivery Id is ${snapshot.data?.deliveryId}',textAlign: TextAlign.center,style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.red),),
                        const SizedBox(height: 150,),
                        Container(
                          decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(6),
                            color: Color.fromRGBO(29, 38, 125, 10),
                          ),
                          child: TextButton(
                            onPressed: (){
                              MainCubit.get(context).updateDeliveryId(null, snapshot.data?.userId);
                              MainCubit.get(context).updateOrderState(false, snapshot.data?.userId);
                              MainCubit.get(context).updateOrderState(false, snapshot.data?.deliveryId);
                              MainCubit.get(context).updateTheOrderId(null, snapshot.data?.userId);
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> LayoutScreen()), (route) => false);
                              MainCubit.get(context).updateNumberOfDonationOfFood((MainCubit.get(context).userModel?.numberOfDonationFood), MainCubit.get(context).userModel!.userId);
                              MainCubit.get(context).getUserData();
                              MainCubit.get(context).deleteDocsByFieldValue( snapshot.data?.orderId);
                            },
                            child: Center(child: Text('successfully done',style: GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),)),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              }else{
                return Scaffold(
                  backgroundColor: Colors.white,
                  body:  Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      physics:BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25,right: 25,bottom: 25,top: 40),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Container(
                            height: 800,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Please Enter important info:',style: GoogleFonts.cairo(fontSize: 24,fontWeight: FontWeight.bold,color: const Color.fromRGBO(29, 38, 125, 10)),),
                               if(state is CreateOrderLoadingState)
                                const LinearProgressIndicator(color: Color.fromRGBO(29, 38, 125, 10),),
                                const SizedBox(height: 10,),
                                TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Name must not empty';
                                      }
                                    },

                                    controller: nameController,
                                    decoration:const  InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color:  Color.fromRGBO(92, 70,156, 10,)
                                        ),

                                      ),
                                      errorBorder:OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: CupertinoColors.systemBlue),

                                      ) ,
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: CupertinoColors.systemBlue),

                                      ),
                                      label: Text(
                                        'Name',
                                      ),
                                      floatingLabelStyle:
                                      TextStyle(color:  CupertinoColors.systemBlue),
                                    )),
                                const SizedBox(height: 25,),
                                TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Address must not empty';
                                      }
                                    },
                                    controller: addressController,
                                    decoration:const  InputDecoration(
                                      errorBorder:OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: CupertinoColors.systemBlue),

                                      ) ,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color:  Color.fromRGBO(92, 70,156, 10,)
                                        ),

                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: CupertinoColors.systemBlue),

                                      ),
                                      label: Text(
                                        'Address',
                                      ),
                                      floatingLabelStyle:
                                      TextStyle(color:  CupertinoColors.systemBlue),
                                    )),
                                const SizedBox(height: 25,),
                                TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Phone must not empty';
                                      }
                                    },
                                    controller: phoneController,
                                    decoration:const  InputDecoration(
                                      errorBorder:OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: CupertinoColors.systemBlue),

                                      ) ,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                            color:  Color.fromRGBO(92, 70,156, 10,)
                                        ),

                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: CupertinoColors.systemBlue),

                                      ),
                                      label: Text(
                                        'Phone',
                                      ),
                                      floatingLabelStyle:
                                      TextStyle(color:  CupertinoColors.systemBlue),
                                    )),
                                const SizedBox(height: 25,),
                                TextFormField(

                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Description must not empty';
                                      }
                                    },
                                    maxLines:12,

                                    controller: descriptionController,
                                    decoration:const  InputDecoration(
                                      errorBorder:OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: CupertinoColors.systemBlue),

                                      ) ,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 2,
                                            color:  Color.fromRGBO(92, 70,156, 10,)
                                        ),

                                      ),

                                      focusedBorder: OutlineInputBorder(

                                        borderSide:
                                        BorderSide(  width: 2,
                                            color:  Color.fromRGBO(92, 70,156, 10,)),

                                      ),
                                      hintText: 'Describe what you will donate..',
                                      alignLabelWithHint: true,
                                      label: Text(
                                        'Description...',
                                      ),
                                      floatingLabelStyle:
                                      TextStyle(color:  CupertinoColors.systemBlue),
                                    )),
                                const SizedBox(height: 30,),

                                InkWell(
                                  onTap: (){
                                    if(formKey!.currentState!.validate())
                                    {
                                      cubit.createOrder(phone: phoneController.text, name: nameController.text, address: addressController.text, description: descriptionController.text);

                                    }
                                  },
                                  child: Container(
                                    height: 60,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: const Color.fromRGBO(29, 38, 125, 10),

                                        borderRadius: BorderRadius.circular(15)
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Donate Now',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }
            });
      }
    );
  }





}
