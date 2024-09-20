 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvm/features/auth/presentaion/pages/change_password.dart';
import 'package:mvvm/features/auth/presentaion/pages/login.dart';
import 'package:mvvm/features/auth/presentaion/pages/update_profile.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/utils/constant/app_assets.dart';
import '../../../../shared/presentation/snackbar/error_message.dart';
import '../../../../shared/presentation/widgets/app_bar.dart';
import '../../../../shared/presentation/widgets/profile_menu_item.dart';
import '../../../../shared/presentation/widgets/show_custom_dialog.dart';
import '../../../feedback/presentation/pages/delete_account.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class Profile extends StatefulWidget {
  static const String routeName = "profile";
  final String name;

  const Profile({
    super.key,
    required this.name,
  });
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String imageUrl = "";
  // bool isUploading = false;
  ImagePicker picker = ImagePicker();
  XFile? image;
  String fileName = "";
  bool isDarkMode = false;
  bool isImageSelected = false;
  bool isImageLoading = false;
  String name = "";
  String phoneNumber = "";
  var formatter = NumberFormat('#,###,###,000');
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    init();
    // imageUrl = widget.profileArgument.imageUrl;
    // name = widget.profileArgument.name;
    // setState(() {});
  }

  showLogoutLoading() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: SizedBox(
                width: MediaQuery.of(context).size.width * .3,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text("please wait"),
                  ],
                )),
          );
        });
  }

  void showLogoutDialog(BuildContext ctx) {
    showCustomDialog(
        context: context,
        title: "logout",
        description: 'Are you certain that you want to log out?',
        primaryButtonText: "Confirm",
        primaryButtonOnPressed: () {
          Navigator.pop(ctx);
          showLogoutLoading();
          BlocProvider.of<AuthBloc>(context).add(AuthLogout());
        },
        secondaryButtonText: "cancel",
        secondaryButtonOnPressed: () => Navigator.pop(context));
  }

  init() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.reload();
      name = preferences.getString("name") ?? "Parent";
      phoneNumber = preferences.getString("phoneNumber") ?? "unknown";

      setState(() {});
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        onGoBack: () {
          context.read<AuthBloc>().add(AuthGetKids());
          Navigator.pop(context);
        },
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .27,
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
                                  borderRadius: BorderRadius.circular(100)),
                              alignment: Alignment.center,
                              child: Text(
                                name.isEmpty ? widget.name[0] : name[0],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )),
                      ),
                    )),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * .7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.call,
                              color: Color(0xffADADAD),
                            ),
                            Text(
                              phoneNumber,
                              style: const TextStyle(
                                color: Color(0xffADADAD),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          ProfileMenuItem(
              icon: AppAssets.users,
              onTap: () {
                Navigator.pushNamed(context, UpdateProfile.routeName).then((_) {
                  init();
                });
              },
              title: "Update Profile"),
          ProfileMenuItem(
            icon: AppAssets.key,
            onTap: () => Navigator.pushNamed(context, ChangePassword.routeName),
            title: "Change Password",
          ),
          ProfileMenuItem(
            icon: AppAssets.termsCondition,
            onTap: () async {
              try {
                launchUrl(
                    Uri.parse('https://legal.kabbatransport.com/privacy.html'));
              } catch (_) {}
            },
            title: "Terms and Condition",
          ),
          ProfileMenuItem(
            icon: AppAssets.lock,
            onTap: () {
              try {
                launchUrl(
                  Uri.parse('https://legal.kabbatransport.com/privacy.html'),
                );
              } catch (_) {}
            },
            title: "Privacy Policy",
          ),
          BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthLogoutSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, (_) => false);
            }
            if (state is AuthLogoutFaulire) {
              Navigator.pop(context);
              errorMessageHandler(
                context,
                state.failure.errorMessage,
              );
            }
          }, builder: (context, state) {
            return ProfileMenuItem(
              icon: AppAssets.logout,
              onTap: () => showLogoutDialog(context),
              title: "Logout",
            );
          }),
          ProfileMenuItem(
            icon: AppAssets.trash,
            onTap: () {
              Navigator.pushNamed(context, DeleteAccount.routeName);
            },
            title: "Delete Account",
          ),
        ],
      ),
    );
  }
}
