import 'package:animated_otp_field/animated_otp_field.dart';
import 'package:animated_otp_field/constant/colour_constant.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Animated OTP Field',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColour,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: AnimatedOtpField(
          onChange: (value) {
            debugPrint('value :: $value');
          },
          onButtonTap: () {},
          onEnd: () {},
          separatedBorderRadius: true,
          autoDismissKeyboard: true,
          direction: Direction.rtl,
        ),
      ),
    );
  }
}
