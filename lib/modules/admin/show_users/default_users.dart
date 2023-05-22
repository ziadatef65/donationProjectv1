import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationproject/modules/admin/show_users/select_default_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultUsersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 210,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                color: Color.fromRGBO(12, 19,79, 10),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text('Welcome Admin',style: GoogleFonts.heebo(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),),
                      const SizedBox(height: 10,),
                      Text('On this page, information about users will be displayed',style: GoogleFonts.heebo(fontSize: 24,fontWeight: FontWeight.bold,color: Colors.white),textAlign: TextAlign.center,)
                    ],
                  ),
                ),
              ),
            ),
        const SizedBox(height: 10,),
        StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('isDelivery', isEqualTo: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading...');
          }
          if (snapshot.hasData)
          {
            // Process the snapshot data here
            final users = snapshot.data!.docs.map((doc) => doc.data()! as Map<String, dynamic>).toList();
            return Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: users.length,
                itemBuilder: (BuildContext context, int index) {
                  // Build your UI using the user data
                  final user = users[index];
                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                    children: [
                      Material(
                        elevation:10,
                        borderRadius: BorderRadius.circular(6),
                        child: Container(
                          height:100,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                           gradient: LinearGradient(
                                begin: Alignment.center,
                                end: Alignment.topLeft,
                                colors: [Color.fromRGBO(92, 70,156, 10),Color.fromRGBO(12, 19,79, 10)]
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage:NetworkImage('${user['image']}'),
                                ),
                                SizedBox(width: 20,),

                                Text('${user['name']}',style: GoogleFonts.cairo(fontWeight: FontWeight.bold,fontSize: 24,color:Colors.white),),
                                Spacer(),
                                Tooltip(
                                    message: "More Information",
                                    child: IconButton(
                                        onPressed: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>SelectedDefaultUser(user['name'],user['image'],user['email'],user['phone'],user['address'],user['userId'])));
                                        },
                                        icon: Icon(Icons.navigate_next_outlined,color: Colors.white,size: 35,)))
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                    ),
                  );

                },
              ),
            );
          }


          return const Text('No users found.');
        },
    ),
          ],
        ),
      ),
    );
  }
}
