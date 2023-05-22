import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,DonationStates>(
      listener: (context,state){},
      builder: (context,state){
        var userModel = MainCubit.get(context).userModel;
        var profileImage = MainCubit.get(context).profileImage;
        var cubit = MainCubit.get(context);
        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        addressController.text = userModel.address!;

        return  Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if(state is UserUpdateLoading )
                    SizedBox(height: 10,),
                    if(state is UserUpdateLoading  )
                    const LinearProgressIndicator(color: const Color.fromRGBO(29, 38,125, 10),),
                    if(state is UserUpdateLoading )
                   const SizedBox(height: 10,),

                    Center(
                      child:
                      Stack(
                    children: [
                       CircleAvatar(
                        radius: 73,
                        backgroundColor: const Color.fromRGBO(29, 38,125, 10),
                        child: CircleAvatar(

                          radius: 70,
                          backgroundImage: profileImage == null
                              ? NetworkImage(
                              '${userModel.image}')
                              : FileImage(profileImage)
                          as ImageProvider,

                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cubit.getProfileImage();
                        },
                        icon: const CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color.fromRGBO(29, 38,125, 10),
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor:
                            Colors.white,
                            child: Icon(
                             CupertinoIcons.camera,
                              size: 16,
                              color:const Color.fromRGBO(29, 38,125, 10),
                            ),
                          ),
                        ),
                      ),
                  ],
                )

                    ),
                    const SizedBox(height: 30,),
                    TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Name must not empty';
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
                            const BorderSide(color: CupertinoColors.systemBlue),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: const Text(
                            'Name',
                          ),
                          floatingLabelStyle:
                          const TextStyle(color:  const Color.fromRGBO(29, 38,125, 10),),
                        )),
                   const SizedBox(height: 30,),
                    TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Phone must not empty';
                          }
                        },
                        controller: phoneController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color:  Color.fromRGBO(92, 70,156, 10,)),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(color: CupertinoColors.systemBlue),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: const Text(
                            'Phone',
                          ),
                          floatingLabelStyle:
                          const TextStyle(color:  const Color.fromRGBO(29, 38,125, 10),),
                        )),
                    const SizedBox(height: 30,),
                    TextFormField(

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Address must not empty';
                          }
                        },
                        controller: addressController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color:  Color.fromRGBO(92, 70,156, 10,)),
                            borderRadius: BorderRadius.circular(20),
                          ),

                          focusedBorder: OutlineInputBorder(

                            borderSide:
                            const BorderSide(color: CupertinoColors.systemBlue),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          label: const Text(
                            'Address',
                          ),
                          floatingLabelStyle:
                          const TextStyle(color:  const Color.fromRGBO(29, 38,125, 10),),
                        )),
                    SizedBox(height: 60,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:const Color.fromRGBO(29, 38,125, 10),
                            ),
                            child: TextButton(
                                onPressed: () {
                                  if (formKey.currentState!
                                      .validate()) {
                                    cubit.updateUser(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      address: addressController.text,
                                    );
                                  }
                                },
                                child: Text(
                                  'Update Info',
                                  style: GoogleFonts.cairo(
                                      color: Colors.white,
                                      fontSize: 20),
                                )),
                          ),
                        ),
                        if (cubit.profileImage != null)
                          const SizedBox(
                            width: 20,
                          ),
                        if (cubit.profileImage != null)
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10),
                                color: const Color.fromRGBO(29, 38,125, 10),
                              ),
                              child: TextButton(
                                  onPressed: () {
                                    if (formKey.currentState!
                                        .validate()) {
                                      cubit.uploadProfileImage(
name: nameController.text,
                                        phone: phoneController.text,
                                        address: addressController.text,
                                      );
                                    }
                                  },
                                  child: Text(
                                    'Update Image',
                                    style: GoogleFonts.cairo(
                                        color: Colors.white,
                                        fontSize: 20),
                                  )),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
