import 'package:animated_otp_field/constant/colour_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/dimensions.dart';
import 'helper.dart';

class AnimatedOtpField extends StatefulWidget {
  /// [backgroundHeight] is used to set the height of the
  /// OTP field, by default it is set to 50.0
  final double backgroundHeight;

  /// [backgroundWidth] is used to set the width of the
  /// OTP field, by default it is set to 280.0
  final double backgroundWidth;

  /// This [fieldWidth] property is use to set the width of the unselected field where
  /// every text will be entered
  final double fieldWidth;

  /// Vertical padding can be set from here by giving the value in this it will
  /// leave the space symmetrically from top and bottom
  final double verticalPadding;

  /// [fontSize] is used to set the font size of the entered text
  final double fontSize;

  /// [otpFieldBorderRadius] can be use to give the borderRadius to OTP field
  /// as well as the button if it is enabled
  final double otpFieldBorderRadius;

  /// [buttonBorderRadius] can be use to give the borderRadius to the button if it is enabled
  final double buttonBorderRadius;

  /// [buttonPaddingFromField] will allow to give the space between button and OTP field
  final double buttonPaddingFromField;

  /// This is used to set the bg color of the otp field
  final Color backgroundColour;

  /// The unselected field color can be set from this property
  final Color fieldColour;

  /// [sliderColour] can be use to give the color to the sliding animation widget
  /// this same color will be applied when the slider is stable and blinking
  final Color sliderColour;

  /// [buttonColour] is used to set the color of the button if it is enabled
  final Color buttonColour;

  /// [defaultButtonIconColour] is used to set the color of the buttonIcon if it is enabled
  final Color defaultButtonIconColour;

  /// [textColor] is use to set color of the entered text
  final Color textColor;

  /// [numberOfFields] will indicate how many number of fields will be there in OTP field
  final int numberOfFields;

  /// [fontFamily] can be used to set the fontFamily of entered text
  final String? fontFamily;

  /// If user wants keyboard to appear as soon as the screen arrives it can be done from here
  final bool autoFocus;

  /// [showButton] can toggle whether the button will be shown after every field is entered or not
  final bool showButton;

  /// [enableAutoFill] will be used to to auto fill the otp that comes to the text via SMS or any other mode
  final bool enableAutoFill;

  /// [autoDismissKeyboard] will dismisses the keyboard once every field is entered
  final bool autoDismissKeyboard;

  /// [autoDisposeControllers] if set true then it will automatically dispose the [TextEditingController]
  /// once user leave that screen
  final bool autoDisposeControllers;

  /// [readOnly] by setting this to true it will only allow user to read and not to write
  final bool readOnly;

  /// [separatedBorderRadius] can be used to give border radius to OTP field and button separately
  final bool separatedBorderRadius;

  /// This will allow to set the weight of the fonts
  final FontWeight fontWeight;

  /// [textInputType] will determine which kind of keyboard will appear whether it is numeric, alphanumeric or any other else
  final TextInputType textInputType;

  /// [direction] can be used to determine in which direction will OTP widget will appear
  /// that is from left-to-right or right-to-left
  final Direction direction;

  /// This can bes used to set the widget inside the button it could be any widget,
  /// by default it is set to [Icons.arrow_back_outlined]
  final Widget? buttonContent;

  /// [onButtonTap] is called when user taps the button that appears once every fields are filled
  final VoidCallback? onButtonTap;

  /// [onEnd] is called once every text fields are entered and there is nothing left to enter anymore
  final VoidCallback? onEnd;

  /// [onChange] is exactly like [TextField]'s onChange as soon as any user enters any text field those
  /// changes can be listened in this callback function
  final Function(String value)? onChange;

  /// [textEditingController] is a controller of the entered texts
  final TextEditingController? textEditingController;

  /// [slideAnimationDuration] can be used to define the duration of sliding animation(animation between two text fields)
  final Duration? slideAnimationDuration;

  /// [blinkAnimationDuration] determines the animation duration of blinking of cursor
  final Duration? blinkAnimationDuration;

  /// [buttonAnimationDuration] can be used to set the duration of button appearance by animation
  final Duration? buttonAnimationDuration;

  /// [inputFormatters] Default it has [LengthLimitingTextInputFormatter] and user can also add their own inputFormatters as well
  final List<TextInputFormatter>? inputFormatters;

  /// [onEditingComplete] is [TextField]'s onEditingComplete property
  final VoidCallback? onEditingComplete;

  /// /// [onSubmitted] is [TextField]'s onSubmitted property
  final ValueChanged<String>? onSubmitted;

