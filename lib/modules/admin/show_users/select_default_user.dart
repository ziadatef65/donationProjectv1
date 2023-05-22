import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedDefaultUser extends StatelessWidget {
  final name;
  final image;
  final email;
  final phone;
  final address;
  final userId;
  SelectedDefaultUser(this.name,this.image,this.email,this.phone,this.address,this.userId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            Center(child: CircleAvatar(
              radius:80,
              backgroundImage: NetworkImage('${image}'),
            ),),
            const SizedBox(height: 40,),
            Container(
              height: 70,
              width: 230,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.topLeft,
                    colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                ),
              ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Name:',style: GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                const SizedBox(width: 5,),
                Text(name,style: GoogleFonts.cairo(fontSize: 20,color: Colors.white)),
              ],),
            ),
            ),
            const SizedBox(height: 40,),
            Container(
              height: 70,
              width: 290,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.topLeft,
                    colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                ),
              ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Email:',style: GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                const SizedBox(width: 5,),
                Expanded(child: Text(email,style: GoogleFonts.cairo(fontSize: 20,color: Colors.white))),
              ],),
            ),
            ),
            const SizedBox(height: 40,),
            Container(
              height: 70,
              width: 320,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.topLeft,
                    colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                ),
              ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Phone:',style: GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                const SizedBox(width: 5,),
                Text(phone,style: GoogleFonts.cairo(fontSize: 20,color: Colors.white)),
              ],),
            ),
            ),
            const SizedBox(height: 40,),
            Container(
              height: 70,
              width: 350,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.topLeft,
                    colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                ),
              ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('Address:',style: GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                const SizedBox(width: 5,),
                Expanded(child: Tooltip(message: address,child: Text(address,style: GoogleFonts.cairo(fontSize: 20,color: Colors.white,),maxLines: 1,overflow: TextOverflow.ellipsis,))),
              ],),
            ),
            ),
            const SizedBox(height: 40,),
            Container(
              height: 70,
              width: 380,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),bottomRight: Radius.circular(15)),
                gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.topLeft,
                    colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                ),
              ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Text('User id:',style: GoogleFonts.cairo(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                const SizedBox(width: 5,),
                Expanded(child: Tooltip(message: userId,child: Text(userId,style: GoogleFonts.cairo(fontSize: 20,color: Colors.white,),maxLines: 1,overflow: TextOverflow.ellipsis,))),
              ],),
            ),
            ),
            SizedBox(height: 40,),
            Row(
              children: [
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: Center(
                    child: IconButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection('users').doc(userId).delete();
                        },
                      icon: Icon(CupertinoIcons.delete,color: Colors.white,),
                    ),
                  ),
                  radius: 25,
                ),
                SizedBox(width: 20,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
