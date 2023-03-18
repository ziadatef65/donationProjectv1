import 'package:donationproject/layout/cubit/cubit.dart';
import 'package:donationproject/layout/layout.dart';
import 'package:donationproject/modules/delivery/add_your_information/add_your_inforamtion_screen.dart';
import 'package:donationproject/modules/login_page/login_page.dart';
import 'package:donationproject/modules/profile_screen/profile_screen.dart';
import 'package:donationproject/modules/splash_screen/splash_screen.dart';
import 'package:donationproject/shared/block_observer.dart';
import 'package:donationproject/shared/components/constants.dart';
import 'package:donationproject/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  userId = CacheHelper.getData(key: 'userId');
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  if (onBoarding != null) {
    if(userId != null)
    {
      widget = LayoutScreen();
    }
    else
    {
      widget =LoginScreen();
    }
  } else {
    widget = SplashPage();
  }

    runApp(MyApp(
      startWidget: widget,
    ));
}


class MyApp extends StatelessWidget {
  final Widget? startWidget;

  MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=> MainCubit()..getUserData()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          home:startWidget,
          // startWidget,
      ),
    );
  }
}