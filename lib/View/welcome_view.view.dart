import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mylex_practical/View/phone_auth.view.dart';
import 'package:mylex_practical/controllers/authentication_controller.controllers.dart';
import 'package:mylex_practical/utils/styles.utils.dart';
import '../utils/colors.utils.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final authController = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.kWhiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Lottie.asset("assets/hello.json",
                fit: BoxFit.contain, repeat: true),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Hey! Welcome",
                    style: AppStyles.headlineText,
                  ),
                  const SizedBox(height: 10),
                  Text(
                      "We deliver on-demand organic fresh fruits\n          directly from your nearby farms.",
                      style: AppStyles.subtitleText),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => authController.signInWithGoolge(context),
                    icon: const FaIcon(FontAwesomeIcons.google,
                        color: Colors.white),
                    label: const Text(
                      "Continue with Google",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(double.maxFinite, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: () => Get.to(
                        () => const PhoneAuthenticationScreen(),
                        transition: Transition.fadeIn),
                    icon: const FaIcon(FontAwesomeIcons.phone,
                        color: Colors.white),
                    label: const Text(
                      "Continue with Phone",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(double.maxFinite, 46),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
