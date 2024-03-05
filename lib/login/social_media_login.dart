// import 'package:flutter/material.dart';
// import 'package:tracker/view/login/signup_view.dart';

// import '../../common/color_extensions.dart';
// import '../../common_widget/secondary_button.dart';

// class SocialLogin extends StatefulWidget {
//   const SocialLogin({super.key});

//   @override
//   State<SocialLogin> createState() => _SocialLoginState();
// }

// class _SocialLoginState extends State<SocialLogin> {
//   @override
//   Widget build(BuildContext context) {
//     var media = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: TColor.gray80,
//       body: SafeArea(
//           child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Image.asset(
//               "assets/img/app_logo.png",
//               width: media.width * 0.5,
//               fit: BoxFit.contain,
//             ),
//             const Spacer(),
//             InkWell(
//               onTap: () {},
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     image: const DecorationImage(
//                       image: AssetImage("assets/img/google_btn.png"),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: TColor.white.withOpacity(0.5),
//                         blurRadius: 5,
//                         offset: const Offset(0, 4),
//                       ),
//                     ]),
//                 alignment: Alignment.center,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       "assets/img/google.png",
//                       width: 20,
//                       height: 20,
//                       color: TColor.gray80,
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     Text(
//                       "SignUp With Google",
//                       style: TextStyle(
//                           color: TColor.gray80,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             InkWell(
//               onTap: () {},
//               child: Container(
//                 height: 50,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(30),
//                     image: const DecorationImage(
//                       image: AssetImage("assets/img/fb_btn.png"),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.blue.withOpacity(0.5),
//                         blurRadius: 5,
//                         offset: const Offset(0, 4),
//                       ),
//                     ]),
//                 alignment: Alignment.center,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       "assets/img/fb.png",
//                       width: 20,
//                       height: 20,
//                     ),
//                     const SizedBox(
//                       width: 8,
//                     ),
//                     Text(
//                       "SignUp With FaceBook",
//                       style: TextStyle(
//                           color: TColor.white,
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Text(
//               "Or",
//               style: TextStyle(color: TColor.white),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             SecondaryButton(
//                 title: "SignUp With E-mail",
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: ((context) => const Singup())));
//                 }),
//             const SizedBox(
//               height: 15,
//             ),
//             Text(
//               "By registering you agree with our terms of use",
//               style: TextStyle(
//                 color: TColor.white,
//                 fontSize: 14,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }
