import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krutik_evital_practical/Home/home_page.dart';


class LoginController extends GetxController{

  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isPasswordHidden = true.obs;

  String mobile = '9033006262';
  String password = 'eVital@12';

  String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (value != mobile) {
      return 'Invalid mobile number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value != password) {
      return 'Invalid password';
    }
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() {
    if (formKey.currentState!.validate()) {
      Get.offAll(()=>const HomePage());
    }
  }
}