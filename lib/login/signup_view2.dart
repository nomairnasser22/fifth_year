import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fifthproject/keys_storage.dart';
import 'package:fifthproject/login/singin_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../common_widget/rounded_textField.dart';
import '../../common_widget/primary_button.dart';
import '../../common/color_extensions.dart';
import '../../common_widget/secondary_button.dart';
import '../../core/classes/api_provider.dart';
import 'package:http/http.dart' as http;

import '../core/classes/my_new_api.dart';
import '../core/model/tokenmodel.dart';

class Singup2 extends StatefulWidget {
  const Singup2({super.key});

  @override
  State<Singup2> createState() => _Singup2State();
}

class _Singup2State extends State<Singup2> {
  GetStorage? getStorage = GetStorage();
  InformationUser? info;
  Tokens? token;
  late MyApiProvider repository;
  ApiClient _api = ApiClient();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  Future<void> _hadling() async {
    print("now i enter to _handling method ");
    Map<String, dynamic> userData = {
      "email": emailController.text,
      "username": userController.text,
      "password": passwordController.text,
      "confpassword": confPasswordController.text
    };
    var res = await _api.registerUser(userData);
    info = res.informationUser;
    token = res.tokens;
    print("-------------------the process is successfully------------");
    print("the TokenModel is ${token!.accsess}");
    print("the TokenModel is ${info!.email}");
    getStorage!.write(KeysStorage.accessSignup, token!.accsess);
    getStorage!.write(KeysStorage.refreshSignup, info!.email);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.gray80,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/app_logo.png",
              width: media.width * 0.5,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            RoundedTextField(
              title: "User Name",
              keyboardType: TextInputType.name,
              controller: userController,
            ),
            const SizedBox(
              height: 15,
            ),
            RoundedTextField(
              title: "E-mail Address",
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            RoundedTextField(
              title: "Password",
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(
              height: 15,
            ),
            RoundedTextField(
              title: "Confirm Password",
              obscureText: true,
              controller: confPasswordController,
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: TColor.gray70,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: TColor.gray70,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: TColor.gray70,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 5,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: TColor.gray70,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "use complex password to better protection",
                  style: TextStyle(
                    color: TColor.gray50,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryButton(
                title: "Get Started, It's Free",
                onPressed: () {
                  _hadling();
                }),
            const Spacer(),
            Text(
              "Do You Have An Account?",
              style: TextStyle(
                color: TColor.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            SecondaryButton(
                title: "SignIn",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Signin()));
                }),
            const SizedBox(
              height: 15,
            ),
            Text(
              "By registering you agree with our terms of use",
              style: TextStyle(
                color: TColor.white,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )),
    );
  }
}

// Future<void> _handleRegister() async {
//   //the user data to be sent

//   //get response from ApiClient
//   // dynamic res = await _apiClient.registerUser(userData);
//   ScaffoldMessenger.of(context as BuildContext).hideCurrentSnackBar();

//   // //checks if there is no error in the response body.
//   // //if error is not present, navigate the users to Login Screen.
//   // if (res['ErrorCode'] == null) {
//   //   Navigator.push(context as BuildContext,
//   //       MaterialPageRoute(builder: (context) => const LoginScreen()));
//   // } else {
//   //   //if error is present, display a snackbar showing the error messsage
//   //   ScaffoldMessenger.of(context as BuildContext).showSnackBar(SnackBar(
//   //     content: Text('Error: ${res['Message']}'),
//   //     backgroundColor: Colors.red.shade300,
//   //   ));
//   // }}
// }
