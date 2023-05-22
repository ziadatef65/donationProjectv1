import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/network/local/cache_helper.dart';
import '../login_page/login_page.dart';


class BoardingModel {
  final String image;
  final String text;

  BoardingModel(this.image, this.text);
}

List<BoardingModel> boarding = [
  BoardingModel('assets/images/onBording1.png',
      'The application provides the advantage of donating food by filling in some data through which we can communicate with you.'
        ),
  BoardingModel( 'assets/images/onBoarding2.png',
      'The application also provides another way to donate money, and the application has been linked to a payment platform in order to facilitate the donation process.'),
  BoardingModel('assets/images/onBoarding.png',
  "You can also donate by being the person who helps us receive donations from donors, and for your information, we have a strong system that guarantees the donor safety and guarantees that someone will receive his request."),
  ];

var boardController = PageController(); // this variable to control the smooth page indicator
bool isLast = false;

void submit(BuildContext context,dynamic done1) {
  CacheHelper.saveData(key: 'onBoarding', value: true).then((dynamic value) {
    if (value = true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));

    }
  });
}

class SplashScreen2 extends StatefulWidget {
  @override
  State<SplashScreen2> createState() => _OnBoardingScreen2State();
}

class _OnBoardingScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context,) {
    return Scaffold(


      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              begin: Alignment.center,
              end: Alignment.topLeft,
              colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40, bottom: 40),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  controller: boardController,
                  itemBuilder: (context, index) =>
                      buildBoardingItem(context, boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardController,
                    count: boarding.length,
                    effect: ExpandingDotsEffect(
                      dotWidth: 15,
                      dotHeight: 15,
                      spacing: 10,
                      expansionFactor: 4,
                      activeDotColor: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 109,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 13,
                        ),
                        Text(
                          'Next',
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            color: Colors.amber,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (isLast) {
                              submit(context,true);
                            } else {
                              boardController.nextPage(
                                  duration: Duration(
                                    milliseconds: 750,
                                  ),
                                  curve: Curves.bounceOut);
                            }
                          },
                          icon: const Icon(Icons.send_rounded),
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

/*
the following method used for to make items of onBoarding
screen by make class model, and give it 2 variable image and text,
and make a list of type of Boarding Model
 */
  Widget buildBoardingItem(context, BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Image(
          image: AssetImage('${model.image}'),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Text(
        '${model.text}',
        style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
      ),
    ],
  );
}
