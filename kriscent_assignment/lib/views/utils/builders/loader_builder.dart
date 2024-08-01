import 'package:flutter/material.dart';
import 'package:kriscent_assignment/views/utils/colors.dart';
import 'package:kriscent_assignment/views/utils/extensions/context_extensions.dart';
import 'package:kriscent_assignment/views/utils/extensions/int_extensions.dart';
import 'package:kriscent_assignment/views/utils/extensions/text_style_extensions.dart';
import 'package:kriscent_assignment/views/utils/extensions/widget_extensions.dart';

class LoaderBuilder{
  BuildContext context;
  LoaderBuilder({required this.context});

  showLoader({String title = "Loading..."}){
    return showDialog(context: context, builder: (c){
      return AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(
              color: kPrimaryColor,
            ),
            10.width,
            Text(title,style: TextStyle().primaryTextStyle,)
          ],
        ).paddingAll(10),
      );
    });
  }

  dismissLoader(){
    context.onBackPressed;
  }
}