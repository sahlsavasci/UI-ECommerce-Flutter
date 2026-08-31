import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthProvider extends ChangeNotifier {
  User? _user = const User(
    id: '1',
    name: 'John Doe',
    email: 'johndoe@example.com',
    avatarUrl: 'assets/images/profile_picture.JPG',
  );

  User? get user => _user;
  bool get isAuthenticated => _user != null;

  Future<bool> login(String email, String password) async {
    // Simulated authentication
    _user = User(
      id: '1',
      name: email.split('@').first,
      email: email,
      avatarUrl: 'assets/images/profile_picture.JPG',
    );
    notifyListeners();
    return true;
  }

  Future<bool> register(String name, String email, String password) async {
    // Simulated registration
    _user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      avatarUrl: 'assets/images/profile_picture.JPG',
    );
    notifyListeners();
    return true;
  }

  void logout() {
    _user = null;
    notifyListeners();
  }

  void updateProfile({String? name, String? email}) {
    if (_user != null) {
      _user = _user!.copyWith(name: name, email: email);
      notifyListeners();
    }
  }
}
