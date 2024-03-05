import 'package:fifthproject/login/signup_view.dart';
import 'package:flutter/material.dart'; 
import '../../common_widget/rounded_textField.dart';
import '../../common_widget/primary_button.dart';
import '../../common/color_extensions.dart';
import '../../common_widget/secondary_button.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isRemembered = false;
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.gray80,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img/app_logo.png",
              width: media.width * 0.5,
              fit: BoxFit.contain,
            ),
            const Spacer(),
            RoundedTextField(
              title: "LogIn",
              keyboardType: TextInputType.emailAddress,
              controller: txtEmail,
            ),
            const SizedBox(
              height: 10,
            ),
            RoundedTextField(
              title: "Password",
              controller: txtPassword,
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
            PrimaryButton(title: "Log In", onPressed: () {}),
            const Spacer(),
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
                      MaterialPageRoute(builder: (context) => Singup()));
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
