import 'package:chat_app/constants/constans.dart';
import 'package:chat_app/helper/show_snackBar.dart';
import 'package:chat_app/screens/login_screeen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/custom_button.dart';
import '../components/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen(  {super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
   String? email;

  String? password;

  bool isLoading = false;

  @override
  GlobalKey<FormState> formKey = GlobalKey();

  Widget build(BuildContext context) {
    return  ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Image.asset(kLogo),
                    Text(
                      'Scholar Chat',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    CustomTextField(
                      onChanged: (data){
                        email = data;
                      },
                      label: 'Email',
                    ),
                    SizedBox(height: 25,),
                    CustomTextField(
                      onChanged: (data){
                        password = data;
                      },
                      label: 'password',
                    ),
                    SizedBox(height: 25,),
                    CustomButton(
                      text: 'REGISTER',
                      onPressed: () async {
                        if(formKey.currentState!.validate()) {
                          isLoading = true;
                          setState(() {

                          });
                          try {
                            await registerUser();
                           // ShowSnackBar(context, 'email success');
                            //nav .popلل Login ......push للاس الحديده
                            Navigator.pop(context);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              ShowSnackBar(context, 'No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              ShowSnackBar(context, 'Wrong password provided for that user.');
                            }
                          }
                          catch (e) {
                            ShowSnackBar(context, 'there was an error');
                          }
                          isLoading = false;
                          setState(() {

                          });
                        }
                                  }
                                ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'already have an account ?' ,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        MaterialButton(
                            child: Text(
                              'Login' ,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: (){
                              Navigator.pop(context, MaterialPageRoute(builder: (context) => LoginScreen(),),);
                            }
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
      UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
