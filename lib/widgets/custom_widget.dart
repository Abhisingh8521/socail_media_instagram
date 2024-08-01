import 'package:flutter/material.dart';

class CustomWidgets {
  static Widget customTextFiled(TextEditingController controller, {String? hintText,
    Icon? prefixIcon,Icon? suffixIcon,void Function(String)? onChanged}) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: (String? text)=>text?.isNotEmpty == true?null:"This is required!",
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        )
      ),

    );
  }
  var _passwordVisible = false;
   textFieldForPasswordEyeView(TextEditingController controller){
    return  StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      return TextFormField(
        keyboardType: TextInputType.text,
        controller: controller,
        obscureText: !_passwordVisible,
        validator: (String? text)=>text?.isNotEmpty == true?null:"This is required!",
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          // labelText: 'Password',
          hintText: 'Enter your password',
          suffixIcon: IconButton(
            icon: Icon(
              _passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      );
    },);
  }
  static customButton(void Function()? onPressed, String text) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: ElevatedButton(onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
          child: Text(text, style: TextStyle(color: Colors.white),),),
      ),
    );
  }
}