  /// [keyboardAppearance] can be used to set the light or dark mode for iOS keyboard.
  final Brightness? keyboardAppearance;

  const AnimatedOtpField({
    Key? key,
    this.backgroundHeight = NumberConstants.d50,
    this.backgroundWidth = NumberConstants.d250,
    this.fieldWidth = NumberConstants.d5,
    this.verticalPadding = NumberConstants.d8,
    this.fontSize = NumberConstants.d18,
    this.otpFieldBorderRadius = NumberConstants.d0,
    this.buttonBorderRadius = NumberConstants.d0,
    this.buttonPaddingFromField = NumberConstants.d0,
    this.fontWeight = FontWeight.bold,
    this.backgroundColour = AppColors.white,
    this.fieldColour = AppColors.backgroundColour,
    this.sliderColour = AppColors.selectedColour,
    this.buttonColour = AppColors.selectedColour,
    this.defaultButtonIconColour = AppColors.white,
    this.textColor = AppColors.black,
    this.numberOfFields = NumberConstants.i4,
    this.textInputType = TextInputType.visiblePassword,
    this.direction = Direction.ltr,
    this.autoFocus = false,
    this.showButton = true,
    this.enableAutoFill = false,
    this.autoDismissKeyboard = false,
    this.autoDisposeControllers = true,
    this.readOnly = false,
    this.separatedBorderRadius = false,
    this.textEditingController,
    this.onChange,
    this.onButtonTap,
    this.onEnd,
    this.buttonContent,
    this.fontFamily,
    this.slideAnimationDuration,
    this.blinkAnimationDuration,
    this.buttonAnimationDuration,
    this.inputFormatters,
    this.onEditingComplete,
    this.onSubmitted,
    this.keyboardAppearance,
  }) : super(key: key);

  @override
  State<AnimatedOtpField> createState() => _AnimatedOtpFieldState();
}

class _AnimatedOtpFieldState extends State<AnimatedOtpField> with TickerProviderStateMixin {
  final ValueNotifier<bool> _isFieldAnimationCompleted = ValueNotifier(false);
  final ValueNotifier<bool> _isEveryFieldFilled = ValueNotifier(false);
  final ValueNotifier<bool> _onceTapDone = ValueNotifier(false);
  final ValueNotifier<bool> _isBtnAnimationCompleted = ValueNotifier(false);
  final ValueNotifier<double> _focusedFieldWidth = ValueNotifier(NumberConstants.d0);
  final ValueNotifier<double> _sliderLeftPadding = ValueNotifier(NumberConstants.d0);
  final ValueNotifier<double> _extraPadding = ValueNotifier(NumberConstants.d0);
  final ValueNotifier<int> _incrementValue = ValueNotifier(NumberConstants.i0);
  final ValueNotifier<int> _checkForBlinkAnimation = ValueNotifier(NumberConstants.i0);
  final ValueNotifier<String> _otpValues = ValueNotifier('');
  final FocusNode _focusNode = FocusNode();
  final List<String> _listOfValues = [];
  late Animation<double> _fadeInFadeOut;
  late Animation<double> _stopFadeInFadeOut;
  late AnimationController _fadeAnimationController;
  late TextEditingController _textEditingController;

  /// Get the padding as per the fields entered
  double get padding =>
      (widget.backgroundWidth - (widget.numberOfFields.toDouble() * widget.fieldWidth)) /
      (widget.numberOfFields.toDouble() + NumberConstants.d1);

