// import 'dart:convert';

// import 'package:dio/dio.dart';
// import 'package:fifthproject/screens/login/singin_view.dart';
// import 'package:flutter/material.dart'; 
// import 'package:get/get.dart'; 
// import 'package:get_storage/get_storage.dart';    
// import '../../../common_widget/rounded_textField.dart';
// import '../../../common_widget/primary_button.dart';
// import '../../../common/color_extensions.dart';
// import '../../../common_widget/secondary_button.dart';
// import '../../../core/classes/api_provider.dart'; 
// import 'package:http/http.dart' as http;

// import '../../core/model/tokenmodel.dart';

// class Singup extends StatefulWidget {
//   const Singup({super.key});

//   @override
//   State<Singup> createState() => _SingupState();
// }

// class _SingupState extends State<Singup> {
//   final Dio _dio = Dio(
//     BaseOptions(
//         baseUrl: "https://jacoubakizi.pythonanywhere.com",
//         connectTimeout: const Duration(seconds: 6000),
//         receiveTimeout: const Duration(seconds: 6000),
//         responseType: ResponseType.json,
//         contentType: "application/json"
//         ),
//   );
//   late MyApiProvider repository;
//   final GetStorage getstorage = GetStorage();
//   TextEditingController userName = TextEditingController();
//   TextEditingController txtEmail = TextEditingController();
//   TextEditingController txtPassword = TextEditingController();
//   TextEditingController confPassword = TextEditingController();

//   Future<TokeModel> login(Map<String, dynamic> data) async {
//     try {
//       print("login from api on ");
//       final response = await _dio.post("/auth/sign-up/", data: data);
//       print("response is $response ");
//       return tokeModelFromJson(response.toString());
//     } on DioException catch (e) {
//       if (e.response?.statusCode == 401) {
//         return Future.error("invalid credential");
//       } else {
//         print("status code is ${e.response?.statusCode}");
//         return Future.error("invalid server error");
//       }
//     } catch (e) {
//       return Future.error(e.toString());
//     }
//   }

//   void validateLogin() async {
//     print('1');
//     var response = await http.post(
//       Uri.parse("https://jacoubakizi.pythonanywhere.com/auth/sign-up/"),
//       body: jsonEncode({
//         "email": txtEmail.text,
//         "username": userName.text,
//         "password": txtPassword.text,
//         "confpassword": confPassword.text
//       }),
//       headers: {"Content-Typec": "application/json"},
//     );
//     print('2');
//     if (response.statusCode == 200) {
//       print(response.body);
//     } else {
//       print("server error ");
//     }
//   }

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
//             RoundedTextField(
//               title: "User Name",
//               keyboardType: TextInputType.name,
//               controller: userName,
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             RoundedTextField(
//               title: "E-mail Address",
//               keyboardType: TextInputType.emailAddress,
//               controller: txtEmail,
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             RoundedTextField(
//               title: "Password",
//               obscureText: true,
//               controller: txtPassword,
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             RoundedTextField(
//               title: "Confirm Password",
//               obscureText: true,
//               controller: txtPassword,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     height: 5,
//                     margin: const EdgeInsets.symmetric(horizontal: 2),
//                     decoration: BoxDecoration(
//                       color: TColor.gray70,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: 5,
//                     margin: const EdgeInsets.symmetric(horizontal: 2),
//                     decoration: BoxDecoration(
//                       color: TColor.gray70,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: 5,
//                     margin: const EdgeInsets.symmetric(horizontal: 2),
//                     decoration: BoxDecoration(
//                       color: TColor.gray70,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     height: 5,
//                     margin: const EdgeInsets.symmetric(horizontal: 2),
//                     decoration: BoxDecoration(
//                       color: TColor.gray70,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   "use complex password to better protection",
//                   style: TextStyle(
//                     color: TColor.gray50,
//                     fontSize: 11,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             PrimaryButton(
//                 title: "Get Started, It's Free",
//                 onPressed: () {
//                   validateLogin();
//                 }),
//             const Spacer(),
//             Text(
//               "Do You Have An Account?",
//               style: TextStyle(
//                 color: TColor.white,
//                 fontSize: 14,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             SecondaryButton(
//                 title: "SignIn",
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => const Signin()));
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


// //  try {
// //       print("validateLogin on ");
// //       // Map<String, dynamic> datamap = {
// //       //   "email": txtEmail.text.toString(),
// //       //   "username": userName.text.toString(),
// //       //   "password": txtPassword.text.toString(),
// //       //   "confpassword": confPassword.text.toString()
// //       // };
// //       try {
// //         print("login from api on ");
// //         final response = await _dio.post("https://jacoubakizi.pythonanywhere.com/auth/sign-up/", data: {
// //           "email": txtEmail.text.toString(),
// //           "username": userName.text.toString(),
// //           "password": txtPassword.text.toString(),
// //           "confpassword": confPassword.text.toString()
// //         });
// //         print("response is $response ");
// //         // return tokeModelFromJson(response.toString());
// //       } on DioException catch (e) {
// //         if (e.response?.statusCode == 401) {
// //           return Future.error("invalid credential");
// //         } else {
// //           print("status code is ${e.response}");
// //           print("status code is ${e.response?.statusCode}");
// //           return Future.error("invalid server error");
// //         }
// //       } catch (e) {
// //         return Future.error(e.toString());
// //       }

// //     //   login(data).then((value) {
// //     //     print("the value is $value");
// //     //     print("the information_user is ${value.informationUser}");
// //     //     print("the email is ${value.informationUser.email}");
// //     //     print("the username is ${value.informationUser.username}");
// //     //     print("the information_user is ${value.tokens}");
// //     //     print("the token access is ${value.tokens.accsess}");
// //     //     print("the refresh token is ${value.tokens.refresh}");
// //     //   }).onError((error, stackTrace) {
// //     //     print("this is error : ${error.toString()}");
// //     //     return null;
// //     //   });
// //     } catch (e) {
// //       return Future.error(e.toString());
// //     }
