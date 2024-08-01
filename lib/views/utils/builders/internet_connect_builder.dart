// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
// class  InternetConnectBuilder extends StatelessWidget {
//   Widget child;
//
//   InternetConnectBuilder({super.key, required this.child});
//
//   var controller = StreamController<int>();
//
//   @override
//   Widget build(BuildContext context) {
//     _checkContinue();
//     return StreamBuilder(
//         initialData: 0,
//         stream: controller.stream,
//         builder: (c, snap) {
//           return _connectionBuilder();
//         });
//   }
//
//   _connectionBuilder() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     if (connectivityResult == ConnectivityResult.mobile ||
//         connectivityResult == ConnectivityResult.wifi) {
//       return child;
//     } else {
//       return Scaffold(
//           body: Column(
//         children: [
//           const Text("data"),
//           ElevatedButton(
//               onPressed: () {
//                 _connectionBuilder();
//               },
//               child: const Text("Connect Again"))
//         ],
//       ));
//     }
//   }
//
//   _checkContinue() {
//     var count = 0;
//     Timer.periodic(const Duration(seconds: 5), (timer) {
//       count = count + 1;
//       controller.sink.add(count);
//     });
//   }
// }
