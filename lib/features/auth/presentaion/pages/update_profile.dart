import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:emebet/features/auth/data/model/parent.dart';
import 'package:emebet/features/auth/presentaion/bloc/auth_bloc.dart';
import 'package:emebet/features/auth/presentaion/bloc/auth_event.dart';
import 'package:emebet/features/auth/presentaion/bloc/auth_state.dart';
import 'package:emebet/shared/presentation/snackbar/error_message.dart';
import 'package:emebet/shared/presentation/widgets/app_bar.dart';
import 'package:emebet/shared/presentation/widgets/show_success_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/validators/phone_number_validator.dart';
import '../../../../core/utils/validators/validators.dart';
import '../../../../shared/presentation/widgets/custom_textfield.dart';
import '../../../../shared/presentation/widgets/cutom_text.dart';
import '../../../../shared/presentation/widgets/phone_number_text_field.dart';

class UpdateProfile extends StatefulWidget {
  static const String routeName = "Update Profile";
  const UpdateProfile();
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final _formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  bool isNextButtonClicked = false;
  final genderController = TextEditingController();
  final emailController = TextEditingController();
  List<FocusNode> focusNodes = [FocusNode(), FocusNode()];
  String hintAddress = "Adderss";
  String actualAddress = "";
  Parent parent = Parent();
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthGetParent());
  }

  @override
  void dispose() {
    fullNameController.dispose();
    for (var focus in focusNodes) {
      focus.dispose();
    }
    super.dispose();
  }

  String? selectedGender;
  List gender = ["male", "female"];
  String selectectedGender = "male";
  String languageCode = "";

  void updateParent(BuildContext ctx) {
    setState(() {
      isNextButtonClicked = true;
    });
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      parent.name = fullNameController.text;
      parent.address?.commonName = addressController.text;
      parent.gender = selectectedGender;
      parent.email = emailController.text;
      parent.phoneNumber = phoneNumberController.text;
      context.read<AuthBloc>().add(AuthUpdateParent(param: parent));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (pd) {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: const CustomAppBar(
          title: "Update Profile",
        ) as PreferredSizeWidget,
        body: Form(
          autovalidateMode:
              isNextButtonClicked ? AutovalidateMode.onUserInteraction : null,
          key: _formKey,
          child: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthUpdateParentFaulire) {
              errorMessageHandler(context, state.failure.errorMessage);
            }
            if (state is AuthUpdateParentSuccess) {
              DisplayMessage.show(context, "Profile updated successfully");
              Navigator.pop(context);
            }
            if (state is AuthGetParentSuccess) {
              parent = state.parent;

              fullNameController.text = state.parent.name ?? "";
              emailController.text = state.parent.email ?? "";
              selectectedGender = state.parent.gender ?? "male";

              addressController.text = state.parent.address?.commonName ?? "";

              phoneNumberController.text = state.parent.phoneNumber ?? "male";
              phoneNumberController.text = phoneNumberController.text
                  .replaceAll("251", "")
                  .replaceAll("+", "");

              phoneNumberOnChange(
                  phoneNumberController.text, phoneNumberController);
            }
          }, builder: (context, state) {
            if (state is AuthGetParentLoading) {
              return const Center(
                  child: CupertinoActivityIndicator(
                radius: 20,
              ));
            }
            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .20,
                  child: Stack(
                    children: [
                      Positioned(
                          top: 30,
                          left: 0,
                          right: 0,
                          child: Hero(
                            tag: "profile",
                            child: Container(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                  backgroundColor:
                                      AppColors.primaryColor.withOpacity(.5),
                                  radius: 60,
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    margin: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    alignment: Alignment.center,
                                    child: Text(
                                      (parent.name?.isEmpty ?? false)
                                          ? "A"
                                          : parent.name?[0] ?? "A",
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 70,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 10,
                            left: MediaQuery.of(context).size.width * .06,
                            right: MediaQuery.of(context).size.width * .06),
                        child: const CustomText(
                          title:
                              "Help us get to know you better by filling out the information below",
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: CustomTextField(
                            focusNode: focusNodes[0],
                            onFieldSubmit: (value) => FocusScope.of(context)
                                .requestFocus(focusNodes[1]),
                            isRequired: false,
                            maxLines: 1,
                            hintText: "Abebe kassa",
                            controller: fullNameController,
                            name: "Full name",
                            validator: (value) =>
                                Validators.nameValidator(value, context),
                          )),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          right: MediaQuery.of(context).size.width * .06,
                          left: MediaQuery.of(context).size.width * .06,
                        ),
                        width: double.infinity,
                        alignment: Alignment.centerLeft,
                        child: const CustomText(
                          title: "Phone Number",
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      PhoneNumberTextField(
                        editable: false,
                        textInputAction: TextInputAction.next,
                        // onFieldSubmit: (value) =>
                        //     FocusScope.of(context).requestFocus(focusNodes[1]),
                        controller: phoneNumberController,
                        validater: (value) =>
                            phoneNumberValidator(value, context),
                        onChange: phoneNumberOnChange,
                      ),
                      CustomTextField(
                        focusNode: focusNodes[1],
                        isRequired: false,
                        isEmail: true,
                        maxLines: 1,
                        onFieldSubmit: (value) =>
                            FocusScope.of(context).unfocus(),
                        // focusNode: focusNodes[0],
                        hintText: "john@gmail.com",
                        controller: emailController,
                        name: "Email",
                        // onFieldSubmit: (value) =>
                        //     FocusScope.of(context).requestFocus(focusNodes[1]),
                        validator: (value) => Validators.emailValidator(
                          emailController.text,
                          context,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          right: MediaQuery.of(context).size.width * .06,
                          left: MediaQuery.of(context).size.width * .06,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Gender",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                // color: KabbaColors.primaryColorDark,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: CustomDropdown(
                                decoration: CustomDropdownDecoration(
                                    closedBorder:
                                        Border.all(color: AppColors.darkGray)),
                                // controller: genderController,
                                initialItem: selectectedGender,
                                items: gender,
                                validateOnChange: true,
                                validator: (value) {
                                  if (value == null) {
                                    return "Please select your gender";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  selectectedGender = value.toString();
                                  parent.gender = selectectedGender;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  }
