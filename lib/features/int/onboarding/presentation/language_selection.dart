// // ignore_for_file: use_build_context_synchronously

// import 'package:animated_custom_dropdown/custom_dropdown.dart';


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class LanguageSelectionScreen extends StatefulWidget {
//   const LanguageSelectionScreen({super.key});

//   @override
//   State<LanguageSelectionScreen> createState() =>
//       _LanguageSelectionScreenState();
// }

// class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
//   List<String> languages = ["English", "አማርኛ"];

//   String selectedLanguage = "Language";
//   String language = "";
//   final dropdownControl = TextEditingController();
//   AppLanguage appLanguage = AppLanguage();

//   @override
//   void initState() {
//     super.initState();
//     appLanguage = Provider.of<AppLanguage>(context, listen: false);
//     fetchLanguage();
//   }

//   fetchLanguage() async {
//     await appLanguage.fetchLocale();
//     language = appLanguage.appLocal.languageCode.toLowerCase();

//     if (language == "am") {
//       setState(() {
//         selectedLanguage = "አማርኛ";
//       });
//     } else if (language == "en") {
//       setState(() {
//         selectedLanguage = "English";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade300,
//       body: Center(
//           child: Container(
//         width: MediaQuery.of(context).size.width * .8,
//         height: 300,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Text(
//               EmebetLocalization.of(context)!.translate("select_language"),
//               style: const TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25),
//             ),
//             Container(
//               margin: const EdgeInsets.only(right: 10),
//               width: 200,
//               child: CustomDropdown(
//                 onChanged: (value) {
//                   setState(() {
//                     selectedLanguage = value!;
//                     if (selectedLanguage == "English") {
//                       appLanguage.changeLanguage(const Locale("en"));
//                     } else if (selectedLanguage == "አማርኛ") {
//                       appLanguage.changeLanguage(const Locale("am_ET"));
//                     }
//                   });
//                 },
//                 hintText: selectedLanguage,
//                 decoration: CustomDropdownDecoration(
//                   closedBorder: Border.all(color: AppConstants.grey300),
//                   hintStyle: const TextStyle(
//                     color: AppConstants.grey400,
//                     fontWeight: FontWeight.normal,
//                     fontSize: AppConstants.mediumFont,
//                   ),
//                 ),
//                 items: languages,
//                 excludeSelected: true,
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 _setLanguageAndNavigate(context, selectedLanguage);
//               },
//               child: Container(
//                 width: 200,
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.symmetric(vertical: 15),
//                 decoration: BoxDecoration(
//                     color: AppConstants.primaryGreen,
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Text(
//                   EmebetLocalization.of(context)!.translate("continue"),
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: AppConstants.mediumFont,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             )

//             // Add more language buttons as needed
//           ],
//         ),
//       )),
//     );
//   }

//   _setLanguageAndNavigate(BuildContext context, String language) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString(
//         'emebet_language', language); // Store language preference
//     Navigator.pushReplacement(context, customPageRoute(const LoginScreen()));
//   }
// }
