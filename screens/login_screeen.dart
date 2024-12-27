import 'package:chat_app/components/custom_button.dart';
import 'package:chat_app/components/custom_text_field.dart';
import 'package:chat_app/constants/constans.dart';
import 'package:chat_app/helper/show_snackBar.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
bool isLoading = false;
GlobalKey<FormState> formKey = GlobalKey();
String? email;

String? password;


class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                            'Login',
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
                        obscureText: true,
                        onChanged: (data){
                          password = data;
                        },
                        label: 'password',
                      ),
                      SizedBox(height: 25,),
                      CustomButton(
                        text: 'LOGIN',
                        onPressed: ()async {
                          if(formKey.currentState!.validate()) {
                            isLoading = true;
                            setState(() {
                            });
                            try {
                              await LoginUser();
                             // ShowSnackBar(context, 'email
                              // 3success');
                              //nav .popلل Login ......push للاس الحديده
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(emailId: email,)),);
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                ShowSnackBar(context, 'weak password');
                              } else if (e.code == 'email-already-in-use') {
                                ShowSnackBar(context, 'email already in use');
                              }
                            }
                            catch (e) {
                              ShowSnackBar(context, 'there was an error');
                            }
                            isLoading = false;
                            setState(() {

                            });
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              'don\'t have an account ?' ,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          MaterialButton(
                            child: Text(
                              'Sign Up' ,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                              onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()),);
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
}

Future<void> LoginUser() async {
  UserCredential user = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
    email: email!,
    password: password!,
  );
}

