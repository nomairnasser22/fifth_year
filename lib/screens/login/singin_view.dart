import 'package:fifthproject/core/classes/my_new_api.dart';
import 'package:fifthproject/core/classes/stutesrequest.dart';
import 'package:fifthproject/core/function/checkinternet.dart';
import 'package:fifthproject/core/function/handlingdata.dart';
import 'package:fifthproject/core/model/token_login.dart';
import 'package:fifthproject/keys_storage.dart';
import 'package:fifthproject/screens/bottom_bar/bottom_bar_view.dart';
import 'package:fifthproject/screens/login/signup_view.dart';
import 'package:fifthproject/screens/login/signup_view2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../common_widget/rounded_textField.dart';
import '../../../common_widget/primary_button.dart';
import '../../../common/color_extensions.dart';
import '../../../common_widget/secondary_button.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  ApiClient _api = ApiClient();
  String? info;
  Tokens? token;
  late StatusRequest statusRequest;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRemembered = false;
  GetStorage? getStorage = GetStorage();

  Future<void> _hadling() async {
    statusRequest = StatusRequest.loading;
    print("now i enter to _handling method in login page");
    Map<String, dynamic> userData = {
      "username": emailController.text,
      "password": passwordController.text,
    };
    var res = await _api.login(userData);
    var right;
    print("the status request is ${res}");
    res.fold((l) {
      info = l.username;
      token = l.tokens;
    }, (r) {
      right = r;
    });
    statusRequest = handlingData(right);
    print("the status request is ${statusRequest}");
    if (statusRequest == StatusRequest.success) {
      print("I think data hadn't show");
      print("the response is ${token!.access}");
      getStorage!.write(KeysStorage.accessLogin, token!.access);
      getStorage!.write(KeysStorage.refreshLogin, token!.refresh);
      print(getStorage!.read(KeysStorage.accessLogin));
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
              height: media.height * 0.15,
            ),
            RoundedTextField(
              title: "LogIn",
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedTextField(
              title: "Password",
              controller: passwordController,
              obscureText: true,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isRemembered = !isRemembered;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isRemembered
                            ? Icons.check_box_rounded
                            : Icons.check_box_outline_blank_rounded,
                        size: 20,
                        color: TColor.gray50,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Remember Me",
                        style: TextStyle(
                          color: TColor.gray50,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forget Password",
                      style: TextStyle(
                        color: TColor.gray50,
                        fontSize: 11,
                      ),
                    ))
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            PrimaryButton(
                title: "Log In",
                onPressed: () {
                  _hadling();
                }),
            SizedBox(
              height: media.height * 0.25,
            ),
            Text(
              "If you don't have an account yet",
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
                title: "SignUp",
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Singup2()));
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
