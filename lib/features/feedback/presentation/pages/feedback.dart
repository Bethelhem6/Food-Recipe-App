import 'package:animated_custom_dropdown/custom_dropdown.dart'; 

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../shared/presentation/snackbar/error_message.dart';
import '../../../../shared/presentation/widgets/app_bar.dart';
import '../../../../shared/presentation/widgets/custom_botton.dart';
import '../../../../shared/presentation/widgets/custom_textfield.dart';
import '../../../../shared/presentation/widgets/cutom_text.dart';
import '../../domain/models/feedback_param.dart';
import '../bloc/feedback_bloc.dart';
import '../bloc/feedback_event.dart';
import '../bloc/feedback_state.dart';

class FeedBack extends StatefulWidget {
  static const String routeName = "feedback";
  const FeedBack({super.key});

  @override
  State<FeedBack> createState() => _FeedBackState();
}

List<String> subjectData = [];

class _FeedBackState extends State<FeedBack> {
  final descriptionController = TextEditingController();
  final subjectController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool isSubmitted = false;

  final descFocus = FocusNode();
  submitFeedBack() async {
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
    subjectData.add("App issues");
    subjectData.add("complain");
    subjectData.add("thank you");
    subjectData.add("other");

    return Scaffold(
      appBar: const CustomAppBar(
        title: "Feedback",
      ) as PreferredSizeWidget,
      body: Form(
          key: formKey,
          autovalidateMode:
              isSubmitted ? AutovalidateMode.onUserInteraction : null,
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
                            title: "Write us your feedback",
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
                            hintText: "subject",
                            validator: (value) =>
                                value == null ? "please select subject" : null,
                            decoration: CustomDropdownDecoration(
                                closedBorder:
                                    Border.all(color: AppColors.darkGray)),
                            items: subjectData.map((e) => e).toList(),
                            // controller: subjectController,

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
                          hintText: "Write your feedback here...",
                          controller: descriptionController,
                          name: 'Your Feedback',
                          validator: (value) {
                            if (value.toString().trim().isEmpty) {
                              return 'Please share your feedback with us';
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
                      if (state is FeedbackSendFeedbackFaulire) {
                        errorMessageHandler(
                            context, state.failure.errorMessage);
                      }
                      if (state is FeedbackSendFeedbackSuccess) {
                        subjectController.text = "";
                        descriptionController.text = "";
                        isSubmitted = false;

                        PanaraInfoDialog.show(context,
                            panaraDialogType: PanaraDialogType.success,
                            message:
                                'Thank you! Your feedback has been submitted successfully',
                            buttonText: "Okay", onTapDismiss: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      }
                    }, builder: (context, state) {
                      return CustomButton(
                          loadingText: 'submitting',
                          isLoading: state is FeedbackSendFeedbackLoading,
                          onPressed: () {
                            descFocus.unfocus();
                            submitFeedBack();
                          },
                          title: "Submit Feedback");
                    })
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
