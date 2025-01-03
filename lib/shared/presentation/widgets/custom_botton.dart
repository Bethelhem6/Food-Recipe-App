import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final String? loadingText;
  final Color? backgroundColor;
  final bool? isLoading;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? borderRadius;
  final double? height;
  final Color? titleColor;

  const CustomButton({
    super.key,
    this.backgroundColor,
    required this.onPressed,
    this.isLoading,
    this.titleColor,
    this.loadingText,
    this.width,
    this.borderRadius,
    this.height,
    this.margin,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ??
          EdgeInsets.only(
              right: MediaQuery.of(context).size.width * .06,
              left: MediaQuery.of(context).size.width * .06,
              top: 20),
      width: width ?? double.infinity,
      height: height ?? 58,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 15),
              ),
              // backgroundColor: backgroundColor ?? AppColors.primaryColor),
              backgroundColor: backgroundColor ?? const Color(0xff3A3838)),
          onPressed: () {
            if (isLoading != true) {
              onPressed!();
            }
          },
          child: isLoading == true
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      loadingText ?? 'loading...',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              : Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: titleColor ?? Colors.white,
                  ),
                )),
    );
  }
}
