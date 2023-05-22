// import 'package:donationproject/modules/done_screen/done_screen.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class PayScreen extends StatefulWidget {
//
//   @override
//   State<PayScreen> createState() => _PayScreenState();
// }
//
// class _PayScreenState extends State<PayScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Container(
//               height: 70,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all()
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Row(
//                   children: [
//                     Image(image: AssetImage('assets/images/paypal.png')),
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           hintText: "2121 6352 8465 ****",
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                             borderSide: BorderSide.none,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 500,),
//             Container(
//               height: 50,
//               width: double.infinity,
//               child: TextButton(onPressed: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=> DoneScreen()));
//               }, child: Text('Pay Now',style: TextStyle(fontWeight: FontWeight.bold,color: CupertinoColors.white),)),
//               color: CupertinoColors.activeBlue,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:io';

import 'package:donationproject/modules/donate_screen/donate_scree_money.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../shared/network/const.dart';

class VisaScreen extends StatefulWidget {
  const VisaScreen({Key? key}) : super(key: key);

  @override
  State<VisaScreen> createState() => _VisaScreenState();
}

class _VisaScreenState extends State<VisaScreen> {
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
            return NavigationDecision.navigate;
          },

          gestureNavigationEnabled: true,
          backgroundColor: const Color(0x00000000),
        ),
      ),
    );
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
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>         DonateScreenWithMoney(),
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