import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final String primaryButtonText;
  final VoidCallback primaryButtonOnPressed;
  final String secondaryButtonText;
  final VoidCallback secondaryButtonOnPressed;

  const CustomDialog({
    super.key,
    required this.title,
    required this.description,
    required this.primaryButtonText,
    required this.primaryButtonOnPressed,
    required this.secondaryButtonText,
    required this.secondaryButtonOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            top: 20.0,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          margin: const EdgeInsets.only(top: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24.0,
                      color: Color(0xff171D29),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Icon(
                    Icons.info,
                    color: Colors.red,
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Color(0xffADADAD),
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.green),
                    onPressed: secondaryButtonOnPressed,
                    child: Text(
                      secondaryButtonText,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    onPressed: primaryButtonOnPressed,
                    child: Text(
                      primaryButtonText,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
