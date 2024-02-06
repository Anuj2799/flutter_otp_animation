import 'package:flutter/material.dart';

import '../constant/dimensions.dart';

/// A common OTP field to enter text and animate it
class OtpField extends StatelessWidget {
  final Color fieldColour;
  final int numberOfFields;
  final double backgroundWidth;
  final double backgroundHeight;
  final double fieldWidth;
  final double verticalPadding;
  final double fontSize;
  final ValueNotifier<String> otpValue;
  final List<String> listOfValues;
  final Direction direction;
  final FontWeight fontWeight;
  final Color textColor;
  final String? fontFamily;
  final Function(int index) onTapCallBackFunction;

  const OtpField({
    Key? key,
    required this.fieldColour,
    required this.numberOfFields,
    required this.backgroundWidth,
    required this.backgroundHeight,
    required this.fieldWidth,
    required this.otpValue,
    required this.listOfValues,
    required this.verticalPadding,
    required this.direction,
    required this.onTapCallBackFunction,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: backgroundWidth,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: padding,
              top: verticalPadding,
              bottom: verticalPadding,
            ),
            child: ValueListenableBuilder(
              builder: (BuildContext context, value, Widget? child) {
                return InkWell(
                  onTap: () {
                    onTapCallBackFunction(index);
                  },
                  child: _setWidgetAccordingToOtpEntered(
                    (direction == Direction.ltr)
                        ? index
                        : (numberOfFields - NumberConstants.i1 - index),
                  ),
                );
              },
              valueListenable: otpValue,
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: numberOfFields,
      ),
    );
  }

  /// Replacing the entered text with the empty container field
  Widget _setWidgetAccordingToOtpEntered(int index) {
    if (listOfValues.asMap().containsKey(index)) {
      return SizedBox(
        height: backgroundHeight,
        width: fieldWidth,
        child: Center(
          child: Text(
            listOfValues[index],
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: textColor,
              fontFamily: fontFamily,
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: backgroundHeight,
        width: fieldWidth,
        color: fieldColour,
      );
    }
  }

  /// Calculating the even space between the text fields
  double get padding =>
      (backgroundWidth - (numberOfFields.toDouble() * fieldWidth)) /
      (numberOfFields.toDouble() + NumberConstants.d1);
}

/// To set the direction of the widget
enum Direction { ltr, rtl }
