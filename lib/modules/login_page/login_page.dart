import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:donationproject/layout/layout.dart';
import 'package:donationproject/modules/login_page/cubit/states.dart';
import 'package:donationproject/modules/registe_page/register_delivery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../registe_page/register_page.dart';
import 'cubit/cubit.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            showToast(text: state.error, state: ToastState.ERROR);
          }
          if (state is LoginSuccessState) {
            CacheHelper.saveData(key: 'userId', value: state.userId)
                .then((value) {
              userId = state.userId;
              MainCubit.get(context).getUserData();
              MainCubit.get(context).userModel?.image;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LayoutScreen()),
                (route) => false,
              );

            });
          }
          if(state is GetUserSuccessState){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LayoutScreen()),
                  (route) => false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
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
                          top: 250,
                          left: 16.0,
                          right: 16.0,
                          bottom: 16.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Login',
                              style: GoogleFonts.cagliostro(
                                fontSize: 32.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if(state is GetUserLoadingState)
                           const SizedBox(height: 5,),
                            if(state is GetUserLoadingState)
                           const LinearProgressIndicator(color: Color.fromRGBO(29, 38, 125, 10),),
                            const SizedBox(
                              height: 16,
                            ),
                            Flexible(
                              child: TextFormField(
                                validator: (value){
                                  if(value!.isEmpty) {
                                    return  "Email must not empty";
                                  }
                                },
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
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
                                validator: (value){
                                  if(value!.isEmpty) {
                                    return  "Password must not empty";
                                  }
                                },
                                keyboardType: TextInputType.visiblePassword,
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
                                controller: passwordController,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const  Color.fromRGBO(29, 38, 125, 10))),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );

                                }
                              },
                              child: Text(
                                "Log in",
                                style: GoogleFonts.cagliostro(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account? ",
                                  style: GoogleFonts.cagliostro(
                                    color: Colors.white.withOpacity(.9),
                                    fontSize: 18,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegisterScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Register",
                                    style: GoogleFonts.cagliostro(
                                      fontSize: 16,
                                      color: const Color.fromRGBO(29, 38, 125, 10),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "join us to be part of our team",
                                  style: GoogleFonts.cagliostro(
                                    color: Colors.white.withOpacity(.9),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => RegisterDeliveryScreen()),
                                    );
                                  },
                                  child: Text(
                                    "Sign Up here",
                                    style: GoogleFonts.cagliostro(
                                      fontSize: 16,
                                      color:const Color.fromRGBO(29, 38, 125, 10),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
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
