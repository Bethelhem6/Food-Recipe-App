import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mvvm/features/auth/presentaion/pages/signup.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/constant/app_assets.dart';
import '../../../../core/utils/validators/password_validator.dart';
import '../../../../core/utils/validators/validators.dart';
import '../../../../shared/presentation/snackbar/error_message.dart';
import '../../../../shared/presentation/widgets/custom_botton.dart';
import '../../../../shared/presentation/widgets/custom_textfield.dart';
import '../../../../shared/presentation/widgets/cutom_text.dart';
import '../../../../shared/presentation/widgets/gap.dart';
import '../../../../shared/presentation/widgets/password_text_field.dart';
import '../../domain/function/get_fcm_id.dart';
import '../../domain/models/login_param.dart';
import '../../domain/models/screen_arguments.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/do_you_have_account.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginScreen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<FocusNode> focusNodes = [FocusNode(), FocusNode()];
  final formKey = GlobalKey<FormState>();
  bool isHide = false;
  bool formSumbitted = false;

  void loginParent() async {
    if (formKey.currentState?.validate() ?? false) {
      setState(() {
        formSumbitted = true;
      });
      context.read<AuthBloc>().add(
            AuthLogin(
              param: LoginParam(
                fcmId: await getFirebaseMessagingToken(),
                email: emailController.text,
                password: passwordController.text,
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        autovalidateMode:
            formSumbitted ? AutovalidateMode.onUserInteraction : null,
        child: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: SvgPicture.asset(
                  AppAssets.topLogin,
                  fit: BoxFit.cover,
                )),
            ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .35,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      AppColors.white,
                      AppColors.white,
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          right: 0,
                          top: 0,
                          child: SvgPicture.asset(AppAssets.bottomLogin)),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 50.h),
                          child: const CustomText(
                            title: " Mvvm",
                            fontSize: 45,
                            textColor: AppColors.primaryColor,
                          )),
                      Positioned(
                        left: 14.w,
                        bottom: 6.h,
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Login",
                              fontSize: 35,
                            ),
                            CustomText(
                              title: "please login to continue",
                              fontSize: 16,
                              fontWeight: FontWeight.w100,
                              textColor: AppColors.grey400,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Gap(
                  height: 10.h,
                ),
                Column(
                  children: [
                    CustomTextField(
                      isRequired: false,
                      isEmail: true,
                      maxLines: 1,
                      focusNode: focusNodes[0],
                      hintText: "john@gmail.com",
                      controller: emailController,
                      name: "Email",
                      onFieldSubmit: (value) =>
                          FocusScope.of(context).requestFocus(focusNodes[1]),
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
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: const CustomText(
                        title: "Password",
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    PasswordTextField(
                      focusNode: focusNodes[1],
                      hintText: "*********",
                      changeVisibility: () => setState(() {
                        isHide = !isHide;
                      }),
                      controller: passwordController,
                      showPassword: isHide,
                      onFieldSubmit: (value) => loginParent(),
                      validator: (value) =>
                          PasswordValidation.passwordValidator(value, context),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, SignupScreen.routeName,
                              arguments: RegisterArguments(
                                  fromScreen: 'forgetPassword'));
                        },
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: _authListener,
                      builder: _authBuilder,
                    ),
                    const DoYouHaveAccount(),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _authBuilder(context, state) {
    return CustomButton(
        title: "Sign in",
        loadingText: "signing in...",
        isLoading: state is AuthLoginLoading,
        onPressed: loginParent);
  }

  void _authListener(context, state) {
    if (state is AuthLoginSuccess) {
      BlocProvider.of<AuthBloc>(context).add(AuthGetKids());
      // Navigator.pushNamedAndRemoveUntil(
      //     context, HomeScreen.routeName, (route) => false);
    }
    if (state is AuthLoginFaulire) {
      errorMessageHandler(
        context,
        state.failure.errorMessage,
      );
    }
  }
}
