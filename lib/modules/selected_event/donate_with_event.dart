import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donationproject/modules/admin/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../shared/network/const.dart';
import '../donate_screen/donate_scree_money.dart';

class VisaScreen1 extends StatefulWidget {
  final nameOfEvent;
  final percetnage;
  final target;
  final price;
  VisaScreen1(this.nameOfEvent,this.percetnage,this.target,this.price);
  @override
  State<VisaScreen1> createState() => _VisaScreenState(percetnage,target,nameOfEvent,price);
}

class _VisaScreenState extends State<VisaScreen1> {
  final percetnage;
  final target;
  final nameOfEvent;
  final price;
  _VisaScreenState(this.percetnage,this.target,this.nameOfEvent,this.price);
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: WebView(
          initialUrl: ApiContest.visaUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          onProgress: (int progress) {
            print('WebView is loading (progress : $progress%)');
          },
          javascriptChannels: <JavascriptChannel>{
            _toasterJavascriptChannel(context),
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith('https://www.google.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            updateTarget(nameOfEvent, target - int.parse(price));
            return NavigationDecision.navigate;
          },

          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
  }

  void updateTarget(String nameOfEvent, dynamic value) {
    FirebaseFirestore.instance.collection('events').doc(nameOfEvent).update({'target': value})
        .then((value) {
      setState(() {


        // Update the state if necessary
      });
    })
        .catchError((error) {
      // Handle errors
    });
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {

    return JavascriptChannel(
      name: 'Toaster',
      onMessageReceived: (JavascriptMessage message) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message.message)),
        );
      },
    );
  }

  // to exit from app
  void paymentExitApp(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Are you sure completed the pay',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>    DonateScreenWithMoney(),
                ), (route) => false);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );
  }
}