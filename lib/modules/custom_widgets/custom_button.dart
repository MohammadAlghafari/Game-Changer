import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants/colors/colors.dart';
import '../../constants/text_styles/text_styles.dart';

// custom button design for the app
class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.buttonContent,
      required this.onPressed,
      this.height = 45,
      this.color})
      : super(key: key);

  final Widget buttonContent;
  final Function? onPressed;
  final Color? color;
  final double height;
  @override
  Widget build(BuildContext context) {
    bool disabled = onPressed == null;
    return ElevatedButton(
      onPressed: disabled ? null : () => onPressed!(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        )),
        elevation: MaterialStateProperty.resolveWith<double>(
            (Set<MaterialState> states) {
          return 0.0;
        }),
        textStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              // disabled state
              return AppTextStyles.nunitoRegular(color: AppColors.blackColor);
            }
            return AppTextStyles.nunitoRegular(color: AppColors.blueColor);
          },
        ),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              // disabled state
              return AppColors.greyColor;
            }
            return color ?? AppColors.lightBlueColor;
          },
        ),
        minimumSize: MaterialStateProperty.resolveWith<Size>(
            (Set<MaterialState> states) {
          return Size.fromHeight(height.h);
        }),
      ),
      child: buttonContent,
    );
  }
}
