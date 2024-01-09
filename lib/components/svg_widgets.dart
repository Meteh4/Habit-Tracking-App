import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginSvg extends StatelessWidget {
  const LoginSvg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/login1.svg',
      semanticsLabel: 'Login',
    );
  }
}

class RegisterSvg extends StatelessWidget {
  const RegisterSvg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/register.svg',
      semanticsLabel: 'Register',
    );
  }
}
class ForgottextSvgWidget extends StatelessWidget {
  const ForgottextSvgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/forgotpasstext.svg',
      semanticsLabel: 'forgotpass',
    );
  }
}

class ForgotSvgWidget extends StatelessWidget {
  const ForgotSvgWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'images/forgotpass.svg',
      semanticsLabel: 'forgotnormal',
    );
  }
}