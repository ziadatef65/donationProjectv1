import 'package:donationproject/modules/pay_screen/cubit/cubit.dart';
import 'package:donationproject/modules/pay_screen/cubit/states.dart';
import 'package:donationproject/modules/selected_event/donate_with_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../pay_screen/pay_screen.dart';

class DonateScreenWithMoney extends StatelessWidget {

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
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>VisaScreen()), (route) => false);
        }
      },
      builder: (context,state){
        return  Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 60,),
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
                            fillColor: Colors.grey.shade400,
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: "Enter your first name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20,),
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
                            fillColor: Colors.grey.shade400,
                            hintStyle: TextStyle(fontSize: 14),
                            hintText: "Enter your last name",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
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
                      fillColor: Colors.grey.shade400,
                      hintStyle: TextStyle(fontSize: 14),
                      hintText: "Enter your email ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
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
                      fillColor: Colors.grey.shade400,
                      hintStyle: TextStyle(fontSize: 14),
                      hintText: "Enter your phone ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Price must not be empty';
                        }

                      },
                      controller: priceController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey.shade400,
                        hintText: "Enter your price",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 50,
                    width: double.infinity,

                    child: TextButton(onPressed: (){
                      if(formKey.currentState!.validate())
                        {
                          PaymentCubit.get(context).getOrder( price: priceController.text+"00",firstName: firstNameController.text,lastName: lastNameController.text,phone: phoneController.text, email: emailController.text);
                        }

                    }, child: const Text('Donate Now',style: TextStyle(fontWeight: FontWeight.bold,color: CupertinoColors.white),)),
                  )
                ],

              ),
            ),
          ),
        );
      },

    );
  }
}
