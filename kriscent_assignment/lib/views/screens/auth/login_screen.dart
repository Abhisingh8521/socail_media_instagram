import 'package:flutter/material.dart';
import 'package:kriscent_assignment/controllers/auth/auth_controller.dart';
import 'package:kriscent_assignment/views/screens/auth/signup_screen.dart';
import 'package:kriscent_assignment/views/utils/builders/loader_builder.dart';
import 'package:kriscent_assignment/views/utils/extensions/context_extensions.dart';
import 'package:kriscent_assignment/views/utils/extensions/int_extensions.dart';
import 'package:kriscent_assignment/widgets/custom_widget.dart';
import '../../../widgets/custom_button.dart';
import '../landing/landing_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Form(
            key: loginKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/logo/insta_text_logo.png',
                        // Placeholder image URL
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.15,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Enter your email and password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomWidgets.customTextFiled(emailController,
                    hintText: "Enter your email"),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomWidgets().textFieldForPasswordEyeView(passwordController),
                50.height,
                Center(
                    child: CustomButton(
                  text: "Login",
                  onPressed: () async{
                   if(loginKey.currentState!.validate()){
                     LoaderBuilder(context: context).showLoader(title: "Login...");
                     var user = await AuthController().loginWithEmailAndPassword(
                         email: emailController.text.trim(),
                         password: passwordController.text.trim());
                     if(user != null){
                       LoaderBuilder(context: context).dismissLoader();
                       context.gotoNextNeverBack(page: LandingScreen());
                     }else{
                       LoaderBuilder(context: context).dismissLoader();
                     }
                   }
                  },
                )),
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () {
                          context.gotoNext(page: SignUpScreen());
                          // Get.to(SignUpScreen());
                        },
                        child: Text(
                          'Signup',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
