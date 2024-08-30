
import '../models/user_model.dart';

class AuthViewModel {
  UserModel? _user;

  UserModel? get user => _user;

  void signUp(String name, String email, String password) {
    _user = UserModel(name: name, email: email, password: password);
  }

  void signIn(String email, String password) {
    // Add sign-in logic here
  }

  void resetPassword(String email) {
    // Add password reset logic here
  }

  void verifyOtp(String otp) {
    // Add OTP verification logic here
  }

  void updatePassword(String newPassword) {
    // Add update password logic here
  }
}
