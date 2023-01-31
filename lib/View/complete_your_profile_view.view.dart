import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mylex_practical/controllers/complete_your_profile_controller.controllers.dart';
import 'package:mylex_practical/utils/colors.utils.dart';
import 'package:mylex_practical/utils/styles.utils.dart';
import 'package:mylex_practical/widgets/custom_widget.widgets.dart';

class CompleteYourProfileScreen extends StatefulWidget {
  const CompleteYourProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteYourProfileScreen> createState() =>
      _CompleteYourProfileScreenState();
}

class _CompleteYourProfileScreenState extends State<CompleteYourProfileScreen> {
  final profileController = Get.put(ProfileController());
  // final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (value) {
              if (!value.isLoading) {
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: size.height / 7,
                          width: size.width / 3,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: AppColors.kPrimaryColor,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(1000),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: AppColors.kWhiteColor,
                              size: size.width / 12,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Text("Complete your Profile",
                            style: AppStyles.headlineText),
                      ),
                      const SizedBox(height: 30),
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
                          controller: profileController.nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: value.auth.currentUser!.displayName ??
                                "Your name",
                            counterText: "",
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
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
                          controller: profileController.emailAddressController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: value.auth.currentUser!.email ??
                                "Enter email address",
                            counterText: "",
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
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
                          controller: profileController.phoneNumberController,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: value.auth.currentUser!.phoneNumber ??
                                "Enter phone number",
                            counterText: "",
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
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
                          controller: profileController.addressController,
                          maxLength: 30,
                          keyboardType: TextInputType.streetAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter your address ",
                            counterText: "",
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        borderRadius: BorderRadius.circular(10),
                        function: () {
                          profileController.updateUserProfile();
                        },
                        buttonWidth: 2,
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
