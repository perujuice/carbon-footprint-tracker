import 'package:flutter/material.dart';



// This class can handle the user session to keep it open while the user is logged in.
class UserProvider with ChangeNotifier {
  late String _username;

  String get username => _username;

  void login(String username, String password) {
    // Here you would typically make a request to your backend to verify the
    // username and password, and throw an error if the credentials are invalid.

    // For the sake of this example, we'll just set the username directly.
    _username = username;

    // Notify listeners to update UI
    notifyListeners();
  }

  void logout() {
    _username = '';

    // Notify listeners to update UI
    notifyListeners();
  }
}