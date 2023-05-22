import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/modules/admin/cubit/cubit.dart';
import 'package:donationproject/modules/pay_screen/cubit/cubit.dart';
import 'package:donationproject/modules/pay_screen/cubit/states.dart';
import 'package:donationproject/modules/selected_event/donate_with_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SelectedEventPage extends StatelessWidget {
final image;
final nameOfEvent;
final percetnage;
dynamic target;
SelectedEventPage(this.image,this.nameOfEvent,this.percetnage,this.target);

  @override
  Widget build(BuildContext context) {
    TextEditingController priceController = TextEditingController();
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocConsumer<PaymentCubit,PaymentStates>(
      listener: (context,state){
        if(state is PaymentRequestSuccessState){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>VisaScreen1(nameOfEvent,percetnage,target,priceController.text),), (route) => false);

        }

      },
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.only(top: 50,left: 20,right: 20,bottom: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: formKey,
                  child: Column(
                      children: [
                        Row(
                          children: [
                            Material(
                              elevation: 10,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: 200,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(image: NetworkImage(image),fit: BoxFit.cover)
                                ),
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Positioned(
                                      left: 100,
                                      top: 80,
                                      child: Material(
                                        elevation: 10,
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          width: 150,
                                          height: 170,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            gradient: const LinearGradient(
                                                begin: Alignment.center,
                                                end: Alignment.topLeft,
                                                colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                                            ),

                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Text('$nameOfEvent',style: GoogleFonts.heebo(fontWeight: FontWeight.bold,fontSize: 24,color: Colors.white),),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ) ,
                              ),
                            ),
                            const Spacer(),
                            CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color.fromRGBO(92, 70,156, 10),
                                child: IconButton(onPressed: (){
                                  if(formKey.currentState!.validate())
                                      {
                                        PaymentCubit.get(context).getOrder( price: priceController.text,firstName: firstNameController.text,lastName: lastNameController.text,phone: phoneController.text, email: emailController.text);
                                        // PaymentCubit.get(context).updateTarget(nameOfEvent, target - int.parse(priceController.text));
                                      }
                                }, icon: const Icon(Icons.navigate_next_sharp,size: 30,color: Colors.white,)),
                              ),



                            const SizedBox(width: 10,),


                          ]
                        ),

                        const SizedBox(height: 80,),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(validator: (value) {
                                if (value!.isEmpty) {
                                  return 'First name must not be empty';
                                }

                              },
                                controller: firstNameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: const TextStyle(fontSize: 14),
                                  hintText: "Enter your first name",

                                  border: OutlineInputBorder(

                                    borderRadius: BorderRadius.circular(8.0),

                                    borderSide: const BorderSide(width: 1),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Last name must not be empty';
                                  }

                                },
                                controller: lastNameController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintStyle: const TextStyle(fontSize: 14),
                                  hintText: "Enter your last name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: const BorderSide(width: 1),

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30,),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email must not be empty';
                            }

                          },
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: const TextStyle(fontSize: 14),
                            hintText: "Enter your email ",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(width: 1),

                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Phone must not be empty';
                            }

                          },
                          controller: phoneController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintStyle: const TextStyle(fontSize: 14),
                            hintText: "Enter your phone ",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(width: 1),

                            ),
                          ),
                        ),
                        const SizedBox(height: 30,),
                        Expanded(
                          child: TextFormField(
                            validator: (dynamic value) {
                              if (value!.isEmpty) {
                                return 'Price must not be empty';
                              }

                              int? enteredValue = int.tryParse(value);
                              int? targetValue = int.tryParse(target.toString());

                              if (enteredValue != null && targetValue != null && enteredValue > targetValue) {
                                return 'The remaining money in this event is $target';
                              }

                            },
                            controller: priceController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Enter your price",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(width: 1),

                              ),
                            ),
                          ),
                        ),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     color: CupertinoColors.activeBlue,
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   height: 50,
                        //   width: double.infinity,
                        //
                        //   child: TextButton(onPressed: (){
                        //     if(formKey.currentState!.validate())
                        //     {
                        //       PaymentCubit.get(context).getOrder( price: priceController.text+"00",firstName: firstNameController.text,lastName: lastNameController.text,phone: phoneController.text, email: emailController.text);
                        //     }
                        //
                        //   }, child: const Text('Donate Now',style: TextStyle(fontWeight: FontWeight.bold,color: CupertinoColors.white),)),
                        // )

                      ],
                    ),
                ),
              ),
            ),

          ),
        );
      },

    );
  }
}
