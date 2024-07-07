// class Snackbar {

// static void showSnackbar({required BuildContext context, required String message}) {
//   final snackBar = SnackBar(
//     content: Text(message),
//     action: SnackBarAction(
//       label: 'OK',
//       onPressed: () {
//         Navigator.of(context).pop();
//         // Perform some action when the user presses the action button
//       },
//     ),
//   );

//   // Find the Scaffold in the widget tree and use it to show a SnackBar
//   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }
// }
import 'package:flutter/material.dart';


class Snackbar {
  static void showSnackbar({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
      ),
    );
  }
}


// class Snackbar {
//   static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>();

//   static void showSnackbar({
//     required String message,
//     Duration duration = const Duration(seconds: 2),
//   }) {
//     scaffoldMessengerKey.currentState?.showSnackBar(
//       SnackBar(
//         content: Text(message),
//         duration: duration,
//       ),
//     );
//   }
// }
