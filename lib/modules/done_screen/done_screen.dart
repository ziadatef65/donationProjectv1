import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DoneScreen extends StatelessWidget {
  const DoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.white,
      appBar: AppBar(
        backgroundColor: CupertinoColors.white,
        iconTheme: IconThemeData(color: CupertinoColors.black
        ),
       elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child:Image(image: AssetImage('assets/images/done.png'),),),
          SizedBox(height: 10,),
          Text('         Thank You! \nDonation Completed',style: TextStyle(fontWeight: FontWeight.bold,fontSize:30),)

        ],
      ),
    );
  }
}
