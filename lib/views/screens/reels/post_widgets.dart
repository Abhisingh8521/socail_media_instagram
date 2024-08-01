import 'dart:io';

import 'package:flutter/material.dart';

import '../../../widgets/custom_widget.dart';

class PostWidgets {
  BuildContext context;
  PostWidgets({required this.context});

  Widget mediaGridView(List<File> mediaAssets) {
    return GridView.builder(
        itemCount: mediaAssets.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: .5),
        itemBuilder: (_, index) {
          return Card(
            shape: const RoundedRectangleBorder(side: BorderSide(width: 2,color: Colors.black)),
            child: Image.file(mediaAssets[index],fit: BoxFit.cover,),
          );
        });
  }

  Widget sendPost(void Function() onPressed,TextEditingController controller){
    return Column(
      children: [
        CustomWidgets.customTextFiled(controller,hintText: "Add caption"),
        CustomWidgets.customButton(onPressed, "Share"),
      ],
    );
  }


}