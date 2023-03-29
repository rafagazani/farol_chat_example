import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LogoFarolWidget extends StatelessWidget {
  double width;
  LogoFarolWidget({Key? key, this.width = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_sem_fundo.png',
      width: width,
    );
  }
}
