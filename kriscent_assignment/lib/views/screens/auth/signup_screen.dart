import 'package:flutter/material.dart';
import 'package:kriscent_assignment/views/screens/auth/login_screen.dart';
import 'package:kriscent_assignment/views/utils/extensions/context_extensions.dart';
import 'package:kriscent_assignment/views/utils/extensions/int_extensions.dart';
import 'package:kriscent_assignment/widgets/custom_widget.dart';
import '../../../controllers/auth/auth_controller.dart';
import '../../../widgets/custom_button.dart';
import '../../utils/builders/loader_builder.dart';
import '../landing/landing_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var signupKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 400,
            ),
            child: Form(
              key: signupKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  40.height,
                  Image.asset(
                    'assets/logo/insta_text_logo.png',
                    // Replace with your logo asset
                    height: 100,
                  ),
                  40.height,
                  Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  20.height,
                  const Text('Enter your credentials to continue'),
                  const SizedBox(height: 30),
                  CustomWidgets.customTextFiled(nameController, hintText: "Name"),
                  20.height,
                  CustomWidgets.customTextFiled(emailController,
                      hintText: "Enter email"),
                  20.height,
                  CustomWidgets().textFieldForPasswordEyeView(passwordController),
                  20.height,
                  CustomWidgets().textFieldForPasswordEyeView(confirmPasswordController),
                  50.height,
                  CustomButton(
                      text: "SignUp",
                      onPressed: ()async {
                        if(signupKey.currentState!.validate()){
                          if(passwordController.text.trim() == confirmPasswordController.text.trim()){
                            LoaderBuilder(context: context).showLoader(title: "Login...");
                            var user = await AuthController().registerWithEmailAndPassword(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());
                            if(user != null){
                              LoaderBuilder(context: context).dismissLoader();
                              var isAdded = await AuthController().addNewUser(nameController.text.trim(), emailController.text.trim());
                              if(isAdded){
                                context.gotoNextNeverBack(page: LandingScreen());
                              }
                            }else{
                              LoaderBuilder(context: context).dismissLoader();
                            }
                          }else{
                           context.showSnackBar("Password not matched", Colors.red);
                          }

                        }
                      }),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: ()=>context.gotoNext(page: LoginScreen()),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    ;
  }

  Widget _buildTextField({
    required String labelText,
    required String hintText,
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: obscureText ? Icon(Icons.visibility_off) : null,
      ),
    );
  }
}
