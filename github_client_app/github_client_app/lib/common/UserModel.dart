import 'package:github_client_app/common/ProfileChangeNotifier.dart';
import 'package:github_client_app/models/user.dart';

class UserModel extends ProfileChangeNotifier{

  User get user => profile.user;

  bool get isLogin => user !=null;

  set user(User user) {
    if(user?.login != profile.user?.login) {
      profile.lastLogin = profile.user?.login;
      profile.user = user;
      notifyListeners();
    }
  }
}