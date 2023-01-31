import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mylex_practical/View/complete_your_profile_view.view.dart';
import 'package:mylex_practical/View/welcome_view.view.dart';
import '../View/otp_view.view.dart';
import '../utils/toast_msg.utils.dart';

class AuthenticationController extends GetxController {
  //create firebase instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String verificationId = "";
  bool isLoading = false;
  //realtime database
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");

  //crate a function for verify phone

  void verifyPhoneNumber() async {
    isLoading = true;
    update();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: "+91${phoneController.text}",
        verificationCompleted: (PhoneAuthCredential credential) {
          _auth.signInWithCredential(credential);
          showAlert("Verified");
        },
        verificationFailed: (FirebaseAuthException exception) {
          showAlert("Verification Failed");
        },
        codeSent: (String _verificationId, int? forcedRespondToken) {
          showAlert("Verification code sent");
          verificationId = _verificationId;
          Get.to(() => const OtpVerificationScreen());
        },
        codeAutoRetrievalTimeout: (String _verificationId) {
          verificationId = _verificationId;
        },
      );
    } catch (e) {
      showAlert("Error Occurred $e");
    }
  }

  //for signin
  void signInWithPhoneNumber(BuildContext context) async {
    try {
      final AuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text,
      );
      //for signIn with credential
      var signInUser = await _auth.signInWithCredential(authCredential);

      //for storing the user data
      final User? user = signInUser.user;
//store user data to realtime database
      dbRef.child(user!.uid.toString()).set({
        "uid": user.uid.toString(),
        "email": "",
        "phoneNumber": user.phoneNumber.toString(),
      }).then((value) {
        showAlert("Successfully, User UID : ${user.uid}");

        Get.to(() => const CompleteYourProfileScreen());
      });
    } catch (e) {
      showAlert("Error Occurred $e");
    }
  }

  // google sign in

  Future<bool> signInWithGoolge(BuildContext context) async {
    bool result = false;

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // authenticate with firebase
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      //get the credentials to (access / id token) from firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // get the userCredentials from firebase

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      //store the userCredentials to firestore database
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await dbRef.child(user.uid.toString()).set({
            "uid": user.uid,
            "userName": user.displayName,
            "email": user.email,
          }).then((value) {
            showAlert("Successfully, User UID : ${user.uid}");
            Get.to(() => const CompleteYourProfileScreen());
          });
        }
        result = true;
      }
    } on FirebaseAuthException catch (e) {
      result = false;
      showAlert(e.message!);
    }
    return result;
  }

  // signOut from app

  void signOut(BuildContext context) async {
    try {
      _auth.signOut().then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
            (route) => false);
      });
    } catch (e) {
      showAlert(e.toString());
    }
  }
}
