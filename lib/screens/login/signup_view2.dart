import 'package:fifthproject/core/classes/stutesrequest.dart';
import 'package:fifthproject/core/function/handlingdata.dart';
import 'package:fifthproject/keys_storage.dart';
import 'package:fifthproject/screens/login/singin_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../common_widget/rounded_textField.dart';
import '../../../common_widget/primary_button.dart';
import '../../../common/color_extensions.dart';
import '../../../common_widget/secondary_button.dart';
import '../../../core/classes/api_provider.dart';
import '../../core/classes/my_new_api.dart';
import '../../core/model/tokenmodel.dart';
import 'package:get/get.dart';

import '../bottom_bar/bottom_bar_view.dart';

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
  late StatusRequest statusRequest;
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPasswordController = TextEditingController();

  Future<void> _hadling() async {
    statusRequest = StatusRequest.loading;

    print("now i enter to _handling method ");

    // here where the datat that must be sent ;
    Map<String, dynamic> userData = {
      "email": emailController.text,
      "username": userController.text,
      "password": passwordController.text,
      "confpassword": confPasswordController.text
    };

    var res = await _api.registerUser(userData);
    var right;
    print("the status request is ${res}");
    res.fold((l) {
      info = l.informationUser;
      token = l.tokens;
    }, (r) {
      right = r;
    });
    statusRequest = handlingData(right);
    print("the status request is ${statusRequest}");
    if (statusRequest == StatusRequest.success) {
      print("-------------------the process is successfully------------");
      print("the TokenModel is ${token!.accsess}");
      print("the TokenModel is ${info!.email}");
      getStorage!.write(KeysStorage.accessSignup, token!.accsess);
      getStorage!.write(KeysStorage.refreshSignup, token!.refresh);
      Get.to(BottomBarView());
    } else if (statusRequest == StatusRequest.loading) {
      CircularProgressIndicator();
    } else if (statusRequest == StatusRequest.serverfailure) {
      print("there is failure server ");
      Text("there is failure server ");
    } else if (statusRequest == StatusRequest.offlinefailure) {
      print("there is offline failure ");
      Text("there is offline failure");
    } else {
      print("the status request is ${statusRequest}");
      Text("something wrong");
    }
    // info = res.informationUser;
    // token = res.tokens;
    // print("-------------------the process is successfully------------");
    // print("the TokenModel is ${token!.accsess}");
    // print("the TokenModel is ${info!.email}");
    // getStorage!.write(KeysStorage.accessSignup, token!.accsess);
    // getStorage!.write(KeysStorage.refreshSignup, info!.email);
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: media.width * 0.1),
              child: Image.asset(
                "assets/img/app_logo.png",
                width: media.width * 0.5,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 70,
            ),
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
                  // if (info == null) {
                  //   RefreshProgressIndicator();
                  // } else {
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => const BottomBarView()));
                  // }
                }),
            const SizedBox(
              height: 100,
            ),
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
                title: "Log In",
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
