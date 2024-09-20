import '../../../core/styles/app_colors.dart';
import '../../../shared/presentation/widgets/cutom_text.dart';
import 'package:flutter/material.dart';

import '../../../core/network/error/failures.dart';

class FaluireWidgetBuilder extends StatelessWidget {
  final Failure failure;
  final Function onTryAgain;
  final double? topMargin;
  const FaluireWidgetBuilder(
      {super.key,
      required this.onTryAgain,
      required this.failure,
      this.topMargin});

  @override
  Widget build(BuildContext context) {
    // if (failure is ConnectionFailure) {
    //   return NoInternetConnection(onTryAgain: onTryAgain);
    // } else {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * .2,
        left: MediaQuery.of(context).size.width * .2,
        top: topMargin ?? MediaQuery.of(context).size.height * .2,
      ),
      child: Column(
        children: [
          const Icon(
            Icons.error,
            size: 170,
            color: AppColors.grey500,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomText(
            title: failure.errorMessage,
            centerText: true,
            textColor: AppColors.grey500,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * .5,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: () => onTryAgain(),
                child: const Text(
                  "Try Again",
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
// }
