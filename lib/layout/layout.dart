import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/cubit/states.dart';
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
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, DonationStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = MainCubit.get(context);
        var userModel = MainCubit.get(context).userModel;
        return Scaffold(
          appBar: AppBar(
            leadingWidth: double.infinity,

            leading: Padding(
              padding: const EdgeInsets.only(left: 25,top: 10),
              child: Row(
                  children: [
                const SizedBox(
                  width: 18,
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${userModel?.image}'),
                ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 4,
                        ),
                        Text('Hello,',style: TextStyle(color: CupertinoColors.systemBlue),),
                        Text('${userModel?.name}',
                            style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
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
                      color: CupertinoColors.systemBlue, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  CacheHelper.removeData(key: 'userId')?.then((value) {
                    if (value!) {
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
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            backgroundColor: CupertinoColors.white,
            selectedItemColor: CupertinoColors.systemBlue,
            unselectedItemColor: Colors.black,
            selectedLabelStyle:
                const TextStyle(color: CupertinoColors.systemBlue),
            elevation: 0,
            items: [
              if (userModel!.isAdmin == false)
              const BottomNavigationBarItem(
                icon: Icon(
                  CupertinoIcons.home,
                ),
                label: 'Home',
              ),
              if (userModel!.isAdmin == false)
              const BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.heart,
                  ),
                  label: 'Donate'),

              const BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.profile_circled), label: 'Profile'),
              if (userModel!.isAdmin == true)
                const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.list_bullet), label: 'Order'),
            ],
          ),
        );
      },
    );
  }
}
