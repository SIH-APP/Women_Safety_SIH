// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class CrimeMapPage extends StatefulWidget {
//   @override
//   _CrimeMapPageState createState() => _CrimeMapPageState();
// }
//
// class _CrimeMapPageState extends State<CrimeMapPage> {
//   late WebViewController _controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Crime Map'),
//       ),
//       body: FutureBuilder<String>(
//         future: loadHtmlFromAssets('assets/greater_noida_crime_map.html'),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return WebView(
//               initialUrl: Uri.dataFromString(snapshot.data!, mimeType: 'text/html').toString(),
//               javascriptMode: JavascriptMode.unrestricted,
//               onWebViewCreated: (WebViewController webViewController) {
//                 _controller = webViewController;
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error loading HTML'));
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
//
//   Future<String> loadHtmlFromAssets(String filename) async {
//     return await rootBundle.loadString(filename);
//   }
// }