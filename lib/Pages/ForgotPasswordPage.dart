import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitinn/components/svg_widgets.dart';
import 'package:habitinn/components/textFormFieldWidget.dart';
import 'package:lottie/lottie.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  late String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Lottie.asset('images/Loginani.json',
              fit: BoxFit.cover,
              width: screenWidth,
              height: screenHeight,),
          ),
          Positioned.fill(
            child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 20,
                  sigmaY: 20,
                ),
                child: Container()
            ),
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(15, 50, 15, 15),
                child: SizedBox(
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: ForgotSvgWidget()
                  ),),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 3,
                          blurRadius: 3,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(15, 50, 15, 15),
                          child: SizedBox(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: ForgottextSvgWidget()
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 35, 15, 15),
                          child: SizedBox(
                            child:MyTextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _email = value.trim();
                                  });
                                },
                                isObscure: false,
                                sufIcon: const IconButton(
                                  onPressed: null,
                                  icon: Icon(Icons.confirmation_num_sharp,
                                    color:Colors.transparent,),
                                ),
                                prefIcon: const Icon(Icons.alternate_email_rounded,
                                  color: Color(0xFF395886),),
                                tlabel: 'Enter Your E-Mail'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 15, 15, 35),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),

                                  child: FloatingActionButton.extended(
                                    elevation: 0,
                                    backgroundColor: Colors.white60,
                                    onPressed: () {
                                      auth.sendPasswordResetEmail(email: _email);
                                      Navigator.of(context).pop();

                                    }, label: const Text("Submit",
                                    style: TextStyle(
                                      color: Color(0xFF395886),
                                    ),
                                  ),
                                    icon: const Icon(Icons.person_outlined,
                                      color: Color(0xFF395886),),
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
            ],
          ),
        ],
      ),
    );
  }
}



