import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String message,
    bool isDismissible = true,
  }) {
    showDialog(
        barrierDismissible: isDismissible,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                const CircularProgressIndicator(),
                const SizedBox(
                  width: 12,
                ),
                Text(message),
              ],
            ),
          );
        });
  }

  static void hideLoading({
    required BuildContext context,
  }) {
    Navigator.pop(context);
  }

  // static void showMessage({
  //   required BuildContext context,
  //   required String message,
  //   String? title,
  //   String? posActionName,
  //   Function? posAction,
  //   String? nagActionName,
  //   Function? nagAction,
  //   bool isDismissible = true,
  // }) {
  //   List<Widget> actions = [];
  //   if (posActionName != null) {
  //     actions.add(
  //       TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //             if (posAction != null) {
  //               posAction.call();
  //             }
  //           },
  //           child: Text(posActionName)),
  //     );
  //   }
  //   if (nagActionName != null) {
  //     actions.add(
  //       TextButton(
  //           onPressed: () {
  //              Navigator.pop(context);
  //             duration:
  //             Duration(seconds: 2);
  //             if (nagAction != null) {
  //               nagAction.call();
  //             }
  //           },
  //           child: Text(nagActionName)),
  //     );
  //   }

  //   showDialog(
  //       barrierDismissible: isDismissible,
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           content: Text(message),
  //           title: Text(
  //             title ?? '',
  //             style: Theme.of(context).textTheme.titleMedium,
  //           ),
  //           actions: actions,
  //         );
  //       });
  // }

  static void showMessage({
    required BuildContext context,
    required String message,
    String? title,
    String? posActionName,
    Function? posAction,
    String? nagActionName,
    Function? nagAction,
    bool isDismissible = true,
  }) {
    List<Widget> actions = [];
    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            if (posAction != null) {
              posAction.call();
            }
          },
          child: Text(posActionName),
        ),
      );
    }
    if (nagActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Future.delayed(const Duration(seconds: 1), () {
              if (nagAction != null) {
                nagAction.call();
              }
            });
          },
          child: Text(nagActionName),
        ),
      );
    }

    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          title: Text(
            title ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: actions,
        );
      },
    );
  }

  static void showMessageD({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(milliseconds: 800),
    String? title,
    String? posActionName,
    Function? posAction,
    String? nagActionName,
    Function? nagAction,
    bool isDismissible = true,
  }) {
    List<Widget> actions = [];

    if (posActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            if (posAction != null) {
              posAction.call();
            }
          },
          child: Text(posActionName),
        ),
      );
    }

    if (nagActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            if (nagAction != null) {
              nagAction.call();
            }
          },
          child: Text(nagActionName),
        ),
      );
    }

    showDialog(
      barrierDismissible: isDismissible,
      context: context,
      builder: (context) {
        Future.delayed(duration, () {
          Navigator.pop(
              context); // Close the dialog after the specified duration
        });

        return AlertDialog(
          content: Text(message),
          title: Text(
            title ?? '',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: actions,
        );
      },
    );
  }
}
