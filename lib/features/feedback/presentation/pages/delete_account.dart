import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:emebet/core/styles/app_colors.dart';
import 'package:emebet/shared/presentation/widgets/app_bar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../../../shared/presentation/widgets/custom_botton.dart';
import '../../../../shared/presentation/widgets/custom_textfield.dart';
import '../../../../shared/presentation/widgets/cutom_text.dart';
import '../../domain/models/feedback_param.dart';
import '../bloc/feedback_bloc.dart';
import '../bloc/feedback_event.dart';
import '../bloc/feedback_state.dart';

class DeleteAccount extends StatefulWidget {
  static const String routeName = "DeleteAccount";
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

List<String> subjectData = [];

class _DeleteAccountState extends State<DeleteAccount> {
  final subjectController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isSubmitted = false;

  final descFocus = FocusNode();
  submitDeleteAccount() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      setState(() {
        isSubmitted = true;
      });
      FeedbackParam param = FeedbackParam(
        subject: subjectController.text,
        description: descriptionController.text,
      );
      BlocProvider.of<FeedbackBloc>(context).add(
        FeedbackSendFeedback(
          param: param,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    subjectData.add("No Longer Using the Service");
    subjectData.add("Privacy Concerns");
    subjectData.add("Other");

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Delete account",
      ) as PreferredSizeWidget,
      body: Form(
          key: formKey,
          autovalidateMode: isSubmitted
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .04,
                              left: MediaQuery.of(context).size.width * .06,
                              right: MediaQuery.of(context).size.width * .06),
                          child: const CustomText(
                            title: "Why you want to delete your account?",
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .03,
                              left: MediaQuery.of(context).size.width * .06,
                              right: MediaQuery.of(context).size.width * .06),
                          child: const Text(
                            'Select your reason',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: 5,
                              left: MediaQuery.of(context).size.width * .06,
                              right: MediaQuery.of(context).size.width * .06),
                          child: CustomDropdown(
                            hintText: "Why?",
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: AppColors.darkGray)),
                            items: subjectData.map((e) => e).toList(),
                            // controller: subjectController,
                            validator: (value) =>
                                value == null ? "please select subject" : null,
                            // borderSide:
                            //     BorderSide(width: 1, color: AppColors.grey400.),
                            onChanged: (String? on) {
                              subjectController.text = on ?? "";
                            },
                          ),
                        ),
                        CustomTextField(
                          maxLines: 5,
                          maxLength: 250,
                          focusNode: descFocus,
                          isRequired: false,
                          hintText: "Write your reason here...",
                          controller: descriptionController,
                          name: 'Write us a reason',
                          validator: (value) {
                            if (value.toString().trim().isEmpty) {
                              return 'Please share your reason with us';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                    BlocConsumer<FeedbackBloc, FeedbackState>(
                        listener: (context, state) {
                      if (state is FeedbackSendFeedbackSuccess) {
                        subjectController.text = "";
                        descriptionController.text = "";
                        isSubmitted = false;

                        PanaraInfoDialog.show(context,
                            message:
                                "Your account deletion request has been received. We will process your request and delete your account accordingly",
                            buttonText: "okay", onTapDismiss: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, panaraDialogType: PanaraDialogType.success);
                      }
                      if (state is FeedbackSendFeedbackFaulire) {
                        PanaraInfoDialog.show(context,
                            message:
                                "Your account deletion request has been received. We will process your request and delete your account accordingly",
                            buttonText: "Okay", onTapDismiss: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, panaraDialogType: PanaraDialogType.success);
                      }
                    }, builder: (contex, state) {
                      return CustomButton(
                          loadingText: 'Please wait....',
                          isLoading: state is FeedbackSendFeedbackLoading,
                          onPressed: () {
                            descFocus.unfocus();
                            submitDeleteAccount();
                          },
                          title: "Delete Account");
                    })
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
