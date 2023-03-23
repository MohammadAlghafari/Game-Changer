import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import '../../../constants/colors/colors.dart';
import '../../../constants/fonts/fonts.dart';

/// This widget is a stateFull widget Build to custom Text Field input.
/// @Params :
/// 1. hint: text as a hint Prop text in the [@Core InputDecoration] class
/// 2. icon: icon as a icon Prop in the [@Core InputDecoration] class
/// 3. fillColor : fillColor as a fillColor Prop in the [@Core InputDecoration] class
/// 4. height, width : to determined the height and width of the textField it's covered by SizedBox @Core class
/// 5. textType : textType as a keyboardType Prop in the [@Core TextFormField] class
/// 6. controller : controller as a controller Prop in the [@Core TextFormField] class
/// 7. textInputAction : textInputAction as textInputAction Prop in the [@Core TexFormField] class
///
class CustomTextField extends StatefulWidget {
  final String? hint;
  final Widget? icon;
  final Color fillColor;
  final TextInputType? textType;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final double? height, width;
  final int? minLines;
  final int? maxLines;
  final int? maxCharacters;
  final List? inputFormatters;
  final int? textInputFormatter;
  final Function? onValid;
  final Function(String)? onChange;
  final bool? enableField;
  final TextAlign? textAlign;
  final TextDirection textDirection;
  final double bottomPadding;
  final bool? isPassword;
  final Widget? preFixWidget;
  final Function? onTap;
  final Function(dynamic value)? onSaved;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Widget? prefix;
  final Widget? suffix;
  final String? initialText;
  const CustomTextField(
      {Key? key,
      this.suffix,
      this.prefix,
      this.fillColor = AppColors.greyColor,
      this.inputFormatters,
      this.borderColor = AppColors.whiteColor,
      this.hintStyle = const TextStyle(color: AppColors.blackColor),
      this.textStyle = const TextStyle(
          color: AppColors.blackColor,
          fontFamily: AppFonts.nunitoFamily,
          fontWeight: FontWeight.w400,
          fontSize: 14),
      this.isPassword = false,
      this.enableField = true,
      this.hint,
      this.onTap,
      this.onSaved,
      this.icon,
      this.preFixWidget,
      this.textType = TextInputType.visiblePassword,
      this.controller,
      this.textInputAction = TextInputAction.done,
      this.height,
      this.width,
      this.minLines = 1,
      this.maxLines = 30,
      this.maxCharacters,
      this.textInputFormatter = 1000,
      this.onValid,
      this.bottomPadding = 0.0,
      this.onChange,
      this.textAlign = TextAlign.left,
      this.initialText,
      this.textDirection = TextDirection.ltr})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  void togglePassword() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    obscureText = widget.isPassword!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextFormField(
        key: widget.key,
        style: widget.textStyle,
        onTap: () {
          if (widget.onTap != null) widget.onTap!();
        },
        onSaved: (value) {
          if (widget.onSaved != null) widget.onSaved!(value);
        },
        enableInteractiveSelection: widget.enableField!,
        readOnly: !widget.enableField!,
        textDirection: ui.TextDirection.ltr,
        onChanged: widget.onChange,
        controller: widget.controller,
        autofocus: false,
        initialValue: widget.initialText,
        minLines: widget.minLines,
        maxLines: obscureText ? 1 : widget.maxLines,
        maxLength: widget.maxCharacters,
        textAlign: TextAlign.left,
        decoration: InputDecoration(
          icon: widget.icon,
          fillColor: widget.fillColor,
          prefix: widget.prefix ??
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
              ),
          suffixIcon: widget.isPassword!
              ? GestureDetector(
                  onTap: () {
                    togglePassword();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.r),
                    child: (Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: AppColors.blackColor,
                      size: 20.r,
                    )),
                  ))
              : widget.suffix,
          filled: true,
          labelStyle: const TextStyle(color: Color(0xFF000000)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: BorderSide(color: widget.borderColor!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: BorderSide(color: widget.borderColor!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: BorderSide(color: widget.borderColor!),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          contentPadding: widget.minLines! > 1
              ? const EdgeInsets.fromLTRB(12, 12, 12, 8)
              : EdgeInsets.zero,
          hintText: widget.hint,
          hintStyle: widget.hintStyle,
          alignLabelWithHint: true,
          //labelText: widget.hint,
        ),
        keyboardType: widget.textType,
        /* scrollPadding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 50),*/
        textInputAction: widget.textInputAction,
        inputFormatters: <TextInputFormatter>[
          LengthLimitingTextInputFormatter(widget.textInputFormatter),
          ...(widget.inputFormatters ?? []),
        ],
        validator: (String? value) {
          if (widget.onValid != null) {
            var v = widget.onValid!(value);
            if (v != null) return (v.toString());
          }
          return null;
        },
        obscureText: obscureText,
      ),
    );
  }
}
