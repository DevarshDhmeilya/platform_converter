import 'package:flutter/material.dart';
import 'package:platform_converter/settings_page.dart';

import 'add_contact_page.dart';
import 'calls_page.dart';
import 'chats_page.dart';

class MainProvider extends ChangeNotifier {
  bool isIOS = true;
  bool isDarkView = false;
  String selectedDate = "Pick Date";
  String selectedTime = "Pick Time";

  changePlatform() {
    isIOS = !isIOS;
    notifyListeners();
  }

  changeTheme() {
    isDarkView = !isDarkView;
    notifyListeners();
  }

  setSelectedDate(DateTime selectedDate) {
    this.selectedDate = selectedDate.toString();
    notifyListeners();
  }

  setSelectedTime(TimeOfDay selectedTime) {
    this.selectedTime = selectedTime.toString();
    notifyListeners();
  }

  List<Widget> pageList = [
    AddContactPage(),
    ChatsPage(),
    CallsPage(),
    SettingsPage(),
  ];
}
