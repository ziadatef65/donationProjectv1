import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/layout.dart';
import 'package:donationproject/modules/delivery/add_your_information/add_your_inforamtion_screen.dart';
import 'package:donationproject/modules/registe_page/cubit/states.dart';
import 'package:donationproject/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';

class RegisterDeliveryScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var nameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if(state is RegisterErrorState)
          {
            showToast(text: '${state.error}', state: ToastState.ERROR);
          }
          if (state is CreateUserSuccessState) {
            showToast(text: 'Register Successfully', state: ToastState.SUCCESS);

            CacheHelper.saveData(key: 'userId', value: state.uId).then((value) {
              userId = state.uId;
              MainCubit.get(context).getUserData();
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AddInformationScreen()),
                    (route) => false);
          }
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/splashScreen.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 160,
                          left: 16.0,
                          right: 16.0,
                          bottom: 23,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Register',
                              style: GoogleFonts.cagliostro(
                                fontSize: 32.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Flexible(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Name must not be empty';
                                  }

                                },
                                controller:nameController ,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.5),
                                  prefixIcon: const Icon(Icons.person),
                                  hintText: "Name",
                                  hintStyle: GoogleFonts.cagliostro(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Flexible(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Email must not be empty';
                                  }

                                },
                                controller: emailController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.5),
                                  prefixIcon: const Icon(Icons.email),
                                  hintText: "Email",
                                  hintStyle: GoogleFonts.cagliostro(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Flexible(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password must not be empty';
                                  }

                                },
                                controller: passwordController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.5),
                                  prefixIcon: const Icon(Icons.lock),
                                  hintText: "Password",
                                  hintStyle: GoogleFonts.cagliostro(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                obscureText: true,
                              ),
                            ),
                            const  SizedBox(
                              height: 30,
                            ),
                            Flexible(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Address must not be empty';
                                  }

                                },
                                controller: addressController,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.5),
                                  prefixIcon: const Icon(Icons.location_on),
                                  hintText: "Address",
                                  hintStyle: GoogleFonts.cagliostro(),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Flexible(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Phone must not be empty';
                                  }

                                },
                                controller: phoneController,
                                decoration: InputDecoration(
                                  filled: true,
                                  hintStyle: GoogleFonts.cagliostro(),
                                  fillColor: Colors.white.withOpacity(0.5),
                                  prefixIcon: const Icon(CupertinoIcons.phone_fill),
                                  hintText: "Phone",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                            const  SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if(formKey.currentState!.validate())
                                {
                                  RegisterCubit.get(context).userDeliveryRegister(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    address: addressController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              child: Text("Register",style:  GoogleFonts.cagliostro(fontWeight: FontWeight.bold,fontSize: 18),),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}