  String _previousText = '';
  bool _isBackspaceTapped = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.showButton && widget.direction == Direction.ltr ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// To animate the button after entering all the text in textField from right to left
          if (widget.showButton && widget.direction == Direction.rtl)
            SizedBox(
              height: widget.backgroundHeight,
              width: (MediaQuery.of(context).size.width - widget.backgroundWidth).abs() / 2,
              child: Stack(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _isBtnAnimationCompleted,
                    builder: (context, value, child) {
                      return AnimatedPositioned(
                        duration: widget.buttonAnimationDuration ?? const Duration(milliseconds: NumberConstants.t200),
                        right: _isBtnAnimationCompleted.value ? widget.buttonPaddingFromField : NumberConstants.d0,
                        child: ValueListenableBuilder(
                          valueListenable: _isFieldAnimationCompleted,
                          builder: (BuildContext context, value, Widget? child) {
                            return GestureDetector(
                              onTap: widget.onButtonTap,
                              child: AnimatedContainer(
                                duration: widget.buttonAnimationDuration ?? const Duration(milliseconds: NumberConstants.t200),
                                height: widget.backgroundHeight,
                                width: _isBtnAnimationCompleted.value
                                    ? widget.backgroundHeight
                                    : _isFieldAnimationCompleted.value
                                        ? (widget.backgroundHeight + widget.buttonPaddingFromField)
                                        : NumberConstants.d0,
                                decoration: BoxDecoration(
                                  color: widget.buttonColour,
                                  borderRadius: _buttonBorderRadiusHandler(),
                                ),
                                child: _isFieldAnimationCompleted.value
                                    ? (widget.buttonContent ??
                                        Center(
                                          child: Icon(Icons.arrow_back_outlined, color: widget.defaultButtonIconColour),
                                        ))
                                    : null,
                                onEnd: () {
                                  if (!_isBackspaceTapped) _isBtnAnimationCompleted.value = true;
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

          /// Main animation body to enter the text
          Center(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                /// In order to get the text field
                SizedBox(
                  height: widget.backgroundHeight,
                  width: widget.backgroundWidth,
                  child: Theme(
                    data: ThemeData(textSelectionTheme: const TextSelectionThemeData(cursorColor: AppColors.transparent)),
                    child: TextField(
                      cursorColor: AppColors.transparent,
                      focusNode: _focusNode,
                      cursorWidth: NumberConstants.d0,
                      cursorHeight: NumberConstants.d0,
                      controller: _textEditingController,
                      enableSuggestions: false,
                      autocorrect: false,
                      autofillHints: widget.enableAutoFill ? const <String>[AutofillHints.oneTimeCode] : null,
                      onChanged: _onChangeHandler,
                      readOnly: widget.readOnly,
                      onSubmitted: widget.onSubmitted,
                      onEditingComplete: widget.onEditingComplete,
                      keyboardAppearance: widget.keyboardAppearance,
                      style: const TextStyle(color: AppColors.transparent, fontSize: NumberConstants.d0),
                      keyboardType: widget.textInputType,
                      inputFormatters: [LengthLimitingTextInputFormatter(widget.numberOfFields), ...?widget.inputFormatters],
                      decoration: const InputDecoration(
                        fillColor: AppColors.transparent,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusColor: AppColors.transparent,
                        hoverColor: AppColors.transparent,
                        iconColor: AppColors.transparent,
                        prefixIconColor: AppColors.transparent,
                        suffixIconColor: AppColors.transparent,
                      ),
                    ),
                  ),
                ),

                /// All the OTP fields, it depends on the number of fields entered by the user
                GestureDetector(
                  onTap: _initialFocusAnimationHandler,
                  child: ValueListenableBuilder(
                    valueListenable: _isFieldAnimationCompleted,
                    builder: (context, value, child) {
                      return Container(
                        height: widget.backgroundHeight,
                        width: widget.backgroundWidth,
                        decoration: BoxDecoration(
                          color: widget.backgroundColour,
                          borderRadius: _otpFieldBorderRadiusHandler(value: value),
                        ),
                        child: OtpField(
                          fieldColour: widget.fieldColour,
                          numberOfFields: widget.numberOfFields,
                          backgroundWidth: widget.backgroundWidth,
                          backgroundHeight: widget.backgroundHeight,
                          fieldWidth: widget.fieldWidth,
                          otpValue: _otpValues,
                          listOfValues: _listOfValues,
                          onTapCallBackFunction: (_) {
                            _initialFocusAnimationHandler();
                          },
                          verticalPadding: widget.verticalPadding,
                          direction: widget.direction,
                          fontFamily: widget.fontFamily,
                          fontSize: widget.fontSize,
                          fontWeight: widget.fontWeight,
                          textColor: widget.textColor,
                        ),
                      );
                    },
                  ),
                ),

                /// To animate the sliding container and to listen it for its changes
                ValueListenableBuilder(
                  valueListenable: _focusedFieldWidth,
                  builder: (BuildContext context, value, Widget? child) {
                    return AnimatedPositioned(
                      duration: widget.slideAnimationDuration ?? const Duration(milliseconds: NumberConstants.t200),
                      height: widget.backgroundHeight - (widget.verticalPadding * 2),
                      width: _focusedFieldWidth.value,
                      left: widget.direction == Direction.ltr ? _sliderLeftPadding.value : null,
                      right: widget.direction == Direction.rtl ? _sliderLeftPadding.value : null,
                      onEnd: _onSliderEndEvent,
                      child: ValueListenableBuilder(
                        valueListenable: _checkForBlinkAnimation,
                        builder: (context, value, child) {
                          /// Main slider widget fade transition
                          return FadeTransition(
                            opacity: _checkForBlinkAnimation.value != NumberConstants.i2 ? _stopFadeInFadeOut : _fadeInFadeOut,

                            /// Main slider widget
                            child: Container(
                              color: widget.sliderColour,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          /// To animate the button after entering all the text in textField from left to right
          if (widget.showButton && widget.direction == Direction.ltr)
            SizedBox(
              height: widget.backgroundHeight,
              width: (MediaQuery.of(context).size.width - widget.backgroundWidth) / 2,
              child: Stack(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _isBtnAnimationCompleted,
                    builder: (BuildContext context, value, Widget? child) {
                      return AnimatedPositioned(
                        duration: widget.buttonAnimationDuration ?? const Duration(milliseconds: NumberConstants.t200),
                        left: _isBtnAnimationCompleted.value ? widget.buttonPaddingFromField : NumberConstants.d0,
                        child: ValueListenableBuilder(
                          valueListenable: _isFieldAnimationCompleted,
                          builder: (BuildContext context, value, Widget? child) {
                            return GestureDetector(
                              onTap: widget.onButtonTap,
                              child: AnimatedContainer(
                                duration: widget.buttonAnimationDuration ?? const Duration(milliseconds: NumberConstants.t200),
                                height: widget.backgroundHeight,
                                width: _isBtnAnimationCompleted.value
                                    ? widget.backgroundHeight
                                    : _isFieldAnimationCompleted.value
                                        ? (widget.backgroundHeight + widget.buttonPaddingFromField)
                                        : NumberConstants.d0,
                                decoration: BoxDecoration(
                                  color: widget.buttonColour,
                                  borderRadius: _buttonBorderRadiusHandler(),
                                ),
                                child: _isFieldAnimationCompleted.value
                                    ? (widget.buttonContent ??
                                        Center(
                                          child: Icon(Icons.arrow_forward_outlined, color: widget.defaultButtonIconColour),
                                        ))
                                    : null,
                                onEnd: () {
                                  if (!_isBackspaceTapped) _isBtnAnimationCompleted.value = true;
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }

  /// Handle events at the time of initState of this class
  void _initialize() {
    _textEditingController = widget.textEditingController ?? TextEditingController();
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: NumberConstants.t500),
    );
    _fadeInFadeOut = Tween<double>(begin: NumberConstants.d0, end: NumberConstants.d1).animate(_fadeAnimationController);
    _stopFadeInFadeOut = Tween<double>(begin: NumberConstants.d1, end: NumberConstants.d1).animate(_fadeAnimationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.autoFocus) _initialFocusAnimationHandler(isAutoFocused: true);
    });
  }

  /// Handle dispose events of this class
  void _dispose() {
    _fadeAnimationController.dispose();
    if (widget.autoDisposeControllers) _textEditingController.dispose();
  }

  /// On end animation on animated container of main sliding animation
  void _onSliderEndEvent() {
    if (!_isEveryFieldFilled.value) {
      /// Incrementing this value, so that we can know that a second time animation is completed
      _checkForBlinkAnimation.value++;

      /// Checking whether a second time animation is completed or not
      if (_checkForBlinkAnimation.value == NumberConstants.i2 && widget.blinkAnimationDuration != Duration.zero) {
        /// Fade In Fade Out Animation logic
        _fadeAnimationController
          ..duration = widget.blinkAnimationDuration ?? const Duration(milliseconds: NumberConstants.t500)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _fadeAnimationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _fadeAnimationController.forward();
            }
          });
        _fadeAnimationController.forward();
      } else if (widget.blinkAnimationDuration == Duration.zero) {
        _fadeAnimationController.value = NumberConstants.d1;
      }

      /// Checking whether all the fields has been completed or not in order to stop the further animation
      if (_incrementValue.value == (widget.numberOfFields + NumberConstants.i1)) {
        _isEveryFieldFilled.value = true;
      }

      /// Extra left margin to push the animation forward
      _sliderLeftPadding.value = (padding * _incrementValue.value) == padding
          ? (padding * _incrementValue.value)
          : (padding * _incrementValue.value) + _extraPadding.value;

      /// Setting the value of the selected text field to widget.fieldWidth in order to animate it to its size
      _focusedFieldWidth.value = widget.fieldWidth;
    } else {
      if (!_isBackspaceTapped) {
        _isEveryFieldFilled.value = false;
        _isFieldAnimationCompleted.value = true;

        /// This will call a void callback function once all the field has been entered
        widget.onEnd?.call();

        /// This will automatically dismisses the keyboard once every field is filled
        if (widget.autoDismissKeyboard) _focusNode.unfocus();
      }
    }
  }

  /// onChanges function for the textField
  void _onChangeHandler(String value) {
    if (value.length <= widget.numberOfFields) {
      _otpValues.value = value;

      /// To detect the backspace
      if (_previousText.length > value.length) {
        _handleBackspaceEvent(value: value);
      } else {
        _handleNormalOnChangeEvent(value: value);
      }
      _previousText = value;
    }

    /// Return onChange value
    widget.onChange?.call(_listOfValues.join(""));
  }

  /// onTap handle function for the textField
  void _initialFocusAnimationHandler({bool? isAutoFocused}) {
    _focusNode.unfocus();
    _focusNode.requestFocus();
    if (isAutoFocused ?? !_onceTapDone.value) {
      _checkForBlinkAnimation.value = NumberConstants.i0;
      if (_focusedFieldWidth.value <= widget.backgroundWidth) {
        _focusedFieldWidth.value += (padding + widget.fieldWidth);
        if (_incrementValue.value <= widget.numberOfFields) {
          _incrementValue.value++;
          if ((padding * _incrementValue.value) != padding) {
            _extraPadding.value += widget.fieldWidth;
          }
        }
      }
    }
    _onceTapDone.value = true;
  }

  /// Handle event on tap of backspace
  void _handleBackspaceEvent({required String value}) {
    _isBackspaceTapped = true;

    /// Re-initializing the blink animation value to handle the fadeIn/fadeOut animation properly
    _checkForBlinkAnimation.value = NumberConstants.i0;

    /// Set this to false to let the padding animation for between button and field to know
    /// that the button stretch animation is over or not
    _isBtnAnimationCompleted.value = false;

    if (_isFieldAnimationCompleted.value) {
      _isFieldAnimationCompleted.value = false;
    }

    /// Handles padding from the right side so that
    /// it could animate in reverse order on tap of backspace
    _incrementValue.value--;
    if ((padding * _incrementValue.value) != padding) {
      _extraPadding.value -= NumberConstants.d5;
    }

    /// Extra right margin to push the animation backward
    _sliderLeftPadding.value = (padding * _incrementValue.value) == padding
        ? (padding * _incrementValue.value)
        : (padding * _incrementValue.value) + _extraPadding.value;

    /// Setting the width of the animated slider container
    _focusedFieldWidth.value += (padding + widget.fieldWidth);

    /// this will remove the last letter from the list (backspace event)
    if (value.isNotEmpty) {
      _listOfValues.removeLast();
    } else {
      _listOfValues.clear();
      _extraPadding.value = 0.0;
    }
  }

  /// Handle event on normal onChange
  void _handleNormalOnChangeEvent({required String value}) {
    _isBackspaceTapped = false;

    /// Re-initializing the blink animation value to handle the fadeIn/fadeOut animation properly
    _checkForBlinkAnimation.value = NumberConstants.i0;

    if (_incrementValue.value <= widget.numberOfFields) {
      _incrementValue.value++;
      if ((padding * _incrementValue.value) != padding) {
        _extraPadding.value += widget.fieldWidth;
      }
    }

    /// Setting the width of the animated slider container
    _focusedFieldWidth.value += (padding + widget.fieldWidth);

    /// this will return the list of letters of the text
    if (value.isNotEmpty) {
      _listOfValues.add(value[value.length - 1]);
    }
  }

  /// Handle border radius for OTP button
  BorderRadius _buttonBorderRadiusHandler() {
    if (!widget.separatedBorderRadius) {
      if (widget.direction == Direction.ltr) {
        return BorderRadius.only(
          bottomRight: Radius.circular(widget.buttonBorderRadius),
          topRight: Radius.circular(widget.buttonBorderRadius),
        );
      } else {
        return BorderRadius.only(
          bottomLeft: Radius.circular(widget.buttonBorderRadius),
          topLeft: Radius.circular(widget.buttonBorderRadius),
        );
      }
    } else {
      return BorderRadius.all(
        Radius.circular(widget.buttonBorderRadius),
      );
    }
  }

  /// Handle border radius for OTP field
  BorderRadius _otpFieldBorderRadiusHandler({required bool value}) {
    if (!widget.separatedBorderRadius && value) {
      if (widget.direction == Direction.ltr) {
        return BorderRadius.only(
          bottomLeft: Radius.circular(widget.otpFieldBorderRadius),
          topLeft: Radius.circular(widget.otpFieldBorderRadius),
        );
      } else {
        return BorderRadius.only(
          bottomRight: Radius.circular(widget.otpFieldBorderRadius),
          topRight: Radius.circular(widget.otpFieldBorderRadius),
        );
      }
    } else {
      return BorderRadius.all(
        Radius.circular(widget.otpFieldBorderRadius),
      );
    }
  }
}
