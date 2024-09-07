import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier {
  String _message = '';

  String get message => _message;

  void setMessage(String value) {
    _message = value;
    notifyListeners();
  }

  void clearMessage() {
    _message = '';
    notifyListeners();
  }
}
