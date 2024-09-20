import '../../../core/styles/app_colors.dart';
import '../../../shared/presentation/widgets/cutom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool? showLeading;
  final bool? centerTitle;

  final Function()? onGoBack;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    this.showLeading,
    this.centerTitle,
    required this.title,
    this.onGoBack,
    this.actions,
  });

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      backgroundColor: Colors.transparent,
      title: CustomText(
        title: title,
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor:
            Colors.transparent, // Make the status bar transparent if needed
        statusBarIconBrightness:
            Brightness.dark, // For Android: make the icons dark
        statusBarBrightness:
            Brightness.dark, // For iOS: make the status bar icons dark
      ),
      toolbarHeight: MediaQuery.of(context).size.height * .053,
      leadingWidth: MediaQuery.of(context).size.width * .19,
      actions: actions,
      leading: showLeading != null || showLeading == false
          ? null
          : InkWell(
              onTap: onGoBack ?? () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.only(left: 10),
                margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .07,
                ),
                // width: 100.0,
                height: 20.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF9E9E9E),
                    width: 1.20,
                  ),
                ),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.primaryColor,
                  size: 30,
                ),
              ),
            ),
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// PreferredSizeWidget CustomAppBar(String title, BuildContext context) {
//   return AppBar(
//     backgroundColor: Colors.transparent,
//     title: CustomText(
//       title: title,
//       fontSize: 22,
//       fontWeight: FontWeight.w700,
//     ),
//     toolbarHeight: MediaQuery.of(context).size.height * .053,
//     leadingWidth: MediaQuery.of(context).size.width * .19,
//     leading: InkWell(
//       onTap: () => Navigator.pop(context),
//       child: Container(
//         padding: EdgeInsets.only(left: 10),
//         margin: EdgeInsets.only(
//           left: MediaQuery.of(context).size.width * .07,
//         ),
//         // width: 100.0,
//         height: 20.0,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           // shape: BoxShape.circle,
//           borderRadius: BorderRadius.circular(20),
//           border: Border.all(
//             color: Color(0xFF9E9E9E),
//             width: 1.20,
//           ),
//         ),
//         child: Icon(
//           Icons.arrow_back_ios,
//           color: primaryColor,
//           size: 30,
//         ),
//       ),
//     ),
//     elevation: 0,
//   );
// }
