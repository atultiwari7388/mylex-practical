import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:mylex_practical/controllers/authentication_controller.controllers.dart';
import '../widgets/custom_widget.widgets.dart';

class PhoneAuthenticationScreen extends StatefulWidget {
  const PhoneAuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<PhoneAuthenticationScreen> createState() =>
      _PhoneAuthenticationScreenState();
}

class _PhoneAuthenticationScreenState extends State<PhoneAuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final authController = Get.put(AuthenticationController());

    return Scaffold(
      body: GetBuilder<AuthenticationController>(
          init: AuthenticationController(),
          builder: (value) {
            if (!value.isLoading) {
              return SafeArea(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //top section
                        Material(
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(120),
                          ),
                          color: Colors.deepPurple,
                          child: SizedBox(
                            height: size.height / 1.7,
                            width: size.width,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: size.height / 50,
                                ),
                                Lottie.asset("assets/sendSms.json",
                                    height: size.height / 2.5,
                                    fit: BoxFit.cover,
                                    width: double.maxFinite),
                                // SizedBox(height: size.height / 9),
                                Text(
                                  "E-commerce",
                                  style: TextStyle(
                                    letterSpacing: 1.2,
                                    fontSize: size.width / 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: size.height / 60),
                                Text(
                                  "It's all easy when it's at home",
                                  style: TextStyle(
                                    fontSize: size.width / 21,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //phone number field
                        SizedBox(height: size.height / 15),
                        Container(
                          height: size.height / 15,
                          width: size.width / 1.2,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color.fromRGBO(9, 32, 196, 1),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: authController.phoneController,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone Number",
                              counterText: "",
                            ),
                          ),
                        ),
                        SizedBox(height: size.height / 10),
                        CustomButton(
                          borderRadius: BorderRadius.circular(10),
                          function: () {
                            authController.verifyPhoneNumber();
                          },
                          buttonWidth: 2,
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
