import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../main.dart';
import '../model/purchase_model/purchase_model.dart';

const userKey = "user";

class UserController extends ValueNotifier<PurchaseModel> {
  UserController(super.value) {
    onInit();
  }

  bool get premium => value.isPremium;

  set setUserData(PurchaseModel uservalue) {
    value = uservalue;
    notifyListeners();
    storageService.set(userKey, jsonEncode(value.toJson()));
  }

  void onInit() {
    checkUser();
    // TODO: implement onInit
  }

  checkUser() {
    final String? userString = storageService.get(userKey);
    if (userString != null) {
      final userdata = jsonDecode(userString);
      final PurchaseModel model = PurchaseModel.fromJson(userdata);
      setUserData = model;
    }
  }
}
