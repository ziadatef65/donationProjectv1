import 'package:donationproject/layout/layout.dart';
import 'package:donationproject/modules/donate_screen/donate_screen.dart';
import 'package:donationproject/modules/profile_screen/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: [
                  Center(
                    child: Image(
                      image: AssetImage('assets/images/home1.png'),
                    fit:BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: Text('Do you really want  \nto donate?',style: TextStyle(color:CupertinoColors.label,fontWeight: FontWeight.bold,fontSize:18),),
                  ),
                  Positioned(
                    top: 100,
                    left: 30,
                    child: Container(
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeBlue
                      ),
                      height:40,
                      width: 100,
                      child: TextButton(
                        onPressed: () {
                          // setState(() {
                          //   Navigator.of(context).push(
                          //     MaterialPageRoute(builder: (context) => DonateScreen()),
                          //   ).then((value) {
                          //     setState(() {
                          //       currentIndex = 1;
                          //     });
                          //   });
                          // });
                        },
                        child: Text('Start Donate ',style: TextStyle(color:CupertinoColors.white ),),

                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(9)
                ),
                child: Row(children: [
                  IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.search)),
                  Text('Search here',style: TextStyle(color: Colors.grey),)
                ],),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                Text(
                  'Featured Goals',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                ),
              ],
              ),
              Container(
            height: 350,
            // set the height of the container
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homePhotos.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 290, // set the width of each container
                  margin: EdgeInsets.all(8.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('${homePhotos[index]}'),
                      SizedBox(height: 16.0),
                      Text(
                        '${titlesPhotos[index]}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),


                      SizedBox(height: 16.0),
                      TextButton(
                        onPressed: () {
                          // replace with the action you want to perform
                        },
                        child: Container(
                          height:30 ,
                          width: 90,
                          color: CupertinoColors.systemBlue,
                          child: Center(
                            child: Text(
                              'Donate ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                color: CupertinoColors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

            ],
          ),
        ),
      ),

    );
  }
}
List<String> homePhotos =[
  'assets/images/home2.png',
  'assets/images/home2.png',
];
List<String> titlesPhotos =[
  'Donate for the survival of kids ',
  'Donate for the survivial of kids ',
];

