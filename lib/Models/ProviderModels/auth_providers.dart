import 'package:flutter/material.dart';
import 'package:flutter_application_to_do/Models/user_model.dart';

class AuthProviders extends ChangeNotifier {
  UserModel? currentUser;

  void updateUser(UserModel newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
