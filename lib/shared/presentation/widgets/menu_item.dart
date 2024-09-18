import 'package:emebet/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class MenuItem extends StatelessWidget {
  final Function() onTap;
  final String title;
  final String icon;
  Widget? iconPng;
  MenuItem(
      {super.key,
      iconPng,
      required this.onTap,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        style: ListTileStyle.drawer,
        iconColor: Colors.black,
        leading: CircleAvatar(
          backgroundColor: const Color(0xffEDEDED),
          child: iconPng ??
              SvgPicture.asset(
                icon,
                colorFilter: const ColorFilter.mode(
                    AppColors.primaryColor, BlendMode.srcIn),
              ),
        ),
        trailing: InkWell(
          onTap: onTap,
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xff9E9E9E),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
              color: Color(0xff171D29),
              fontWeight: FontWeight.w600,
              fontSize: 14),
        ),
        onTap: onTap);
  }
}
