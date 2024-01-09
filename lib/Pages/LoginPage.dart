import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitinn/components/svg_widgets.dart';
import 'package:habitinn/components/textFormFieldWidget.dart';
import 'package:habitinn/main.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:habitinn/Pages/ForgotPasswordPage.dart';
import 'package:habitinn/Pages/RegisterPage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;
  late String _password;
  final auth = FirebaseAuth.instance;
  bool _isObscure = true;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();

    // Delay the execution of _checkCurrentUser until the build cycle is complete
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _checkCurrentUser();
    });
  }

  Future<void> _checkCurrentUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

      if (context != null && auth.currentUser != null && isLoggedIn) {
        Navigator.pushReplacement(
          context!,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    } catch (e) {
      print('Error checking current user: $e');
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in process
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }

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
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(),
              ),
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 50, 15, 15),
                  child: SizedBox(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: LoginSvg(),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                            child: SizedBox(
                              child: MyTextFormField(
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
                                  tlabel: 'E-mail')
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: SizedBox(
                              child:MyTextFormField(
                                  onChanged: (value) {
                                    setState(() {
                                      _password = value.trim();
                                    });
                                  },
                                  isObscure: _isObscure,
                                  sufIcon: IconButton(
                                    icon: Icon(
                                      _isObscure
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: const Color(0xFF395886),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                    },
                                  ),
                                  prefIcon: const Icon(Icons.password_rounded,
                                  color: Color(0xFF395886),
                                  ),
                                  tlabel: 'Password'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 20, 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                          const ForgotPasswordPage(),
                                        ),
                                      );
                                    },
                                    child: GradientText(
                                      'Forgot Password ?',
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                      ),
                                      textAlign: TextAlign.end,
                                      colors: const [
                                        Color(0xFF395886),
                                        Color(0xFF638ECB),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                            child: SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black26.withOpacity(0.1),
                                            spreadRadius: 4,
                                            blurRadius: 4,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: FloatingActionButton.extended(
                                        elevation: 0,
                                        backgroundColor: Colors.white60,
                                        onPressed: () async {
                                          try {
                                            final userCredential =
                                            await auth.signInWithEmailAndPassword(
                                                email: _email, password: _password);
                                            if (userCredential.user != null) {
                                              SharedPreferences prefs =
                                              await SharedPreferences.getInstance();
                                              prefs.setBool('isLoggedIn', true);

                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                  const MyHomePage(),
                                                ),
                                              );
                                            } else {
                                              // Handle login failure
                                            }
                                          } catch (e) {
                                            // Handle login error
                                          }
                                        },
                                        label: const Text(
                                          "login",
                                          style: TextStyle(
                                            color: Color(0xff395886),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.login_rounded,
                                          color: Color(0xFF395886),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Divider(
                                color: Color(0xFF395886),
                                thickness: 5,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterPage(),
                                    ),
                                  );
                                },
                                child: GradientText(
                                  'New to App ? Register',
                                  colors: const [
                                    Color(0xFF395886),
                                    Color(0xFF638ECB),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Color(0xFF395886),
                                thickness: 5,
                              ),
                            ]
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    child: FloatingActionButton.extended(
                                      backgroundColor: Colors.white60,
                                      onPressed: _signInWithGoogle,
                                      icon: const Icon(Icons.g_mobiledata,
                                        color: Color(0xFF395886),
                                      ),
                                      label: const Text("Sign in with Google",
                                      style: TextStyle(
                                        color: Color(0xFF395886),
                                      ),
                                      ),
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

