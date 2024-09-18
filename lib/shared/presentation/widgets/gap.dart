import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Gap extends StatelessWidget {
  final double? height;
  const Gap({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 10.h,
    );
  }
}
