import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitinn/Pages/LoginPage.dart';
import 'package:lottie/lottie.dart';

import '../components/svg_widgets.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late String _email;
  late String _password;
  final auth = FirebaseAuth.instance;
  bool _isObscure = true;

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
                      child: RegisterSvg(),
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
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                      child: Column(
                        children: [
                          SizedBox(
                            child:TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _email = value.trim();
                                });
                              },
                              cursorHeight: 18,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xFF395886),),
                                  borderRadius: BorderRadius.circular(20.10),
                                ),
                                enabledBorder:  OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.10),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF395886),
                                  ),
                                ),
                                prefixIcon:   const Icon(
                                  Icons.alternate_email,
                                  color: Color(0xFF395886),
                                ),
                                filled: true,
                                fillColor: Colors.white60,
                                labelText: "Enter your Email",
                                labelStyle: const TextStyle(color: Color(0xFF395886),),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                            child: SizedBox(
                              child:TextFormField(
                                onChanged: (value) {
                                  setState(() {
                                    _password = value.trim();
                                  });
                                },
                                cursorHeight: 18,
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:  const BorderSide(color: Color(0xFF395886),),
                                    borderRadius: BorderRadius.circular(20.10),
                                  ),
                                  enabledBorder:  OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.10),
                                    borderSide: const BorderSide(
                                      color: Color(0xFF395886),
                                    ),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _isObscure ? Icons.visibility : Icons.visibility_off,
                                      color: const Color(0xFF395886),),
                                    onPressed: (){
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  ),
                                  prefixIcon:  const Icon(
                                    Icons.password_outlined,
                                    color: Color(0xFF395886),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white60,
                                  labelText: "Enter your Password",
                                  labelStyle: const TextStyle(color: Color(0xFF395886),),
                                ),
                              ),
                            ),
                          ),
                          Container(
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
                                        auth.createUserWithEmailAndPassword(email: _email, password: _password);
                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()),);}, label: const Text("Register",
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

                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
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


