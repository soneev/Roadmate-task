import 'package:flutter/cupertino.dart';

class LandingProvider extends ChangeNotifier {
  var tabIndex = 0;

  changeTabIndex(int value) {
    tabIndex = value;
    notifyListeners();
  }
}
