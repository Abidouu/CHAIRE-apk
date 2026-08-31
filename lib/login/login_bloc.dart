import 'package:cci_app/login/login_repository.dart';
import 'package:cci_app/login/wating_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cci_app/confirmation/confirm_screen.dart';

class LoginController extends GetxController {
  final LoginRepository loginRepository = LoginRepository();
  final box = GetStorage();

  var isLoading = false.obs;
  var loginFailed = false.obs;

  void login(String email, String password) async {
    isLoading.value = true;
    loginFailed.value = false; // Reset the loginFailed flag

    Map connection = await loginRepository.login(email, password);
    if (connection['status'] == 'connected') {
      isLoading.value = false;
      saveLoginCredentials(email, password); // Save the login credentials
      Get.to(() => WaitingScreen());
    } else {
      isLoading.value = false;
      loginFailed.value = true; // Set the loginFailed flag
      print("Incorrect email or password");
      // Navigate to the forbidden page (Replace with your desired navigation logic)
      // ...
    }
  }

  void checkAutoLogin() {
    String? savedEmail = box.read('email');
    String? savedPassword = box.read('password');

    if (savedEmail != null && savedPassword != null) {
      login(savedEmail, savedPassword);
    }
  }

  void saveLoginCredentials(String email, String password) {
    box.write('email', email);
    box.write('password', password);
  }
}
