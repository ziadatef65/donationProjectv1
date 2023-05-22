import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/cubit/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../modules/donate_screen/donate_screen.dart';
import '../modules/home_screen/home_screen.dart';
import '../modules/login_page/login_page.dart';
import '../modules/profile_screen/profile_screen.dart';
import '../shared/components/constants.dart';
import '../shared/network/local/cache_helper.dart';

class LayoutScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<MainCubit, DonationStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        var userModel = MainCubit.get(context).userModel;
        return
          state is GetUserLoadingState ?
              const Scaffold(
                backgroundColor: Colors.white,
        body:Center ( child :CircularProgressIndicator())
              ): Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            leadingWidth: double.infinity,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20,top: 1),
              child: Row(
                  children: [
                // const SizedBox(
                //   width: 18,
                // ),
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${userModel?.image}'),
                ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 22,
                        ),
                        const Text('Hello,',style: TextStyle(color: Color.fromRGBO(29, 38,125, 10),fontWeight: FontWeight.bold,fontSize: 16),),
                        Text('${userModel?.name}',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),

                      ],
                    )
              ]),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
            ),
            actions: [
              TextButton(
                child: Text(
                  'Logout',
                  style: GoogleFonts.cairo(
                      color:const Color.fromRGBO(29, 38,125, 10), fontWeight: FontWeight.bold,fontSize: 16),
                ),
                onPressed: () {
                  CacheHelper.removeData(key: 'userId')?.then((value) async {
                    if (value!) {
                      await FirebaseAuth.instance.signOut();
                      userId = null;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (route) => false);
                    }
                  });
                },
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: userModel?.isDelivery == true ? cubit.screens2[cubit.currentIndex] :cubit.screens[cubit.currentIndex],
          bottomNavigationBar:
          userModel?.isDelivery ==  true ? BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            backgroundColor: CupertinoColors.white,
            selectedItemColor: const Color.fromRGBO(29, 38,125, 10),
            unselectedItemColor: Colors.black,
            selectedLabelStyle:
            const TextStyle(color: const Color.fromRGBO(29, 38,125, 10),),
            elevation: 0,
            items:  [
              const BottomNavigationBarItem(icon: Icon(Icons.delivery_dining_outlined,), label: 'Order',),
              const BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), label: 'Profile'),
              if(userModel?.superAdmin == true)
                const BottomNavigationBarItem(icon: Icon(CupertinoIcons.home,), label: 'Home',),
              if(userModel?.superAdmin == true)
                const BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart,), label: 'Donate'),
              if(userModel?.superAdmin == true)
              const BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings_outlined), label: 'Admin'),

            ],
          ):BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            backgroundColor: CupertinoColors.white,
            selectedItemColor:const Color.fromRGBO(29, 38,125, 10),
            unselectedItemColor: Colors.black,
            selectedLabelStyle:
            const TextStyle(color: const Color.fromRGBO(29, 38,125, 10),),
            elevation: 0,
            items: const [

              BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.heart,
                  ),
                  label: 'Donate'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled), label: 'Profile'),

            ],
          ),
        ) ;
      },
    );
  }
}
