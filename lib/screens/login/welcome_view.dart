// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:tracker/view/login/singin_view.dart';
// import '../../common/color_extensions.dart';
// import '../../common_widget/primary_button.dart';
// import '../../common_widget/secondary_button.dart';
// import 'social_media_login.dart';

// class WelcomeView extends StatefulWidget {
//   const WelcomeView({super.key});

//   @override
//   State<WelcomeView> createState() => _WelcomeViewState();
// }

// class _WelcomeViewState extends State<WelcomeView> {
//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Scaffold(
//       //5:40

//       body: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Image.asset(
//             "assets/img/welcome_screen.png",
//             width: media.width,
//             height: media.height,
//             fit: BoxFit.cover,
//           ),
//           SafeArea(
//               child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   "assets/img/app_logo.png",
//                   width: media.width * 0.5,
//                   fit: BoxFit.contain,
//                 ),
//                 const Spacer(),
//                 Text(
//                   "Tracker is the best way to keep in touch with \n your spending and all your financial problems",
//                   style: TextStyle(
//                     color: TColor.white,
//                     fontSize: 14,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(
//                   height: 30,
//                 ),
//                 PrimaryButton(
//                     title: "Get Started",
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => const SocialLogin()));
//                     }),
//                 const SizedBox(
//                   height: 15,
//                 ),
//                 SecondaryButton(
//                     title: "I have an account",
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => const Signin()));
//                     }),
//               ],
//             ),
//           )),
//         ],
//       ),
//     );
//   }
// }
