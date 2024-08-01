import 'package:flutter/material.dart';
import 'package:kriscent_assignment/views/utils/constants.dart';
import 'package:kriscent_assignment/views/utils/extensions/context_extensions.dart';
import 'package:kriscent_assignment/views/utils/extensions/text_style_extensions.dart';

class AppDialogHelper {
  showLogoutDialog(BuildContext context,
      {required void Function()? onPressed}) {
    return showDialog(
      barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
              actions: [
                ElevatedButton(
                    style: _buttonStyle(Colors.red),
                    onPressed: onPressed,
                    child: Text(
                      SURE,
                      style: const TextStyle().whiteTextStyle,
                    )),
                // 10.width,
                ElevatedButton(
                    style: _buttonStyle(Colors.green),
                    onPressed: () {
                      context.onBackPressed;
                    },
                    child: Text(
                      NOT_NOW,
                      style: const TextStyle().whiteTextStyle,
                    ))
              ],
              title: const Text("$LOGOUT !"),
              content: const Text(LOGOUT_MESSAGE),
            ));
  }

  _buttonStyle(Color bgColor) =>
      ElevatedButton.styleFrom(backgroundColor: bgColor);
}
