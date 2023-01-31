import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mylex_practical/View/home_view.view.dart';
import 'package:mylex_practical/utils/toast_msg.utils.dart';

class ProfileController extends GetxController {
  //realtime database
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child("Users");
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void updateUserProfile() async {
    isLoading = true;
    update();
    try {
      await dbRef.child(auth.currentUser!.uid.toString()).update({
        "userName":
            auth.currentUser!.displayName ?? nameController.text.toString(),
        "email":
            auth.currentUser!.email ?? emailAddressController.text.toString(),
        "userAddress": addressController.text.toString(),
        "phoneNumber": auth.currentUser!.phoneNumber ??
            phoneNumberController.text.toString(),
      }).then((value) {
        isLoading = false;
        showAlert("User updated");
        Get.off(() => const HomeScreen());
      }).onError((error, stackTrace) {
        isLoading = false;
        showAlert(error.toString());
      });
    } catch (e) {
      showAlert(e.toString());
    }
  }
}
