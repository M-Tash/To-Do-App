import 'package:flutter/foundation.dart';
import 'package:todo_app/model/my_user.dart';

class UserProvider extends ChangeNotifier {
  MyUser? currentUser;

  void updateUser(MyUser newUser) {
    currentUser = newUser;
    notifyListeners();
  }
}
