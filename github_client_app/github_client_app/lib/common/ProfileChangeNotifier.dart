import 'package:flutter/material.dart';
import 'package:github_client_app/models/profile.dart';

import 'Global.dart';

class ProfileChangeNotifier extends ChangeNotifier{

  Profile get profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile();
    super.notifyListeners();
  }
}