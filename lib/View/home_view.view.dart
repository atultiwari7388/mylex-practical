import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mylex_practical/controllers/authentication_controller.controllers.dart';
import 'package:mylex_practical/utils/colors.utils.dart';
import '../utils/styles.utils.dart';
import 'package:get/get.dart';
import '../widgets/top_square_widget.widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbRef = FirebaseDatabase.instance.ref("Users");
  final authController = Get.put(AuthenticationController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.kPrimaryColor),
          actions: [
            IconButton(
              onPressed: () {
                AlertDialog(
                  title: Text("Mylex"),
                  content: Text("Are you sure , you want to logout this app"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'No',
                        style:
                            AppStyles.subtitleText.copyWith(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () => authController.signOut(context),
                      child: Text(
                        'Yes',
                        style: AppStyles.subtitleText
                            .copyWith(color: Colors.green),
                      ),
                    ),
                  ],
                );
              },
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: SafeArea(
          child: StreamBuilder(
              stream:
                  dbRef.child(FirebaseAuth.instance.currentUser!.uid).onValue,
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //heading section
                        RichText(
                            text: TextSpan(
                                text: "Hi !, ",
                                children: [
                                  TextSpan(
                                    text: map["userName"],
                                    style: AppStyles.subtitleText.copyWith(
                                      color: AppColors.kRedColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                                style: AppStyles.headlineText)),
                        SizedBox(height: 20),

                        Text(
                          "What would you like to Explore.",
                          style: AppStyles.headlineText.copyWith(
                              color: AppColors.kBlackColor.withOpacity(0.77)),
                        ),
                        SizedBox(height: 20),
                        //search section
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.kShadowColor,
                                        offset: Offset(1, 1),
                                        blurRadius: 3),
                                  ],
                                ),
                                child: TextFormField(
                                  onChanged: (newValue) {
                                    setState(() {});
                                  },
                                  cursorColor: AppColors.kPrimaryColor,
                                  decoration: InputDecoration(
                                    hintText: "Find for the best items",
                                    filled: true,
                                    fillColor: AppColors.kWhiteColor,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    prefixIcon: const Icon(Icons.search,
                                        color: AppColors.kBlackColor),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: AppColors.kWhiteColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: AppColors.kShadowColor),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15 - 5),
                            TopSquareBoxWidget(
                              height: 45,
                              width: 45,
                              color: AppColors.kWhiteColor,
                              borderRadius: 10,
                              blurRadius: 3,
                              shadowColor: AppColors.kShadowColor,
                              child: const Icon(Icons.add_road_rounded,
                                  color: AppColors.kBlackColor),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        //Details Section

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                5,
                                (index) => Container(
                                      margin: EdgeInsets.only(left: 20),
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            map["userName"],
                                            style: AppStyles.subtitleText
                                                .copyWith(
                                                    color:
                                                        AppColors.kWhiteColor),
                                          ),
                                          Text(map["email"],
                                              style: AppStyles.subtitleText
                                                  .copyWith(
                                                      color: AppColors
                                                          .kWhiteColor)),
                                          Text(map["phoneNumber"],
                                              style: AppStyles.subtitleText
                                                  .copyWith(
                                                      color: AppColors
                                                          .kWhiteColor)),
                                          Text(map["userAddress"],
                                              style: AppStyles.subtitleText
                                                  .copyWith(
                                                      color: AppColors
                                                          .kWhiteColor)),
                                        ],
                                      ),
                                    )),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                      "Something went wrong",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
