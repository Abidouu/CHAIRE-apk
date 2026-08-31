import 'package:cci_app/services/user_services.dart';
import 'package:get/get.dart';

import '../login/login_repository.dart';
import '../models/user.dart';

class ConfirmBlock extends GetxController {
  var isLoadingUserIfo = true.obs;
  String? userid;
  User? user;

  Future loadUserInfo() async {
    userid = await LoginRepository().getConnectedUserId();

    if (userid != null) {
      user = await UserServices().getUserById(userid!);
      if (user != null) {
        isLoadingUserIfo.value = false;
      }
    }
  }

  CollectBlock() {
    loadUserInfo();
  }
}
