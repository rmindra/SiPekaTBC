import 'package:sipekatbc/models/profile_model.dart';

class UserSession {
  static Profile? currentUser;

  static bool get isLoggedIn => currentUser != null;

  static void clear() {
    currentUser = null;
  }
}
